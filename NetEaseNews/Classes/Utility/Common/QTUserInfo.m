//
//  QTUserInfo.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-25.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import "QTUserInfo.h"
@implementation QTUserInfo

singleton_implementation( QTUserInfo)


    //写入用户登录信息到UserDefault
-(void)writeUserInfoToDefault
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];


    [def setObject:self.phoneNum forKey:@"phoneNum"];
    [def setObject:self.passWD forKey:@"passWD"];
     [def setObject:self.userId forKey:@"userId"];
     [def setObject:self.userName forKey:kusernameMe];
    [def setObject:self.type forKey:@"logintype"];
    [def setObject:self.nickName forKey:@"nickName"];

    [def setObject:self.openId forKey:@"openId"];
    [def setObject:self.iconImge forKey:@"iconImge"];

    [def setObject:self.reWriteinvite_code forKey:@"reWriteinvite_code"];

    
    [def setObject:self.invite_code forKey:@"invite_code"];

     [def setBool:self.gender forKey:@"gender"];
    [def setBool:self.hadLogin forKey:@"hadLogin"];
    [def setObject:self.point forKey:@"point"];
    [def setObject:self.pointUrl forKey:@"pointUrl"];
    [def setObject:self.coursesNo forKey:@"coursesNo"];
    [def setObject:self.consultationNo forKey:@"consultationNo"];
    [def setObject:self.account forKey:@"account"];

    [def setObject:self.roles forKey:@"roles"];
    
    [def setObject:self.Urerreg.Mobile forKey:@"Mobile"];
    [def setInteger:self.Urerreg.Userid forKey:@"Userid"];
    [def setInteger:self.Urerreg.Jifen forKey:@"Jifen"];

    
    [def synchronize];

}

    //得到用户信息
-(void)loadUserInfoFromDefault
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    self.phoneNum = [def objectForKey:@"phoneNum"];
    self.passWD = [def objectForKey:@"passWD"];
    self.userId =[def objectForKey:@"userId"];
    self.gender =[def boolForKey:@"gender"];
    self.userName = [def objectForKey:kusernameMe];
    self.nickName = [def objectForKey:@"nickName"];
    self.iconImge = [def objectForKey:@"iconImge"];
    self.type = [def objectForKey:@"logintype"];
    self.openId = [def objectForKey:@"openId"];
    self.invite_code = [def objectForKey:@"invite_code"];
    self.reWriteinvite_code = [def objectForKey:@"reWriteinvite_code"];
    self.hadLogin = [def boolForKey:@"hadLogin"];
    self.point = [def objectForKey:@"point"];
    self.pointUrl = [def objectForKey:@"pointUrl"];
    self.coursesNo = [def objectForKey:@"coursesNo"];
    self.consultationNo = [def objectForKey:@"consultationNo"];
    self.roles = [def objectForKey:@"roles"];
    self.account = [def objectForKey:@"account"];
    self.Urerreg.Userid = [def integerForKey:@"Userid"];
    self.Urerreg.Mobile = [def objectForKey:@"Mobile"];
    self.Urerreg.Jifen = [def objectForKey:@"Jifen"];


}
-(void)clearDefault
{
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
//    self.phoneNum = nil;
    self.passWD = nil;
    self.userId = nil;
    self.invite_code = nil;
    self.nickName = nil;
    self.gender = YES;
    self.reWriteinvite_code = nil;
    self.userName = nil;
    self.type = nil;
    self.openId = nil;
    self.iconImge = nil;
    self.hadLogin = NO;

//第一版的时候用户名 就是手机号  第二版 用户名可以是 openID

    [def setObject:nil forKey:kusernameMe];
//    [def setObject:nil forKey:@"phoneNum"];
    [def setObject:nil forKey:@"passWD"];
    [def setObject:nil forKey:@"userId"];
    [def setObject:nil forKey:@"userId"];
    [def setObject:nil forKey:@"reWriteinvite_code"];
    [def setObject:nil forKey:@"invite_code"];
    [def setObject:nil forKey:@"nickName"];
    [def setObject:nil forKey:@"iconImge"];
    [def setObject:nil forKey:@"account"];

    
    [def setObject:nil forKey:@"logintype"];
    [def setObject:nil forKey:@"openId"];

     [def setBool:NO forKey:@"hadLogin"];
    [def synchronize];

}







/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        DLog(@"json解析no success");
        return nil;
    }else{
        DLog(@"字典%@",dic);
    }
    return dic;
}



@end
@implementation Urerreg

@end


