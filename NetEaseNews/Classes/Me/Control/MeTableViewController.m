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

- (void)gotoColloctionVC{
    WSCommentController *vc = [[WSCommentController alloc] init];
    vc.docid = @"BNKAGEV500234KO7";
    //hideBottomBar
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoZeroStudyListController{
    QTZeroStudyListViewController *vc = [[QTZeroStudyListViewController alloc] init];
    vc.title = @"收藏";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


//去天气webView控制器
- (void)gotoWeatherVc{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"天气";
   NSString*url = sg_privateAboutWether;
    NSString *urlnew = [NSString stringWithFormat:@"%@%@",url,[QTUserInfo sharedQTUserInfo].userId];
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
        [self gotoWeatherVc];
    }else if(indexPath.row == 3&&0 == indexPath.section){
        [self shareNew];
    }else if(indexPath.row == 0&&1 == indexPath.section){
        [self gotoSettingVc];
    }
    
}
- (void)shareNew{
    NSString *invite_code =  standardUserForKey(@"invite_code");
    NSString *shareContendHasInviteCode = nil;
//    if(strNotNil(invite_code)){
//        shareContendHasInviteCode = [NSString stringWithFormat:@"%@,注册app补填邀请码:%@","11",invite_code];
//    }else{
        shareContendHasInviteCode = @"广州阅速科技有限公司";
//    }
    [QTUMShareTool shareWithTitle:shareTitleDownload  //shareTitleHasCode
                          contend:shareContendHasInviteCode
                           urlStr:shareurlStr
                          platArr:nil   //shareBtnOrder
                         delegate:self
                            image:nil]; //[UIImage imageNamed:@"Icon-60"];
    
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
