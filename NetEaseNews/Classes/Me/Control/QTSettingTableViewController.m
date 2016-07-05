//
//  MeTableViewController.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/21.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "QTSettingTableViewController.h"
#import "SZKCleanCache.h"
#import "QTOpinionViewController.h"
#import "ServiceExampleViewController.h"

@interface QTSettingTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *QTClearCachCell;

@end

@implementation QTSettingTableViewController
#pragma mark –
#pragma mark Action and UI Event


#pragma mark –
#pragma mark View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] init];
//    NSLog(@"%.2fm",);

    self.QTClearCachCell.textLabel.text = [NSString stringWithFormat:@"清理缓存 (%.2fM)",[SZKCleanCache folderSizeAtPath]];
 
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark - Table view data source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 4;
//}

#pragma mark –
#pragma mark System Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0&&indexPath.section == 0) {
        [self clearCache];
    }else if(indexPath.row == 1&&indexPath.section == 0){
//        [self  gotoOpinionVc];
        [self  gotoAboutUsVc];

    }else if(indexPath.row == 2&&indexPath.section == 0){
        [self  gotoAboutPrivateZhenze];

    }else if(indexPath.row == 0&&indexPath.section == 1){
        [self  showAlertPSTLogout];
    }
}

//去天气webView控制器
- (void)gotoAboutPrivateZhenze{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"使用条款和免责声明";
    vc.urlStr = sg_privateAbouTPrivtazhence;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)clearCache{
    [SZKCleanCache cleanCache:^{
        self.QTClearCachCell.textLabel.text = @"清理缓存(清理成功)";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.QTClearCachCell.textLabel.text = @"清理缓存(0.00M)";
        });
        NSLog(@"清除成功");
    }];
}

- (void)gotoOpinionVc{
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    QTOpinionViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"OpinionViewController"];
    vc.title = @"意见反馈";
    [self.navigationController pushViewController:vc animated:YES];
}

//去天气webView控制器
- (void)gotoAboutUsVc{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"关于我们";
    vc.urlStr = sg_privateAboutMe;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)showAlertPSTLogout{
    if (!strNotNil([QTUserInfo sharedQTUserInfo].passWD)) {
        [MBProgressHUD showError:@"您还没有登录"];
        return;
    }
    NSString *cancelButtonTitle = @"取消";
    NSString *logoutButtonTitle = @"退出";
    PSTAlertController *gotoPageController = [PSTAlertController alertWithTitle:@"退出登录吗?" message:nil];
    [gotoPageController addCancelActionWithHandlerMSg:cancelButtonTitle Handle:NULL];
    [gotoPageController addAction:[PSTAlertAction actionWithTitle:logoutButtonTitle handler:^(PSTAlertAction *action) {
        ECLog(@"退出登录成功");
        [MBProgressHUD showSuccess:@"成功退出!"];
        [QTUserInfo sharedQTUserInfo].passWD = nil;
        [[QTUserInfo sharedQTUserInfo] writeUserInfoToDefault];
        if (_loginOutSuccessBlock) {
            _loginOutSuccessBlock(nil);
        }
    }]];
    [gotoPageController showWithSender:nil controller:self animated:YES completion:NULL];
    
    
}

- (void)loginSuccessBlock:(WSLoginOutSuccess)loginOutSuccess{
    _loginOutSuccessBlock = loginOutSuccess;
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
