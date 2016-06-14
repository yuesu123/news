//
//  WSNewsController+CheckVersion.m
//  NetEaseNews
//
//  Created by HLH on 16/5/23.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSNewsController+CheckVersion.h"
#import "Globals.h"
#import "QTFHttpTool.h"

@implementation WSNewsController (CheckVersion)
//移动
- (void)isShoulfCheckVersion{
    // 去检测新版本
    BOOL isSameDay = NO;
    NSUserDefaults *user =   [NSUserDefaults standardUserDefaults];
    NSDate *oldDate = [user objectForKey:@"kUnCharchiveFilePathVersion"];
    DLog(@"oldDate = %@",oldDate);
    isSameDay  = [Globals isTheSameTodayFromTime:oldDate];//是同一天
    if ((self.isgetVersion == getVersionShould&&(!isSameDay))) {//不是同一天
        self.isgetVersion = getVersionBegin;
        DLog(@"去检测新版本!isSameDay = %d",!isSameDay);
        [self loadDataForVersion];
    }
}
#pragma mark 获取网络数据-检测新版本
-(void)loadDataForVersion
{
    [MBProgressHUD showMessage:loadingNetWorkStr toView:self.view];
    __weak typeof (self) w_self = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"last-version" forKey:@"method"];
    [params setObject:@"1" forKey:@"versionType"];//1是苹果
    [QTFHttpTool requestGETURL:@"api/iosversion" params:nil refreshCach:YES needHud:NO hudView:nil loadingHudText:nil errorHudText:nil sucess:^(id json) {
        BOOL success = [json[@"Success"] boolValue];
        NSDate *Newdate = [NSDate date];
        NSUserDefaults *user =   [NSUserDefaults standardUserDefaults];
        [user setObject:Newdate forKey:@"kUnCharchiveFilePathVersion"];
        self.isgetVersion = getVersionDid;
        //如果响应出错，则返回
        if (!success) {
            [MBProgressHUD hideHUDForView:w_self.view];
            [MBProgressHUD showError:json[@"msg"] toView:w_self.view];
            return ;
        }else{
            [self checkHasNewBanben:json];
            //存储旧的日期
        }
        ECLog(@"响应:%@",json);
        [MBProgressHUD hideHUDForView:w_self.view];
    }failur:^(NSError *error) {
        self.isgetVersion = getVersionShould;

    }];
}

//     NSOrderedAscending = -1,上升
//     NSOrderedSame,
//     NSOrderedDescending  = 1 //下降
//NSCaseInsensitiveSearch  不区分大小写
// NSLiteralSearch 区分大小写(完全比较)
// NSNumericSearch 只比较字符串的个数，而不比较字符串的字面值
- (void)checkHasNewBanben:(NSDictionary*)dic{
    NSString *maxBanben = dic[@"VersionName"];
    NSString *minBanben = dic[@"IosMinVersion"];
    NSString *content = dic[@"Content"];
   content = [QTCommonTools replaceStringWithOldLongStr:content oldSmallstr:@"<br>" withNew:@""];
    self.urlStr = dic[@"Url"];
    int resultVerNormal = [appCurVersionStr compare:maxBanben options:NSCaseInsensitiveSearch];//=-1 appCurVersionStr < maxBanben ;
    
    int resultVer = [appCurVersionStr compare:minBanben options:NSCaseInsensitiveSearch];//=-1  appCurVersionStr < minBanben;
    
    if(resultVerNormal == NSOrderedSame){//已经是最新的版本
        ECLog(@"已经是最新版本");
    }else if(resultVerNormal == -1&&resultVer == 1){//小于升级版本,大于最小版本,需要更新版本 //2.1.0
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"检测到新版本" message:content delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"立即升级",nil];
        alert.tag = 1;
        [alert show];
        DLog(@"不需要强制升级%d",resultVer);  //1.5
    }else if(resultVer == -1||resultVer == NSOrderedSame){ //等于或者小于最小版本 //强制升级
        self.isShouldForceUP = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"00000000000001111" forKey:@"kUnCharchiveFilePathVersion"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本已过期,请尽快升级" message:content delegate:self cancelButtonTitle:@"立即升级" otherButtonTitles:nil];
        DLog(@"强制升级的版本%d",resultVer);
        alert.tag = 2;
        [alert show];
    }
}


//移除
#pragma mark 选择哪一个alertView
- (void)alertView:(UIAlertView *)sender didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(sender.tag == 1){//普通升级
        if (buttonIndex == 0)  return;
        [self gotoDownLoadApp];
    }else{//强制升级
        [self gotoDownLoadApp];
    }
}


- (void)gotoDownLoadApp{
    NSURL * finalURL = [NSURL URLWithString:self.urlStr];
    if ([[UIApplication sharedApplication] canOpenURL:finalURL]){
        [[UIApplication sharedApplication] openURL:finalURL];
    }
}


#pragma mark 点击登录
-(void)gotoLogin
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 获取故事板中某个View
    UINavigationController* vc =  [board instantiateViewControllerWithIdentifier:@"loginNvc"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
