//
//  WSTopicController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicController.h"
//#import "WSTOpicAllModel.h"
#import "WSTopicModel.h"
#import "WSTopicCell.h"
//#import "YiRefreshFooter.h"
#import "MBProgressHUD.h"
#import "WSTopDetailController.h"
#import "WSTopicNewsListViewController.h"

@interface WSTopicController ()
@property (strong, nonatomic) NSMutableArray *topics;

//@property (assign, nonatomic) NSInteger topicIndex;

//@property (strong, nonatomic) YiRefreshFooter *refreshFooter;

@end

@implementation WSTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftBarButton.hidden = YES;
//    self.topicIndex = 0;
    
//    [self loadDataWithCache:YES];
 
//    typeof(self) __weak weakSelf = self;
//    YiRefreshFooter *refresh = [[YiRefreshFooter alloc] init];
//    refresh.scrollView = self.tableView;
//    [refresh footer];
//    refresh.beginRefreshingBlock = ^(){
//      
//        [weakSelf loadDataWithCache:NO];
//    };
//    _refreshFooter = refresh;
    [self createRefresh];//1
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout =  UIRectEdgeNone;
    }
}




- (void)loadDataWithCache:(BOOL)cache{
    
    typeof(self) __weak weakSelf = self;
    
    [Ztlist topicWithIndex:/*self.topicIndex*/_currentPage isCache:cache getDataSuccess:^(NSArray *dataArr) {
        
        if (dataArr.count == 0) {
            NSLog(@"没有更多数据");
            return ;
        }
        
        //一进来就加载数据
        WSTopicModel *allModel = [dataArr firstObject];
        if(_currentPage == 1) [weakSelf.topics removeAllObjects];
        
        [weakSelf.topics addObjectsFromArray:allModel.Ztlist];
        
        [weakSelf.tableView reloadData];
        
        
        [self refreshCurentPg:_currentPage Total:allModel.Total pgSize:allModel.Pagesize];//2
        
    } getDataFaileure:^(NSError *error) {
        
        NSLog(@"%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefresh];//3
        });
    }];
}



#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Ztlist *zt = [self.topics objectAtIndex:indexPath.row];
    
//    WSTopDetailController *td = [WSTopDetailController topicDetailWithTopic:self.topics[indexPath.row]];
//    //hideBottomBar
//
//    [self.navigationController pushViewController:td animated:YES];
    [self gotoWSTopicNewsListViewController:zt];
}


- (void)gotoWSTopicNewsListViewController:(Ztlist*)zt{
    WSTopicNewsListViewController *vc = [[WSTopicNewsListViewController alloc] init];
    vc.title = @"专题列表";
    vc.Id =[NSString convertIntgerToString:zt.Id]; ;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - tableview datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [WSTopicCell rowHeight];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    WSTopicCell *cell = [WSTopicCell topicCellWithTableView:tableView];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}



#pragma mark - lazy loading

- (NSMutableArray *)topics{
    
    if (!_topics) {
        
        _topics = [NSMutableArray arrayWithArray:[Ztlist cacheTopic]]? :[NSMutableArray array];
    }
    
    return _topics;
}


@end