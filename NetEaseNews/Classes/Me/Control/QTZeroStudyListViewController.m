//
//  QTViewController.m
//  问诊;
//
//  Created by apple on 14-4-25.
//  Copyright (c) 2014年 gw. All rights reserved.
//

#import "QTZeroStudyListViewController.h"
#import "QTFHttpTool.h"
//#import "BaseViewController.h"
//#import "zeroStudyModel.h"
//#import "QTAboutUsViewController.h"

@interface Product : NSObject{
@private
    float     _price;
    NSString *_subject;
    NSString *_body;
    NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, strong) NSDictionary *dataDic;

@end
@interface QTZeroStudyListViewController ()<UIActionSheetDelegate>{
    
}
@property (nonatomic, strong) NSMutableArray* data;

@end

@implementation QTZeroStudyListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置行高
    self.tableView.rowHeight = 50;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _data = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc]init];

    self.tableView.backgroundColor = RGBCommonBack;
    [self loadDataForGetZeroStudyList];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//#pragma mark 获取专家信息
-(void)loadDataForGetZeroStudyList
{
    [MBProgressHUD showMessage:loadingNetWorkStr toView:self.view ];
    __weak typeof (self) w_self = self;
   
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"article-list" forKey:@"method"];
    [params setObject:@"0" forKey:@"type"];//1是苹果
    
    [QTFHttpTool requestWithPostWithurlNew:REQUEST_URL parameters:params sucess:^(NSDictionary *json) {
        BOOL success = (BOOL)[json[@"success"] boolValue];
        
        //如果响应出错，则返回
        if (!success) {
            [MBProgressHUD hideHUDForView:w_self.view];
            //      [MBProgressHUD showError:json[@"msg"] toView:w_self];
            return ;
        }else{
           _data =  json[@"data"];
            [self.tableView reloadData];            
        }
        [MBProgressHUD hideHUDForView:w_self.view];
    } failur:^(NSError *error) {
        [MBProgressHUD hideHUDForView:w_self.view];
        [MBProgressHUD showError:@"网络连接失败"];
        [self showNoConnect];
    }];
    
}


- (void) showNoConnect{
    [MBProgressHUD showError:@"网络连接失败"];
    self.noNetView.hidden = NO;
    [self.view bringSubviewToFront: self.noNetView];
    [self.reLoad addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
}





-(void)retry
{
    self.noNetView.hidden = YES;
    [self loadDataForGetZeroStudyList];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary *dataOneDic = [_data objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = dataOneDic[@"title"] ;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    zeroStudyModel *zeroModel = [_data objectAtIndex:indexPath.row];
//    QTAboutUsViewController* vc = [[QTAboutUsViewController alloc]init];
//    vc.type = zerostudy;
//    vc.zeroTitle = @"北仑新区时刊";
//    vc.zeroStudyUrl = zeroModel.url;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//    [QTRequestTools addbigDataSatisWithtype:2 satisfyID:zeroModel.articleId payType:0 caseType:nil];
}











@end
