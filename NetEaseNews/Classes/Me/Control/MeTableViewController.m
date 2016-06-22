//
//  MeTableViewController.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/21.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "MeTableViewController.h"
#import "ServiceExampleViewController.h"
#import "QTLoginViewController.h"
#import "WSCommentController.h"
#import "QTZeroStudyListViewController.h"
#import "QTSettingTableViewController.h"
#import "CollectViewController.h"
#import "QTUMShareTool.h"

@interface MeTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation MeTableViewController
#pragma mark –
#pragma mark Action and UI Event
- (IBAction)loginBtnClicked:(UIButton *)sender {
    if(strNotNil([QTUserInfo sharedQTUserInfo].phoneNum)&&(strNotNil([QTUserInfo sharedQTUserInfo].passWD))){
        [self showHint:@"已经登录"];
        return;
    }
    [self gotoLoginVc];
}

#pragma mark –
#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [QTCommonTools clipAllView:_userHeaderImage Radius:_userHeaderImage.frame.size.width*0.5 borderWidth:0 borderColor:nil];
    self.tableView.tableFooterView = [[UIView alloc] init];
    if (strNotNil([QTUserInfo sharedQTUserInfo].passWD)&&strNotNil([QTUserInfo sharedQTUserInfo].phoneNum)) {
        [self.loginBtn setTitle:[QTUserInfo sharedQTUserInfo].phoneNum forState:UIControlStateNormal];
    }
    
}


- (void)gotoLoginVc{
    
    ECLog(@"点击用户头像");
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    QTLoginViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
       vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"登录";
     [vc loginSuccessBlock:^(NSDictionary *dic) {
         NSString *phone =[QTUserInfo sharedQTUserInfo].phoneNum;
         [_loginBtn setTitle:phone forState:UIControlStateNormal];
         [MBProgressHUD showSuccess:@"登录成功"];
     }];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)gotoCollectionView{
    UIViewController *vc = [[CollectViewController alloc]init];
    vc.title = @"收藏";
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)gotoSettingVc{
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    QTSettingTableViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"settingTableView"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"设置";
    [vc loginSuccessBlock:^(NSDictionary *dic) {
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)gotoZeroStudyListController{
    QTZeroStudyListViewController *vc = [[QTZeroStudyListViewController alloc] init];
    vc.title = @"收藏";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)gotoBaoliaoViewController{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"新闻报料";
    if (strNotNil([QTUserInfo sharedQTUserInfo].userId)) {
        vc.urlStr = [NSString stringWithFormat:@"%@?userid=%@",sg_privateAboutBaoliao,[QTUserInfo sharedQTUserInfo].userId];
    }else{
        vc.urlStr = [NSString stringWithFormat:@"%@",sg_privateAboutBaoliao];
        [self showLoginFirst];

    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)gotoMyBaoliaoViewController{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"我的报料";
    if (strNotNil([QTUserInfo sharedQTUserInfo].userId)) {
        vc.urlStr = [NSString stringWithFormat:@"%@?userid=%@",sg_privateAboutMyBaoliao,[QTUserInfo sharedQTUserInfo].userId];
    }else{
        vc.urlStr = [NSString stringWithFormat:@"%@",sg_privateAboutMyBaoliao];
        [self showLoginFirst];

    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showLoginFirst{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showError:@"请先登录"];
    });
}



//去天气webView控制器
- (void)gotoWeatherVc{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"天气";
   NSString*url = sg_privateAboutWether;
    NSString *urlnew = [NSString stringWithFormat:@"%@",url];
    vc.urlStr = urlnew;
    vc.type = caseAnalyse;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }else{
        return 4;
    }
}
//
#pragma mark –
#pragma mark System Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0&&0 == indexPath.section) {
        [self gotoWeatherVc];
    }else if(indexPath.row == 1&&0 == indexPath.section){
        [self gotoCollectionView];
    }else if(indexPath.row == 2&&0 == indexPath.section){
        [self gotoBaoliaoViewController];
    }else if(indexPath.row == 3&&0 == indexPath.section){
        [self gotoMyBaoliaoViewController];
    }else if(indexPath.row == 0&&1 == indexPath.section){
        [self gotoSettingVc];
    }
    
}
- (void)shareNew{
    NSString *invite_code =  standardUserForKey(@"invite_code");
    NSString *shareContendHasInviteCode = nil;
    shareContendHasInviteCode = @"广州阅速科技有限公司";
    [QTUMShareTool shareWithTitle:shareTitleDownload  //shareTitleHasCode
                          contend:shareContendHasInviteCode
                           urlStr:shareurlStr
                          platArr:nil   //shareBtnOrder
                         delegate:self
                            image:nil]; //[UIImage imageNamed:@"Icon-60"];
    
}







@end
