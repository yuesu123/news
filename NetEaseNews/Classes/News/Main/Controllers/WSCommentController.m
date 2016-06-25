//
//  WSCommentController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSCommentController.h"
#import "WSCommentCell.h"
#import "WSComment.h"
#import "WSGetDataTool.h"
#import "YiRefreshFooter.h"
#import "MBProgressHUD.h"
#import "WSNewsAllModel.h"
#import "WSTopicContentListModel.h"
#import "WSCommentModel.h"



@interface WSCommentController ()<UITableViewDataSource, UITableViewDelegate>
{
    YiRefreshFooter *refresh;
}

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *comments;
@property (assign, nonatomic) NSInteger commentIndex;
@property (assign, nonatomic) BOOL isImage;


@end

@implementation WSCommentController

#pragma mark - tableView datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    //分两组（1.热门评论  2.最新评论）
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.comments count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WSCommentCell *cell = [WSCommentCell commentCellWithTableView:tableView];
    
    cell.comment = self.comments[indexPath.row];
    
    return cell;
}


#pragma mark - view

-(void)viewDidLoad{
    
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationController.navigationBarHidden = YES;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _isImage = self.postid ? YES : NO;

    [self loadDataComment];
    [self createRefresh];
    self.commentBtn.hidden = YES;
    self.title = @"评论列表";
}


#pragma mark -  刷新相关30行
- (void)createRefresh
{
    __unsafe_unretained __typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 1;
        [weakSelf.tableView.mj_footer resetNoMoreData];
        weakSelf.tableView.mj_footer.hidden = YES;
        [weakSelf loadDataWithCache:NO];
    }];
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadLastData方法）
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}
- (void)endRefresh{
    self.tableView.mj_footer.hidden = NO;
    self.tableView.mj_header.hidden = NO;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)loadLastData{
    //加载footer 不需要加载缓存
    self.tableView.mj_header.hidden = YES;
    [self loadDataWithCache:NO];
}
- (void)refreshCurentPg:(NSInteger)currentPage Total:(NSInteger)Total pgSize:(NSInteger)pgSize{
    [self endRefresh];
    if ([QTCommonTools hasMoreData:currentPage totalNews:Total pageSize:pgSize]) {
        ++_currentPage;
    }else{
        
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}
- (void)loadDataWithCache:(BOOL)cache{
    [self loadDataComment];
}




- (void)loadDataComment{
    NSString *partUrl = nil;
    if ([_item isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_item;
        partUrl = [NSString stringWithFormat:@"newsid=%ld",news.Id];
    }else{
        ZtNewslist *news = (ZtNewslist*)_item;
        partUrl = [NSString stringWithFormat:@"ztnewsid=%ld",news.Id];
    }
    NSString *url = [NSString stringWithFormat:@"api/pinglun?%@&type=list&pagesize=20",partUrl];
    __weak typeof(self) weakSelf = self;
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES needHud:NO hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json)
     {
        NSDictionary *dic = (NSDictionary*)json;
         WSCommentModel *model =[WSCommentModel objectWithKeyValues:dic];
         NSArray *arr = [Mvc_Pingitems objectArrayWithKeyValuesArray:dic[@"Mvc_pingItems"]];
         model.Mvc_pingItems = arr;
         if (_currentPage ==1) {
             [self.comments removeAllObjects];
             if (arr.count == 0) {
                 [self showHint:@"暂无评论!"];
                 self.tableView.mj_footer.hidden = YES;
             }
         }
         [self.comments addObjectsFromArray:model.Mvc_pingItems];
         if (_currentPage == 1&&arr.count == 0) {
             return ;
         }
         [self refreshCurentPg:_currentPage Total:model.Mvc_pingTotal pgSize:20];//2
        
        [self.tableView reloadData];
    } failur:^(NSError *error) {
        [self endRefresh];
    }];

}



//- (void)loadDataWithID:(NSString *)ID commentType:(WSCommentType)type{
//    
//    typeof(self)  __weak weakSelf = self;
//    
//    
//    [WSComment commentWithID:ID index:self.commentIndex type:type getDataSuccess:^(NSArray *dataArr) {
//        
//        if (dataArr.count>0) {
//            
//            NSMutableArray *arrM = nil;
//            
//            if (type==WSCommentTypeContentHot || type==WSCommentTypeImageContentHot) {
//                
//                arrM = self.comments.firstObject;
//                [arrM addObjectsFromArray:dataArr];
//                
//            }else if (type==WSCommentTypeContentNormal || type==WSCommentTypeImageContentNormal){
//                
//                arrM = self.comments.lastObject;
//                [arrM addObjectsFromArray:dataArr];
//            }
//            
//            self.commentIndex += 10;
//            
//            [refresh endRefreshing];
//            [weakSelf.tableView reloadData];
//            [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//            weakSelf.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//
//            
//        }else{
//            
//            NSLog(@"没有更多评论");
//        }
//        
//    } getDataFailure:^(NSError *error) {
//        
//        NSLog(@"加载评论失败：%@",error);
//        [refresh endRefreshing];
//        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
//
//    }];
//
//}

- (IBAction)backItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - lazy loading

- (NSMutableArray *)comments{
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}


@end
