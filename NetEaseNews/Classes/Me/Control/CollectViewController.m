//
//  CollectViewController.m
//  新闻
//
//  Created by gyh on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CollectViewController.h"
#import "DataBase.h"
#import "CollectTableViewCell.h"
#import "CollectModel.h"
#import "DetailWebViewController.h"
#import "WSContentController.h"
#import "WSNewsAllModel.h"
#import "WSTopicContentListModel.h"

@interface CollectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
}
@property (nonatomic , strong) NSMutableArray *totalArr;
@property (nonatomic , strong) CollectModel *collectmodel;
@end

@implementation CollectViewController

- (NSMutableArray *)totalArr
{
    if (!_totalArr) {
        _totalArr = [NSMutableArray array];
    }
    return _totalArr;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    CollectModel *model1 =[[CollectModel alloc] init];
//    model1.NewsMode.Title = @"测试1 ";
//    CollectModel *model2 =[[CollectModel alloc] init];
//    model2.NewsMode.Title = @"测试111 ";
//    CollectModel *model3 =[[CollectModel alloc] init];
//    model3.NewsMode.Title = @"测试1111 ";
//
//    _totalArr = [NSMutableArray array];
//    self.totalArr =  [NSMutableArray arrayWithObjects:@[model1,model2,model3], nil];
//    [_totalArr addObject:model1];
//    [_totalArr addObject:model2];
//    [_totalArr addObject:model3];

    NSLog(@"%@",_totalArr);
    [tableview reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    tableview.tableFooterView = [[UIView alloc] init];
//    [self createRefresh:tableview];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btn setFrame:CGRectMake(0, 0, 45, 45)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [btn setTintColor:[UIColor clearColor]];
    [btn setTitle:@"编辑" forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    btn.selected = NO;
    self.navigationItem.rightBarButtonItem= rightItem;
//    if (strNotNil([QTUserInfo sharedQTUserInfo].passWD)) {
//        [self LoadDataCollection];
//    }else{
//        [MBProgressHUD showError:@"请先登录"];
//    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
    [self createRefresh:tableview];
}

- (void)loadDataWithCache:(BOOL)cache{
    [self LoadDataCollection];
}

- (void)LoadDataCollection{
//    NSString *url = [NSString stringWithFormat:@"api/ztnewslist?ztid=%@&pagesize=20&pg=%ld",self.Id,(long)page];

    NSString *url = [NSString stringWithFormat:@"api/newsshoucang?userid=%@&pagesize=20&pg=%ld",[QTUserInfo sharedQTUserInfo].userId,_currentPage];

    [MBProgressHUD showMessage:loadingWaitingStr toView:self.view];
    __weak typeof(self) weakSelf = self;
    [HYBNetworking getWithUrl:url refreshCache:YES success:^(id response) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSDictionary *json = (NSDictionary*)response;
        NSArray *dicArray  = json[@"Shoulist"];
        if (_currentPage == 1&&self.totalArr.count>0) {
            [self.totalArr removeAllObjects];
        }
        for (NSDictionary*dic in dicArray) {
            CollectModel *AllModel = [CollectModel objectWithKeyValues:dic];
            ZtNewsMode *ztModel = [ZtNewsMode objectWithKeyValues:dic[@"ZtNewsMode"]];
            NewsMode *newsModel = [NewsMode objectWithKeyValues:dic[@"NewsMode"]];
            AllModel.ztNewsMode = ztModel;
            AllModel.NewsMode = newsModel;
//            if (AllModel.ztNewsMode.Title.length>1||AllModel.NewsMode.Title.length > 1) {
                [self.totalArr addObject:AllModel];
//            }
            
        }
        
        [self addNotingView:weakSelf.totalArr.count view:self.view title:@"暂无收藏" font:[UIFont systemFontOfSize:15] color:[UIColor redColor]];
        [self refreshCurentPg:_currentPage Total:(NSInteger)json[@"Total"] pgSize:(NSInteger)json[@"Pagesize"]];

        
        [tableview reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        [self endRefresh];
    }];
}

- (void)injected{
    NSLog(@"I've been injected: %@", self);
    [self viewDidLoad];
    
}

- (void)LoadDataDeleteCollection:(CollectModel*)model{
    NSString *partUrl = nil;
    if ([model isKindOfClass:[ZtNewsMode class]]) {
        partUrl = @"newsid";
    }else{
        partUrl = @"ztnewsid";
    }
    
    
    NSString *url = [NSString stringWithFormat:@"api/newsshoucangdel?userid=%ld&%@=%ld",(long)model.Userid,partUrl,(long)model.Id];
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        NSDictionary *dic = (NSDictionary*)json;
        BOOL success = (BOOL)[dic[@"Success"] boolValue];
        NSString *Msg = dic[@"Msg"];
        if (success) {
            [MBProgressHUD showSuccess:Msg];
        }
        [self.totalArr removeObject:model];
        [tableview setEditing:NO animated:YES];
        [tableview reloadData];
    } failur:^(NSError *error) {
        [tableview setEditing:NO animated:YES];
    }];
}


- (void)editBtnClicked:(UIButton*)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [self setEditing:YES];
    }else{
        [self setEditing:NO];
    }
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [tableview setEditing:editing animated:animated];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectTableViewCell *cell = [[CollectTableViewCell alloc]init];
    cell.collectModel = self.totalArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectModel *model =[self.totalArr objectAtIndex:indexPath.row];
    [self gotoWSContentController:model];
}

- (void)gotoWSContentController:(CollectModel*)model{
    NewsMode *newsModel = model.NewsMode;
    ZtNewsMode *ztNewsModle = model.ztNewsMode;
    if (model.ztNewsMode) {
        Newslist *newsList =[[Newslist alloc] init];
        newsList.Id = model.Id; //id == classId
        newsList.Title = newsModel.Title;
        newsList.Hits = newsModel.Hits;
        WSContentController *contentVC = [WSContentController contentControllerWithItem:newsList];
        [self.navigationController pushViewController:contentVC animated:YES];
    }else{
        ZtNewslist *ztNewsList = [[ZtNewslist alloc] init];
        ztNewsList.Id = model.Id;
        ztNewsList.Title = ztNewsModle.Title;
        ztNewsList.Hits = ztNewsModle.Hits;
        WSContentController *contentVC = [WSContentController contentControllerWithItem:ztNewsList];
        [self.navigationController pushViewController:contentVC animated:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DataModel *dataModel = self.totalArr[indexPath.row];
//    [DataBase deletetable:dataModel.docid];
    CollectModel *model = [self.totalArr objectAtIndex:indexPath.row];
    [self LoadDataDeleteCollection:model];
}


//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}





@end
