//
//  WSContentController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNewsController.h"
//#import "WSNews.h"
#import "WSNewsAllModel.h"
#import "WSAds.h"
#import "YiRefreshFooter.h"
#import "YiRefreshHeader.h"
#import "WSContentController.h"
#import "WSImageContentController.h"
#import "WSGetDataTool.h"
#import "WSNewsCell.h"
#import "WSRollController.h"
#import "MBProgressHUD.h"
#import "SDImageCache.h"
#import "QTFHttpTool.h"
#import "WSNewsController+CheckVersion.h"
#import "DDNewsCache.h"

@interface WSNewsController ()
{
    
//    YiRefreshHeader *refreshHeader;
//    YiRefreshFooter *refreshFooter;
    NSMutableArray *_jsonNews;
}

@property (strong, nonatomic) NSMutableArray *jsonNews;

//@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) WSRollController *rollVC;

@end

@implementation WSNewsController

#pragma mark - view

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    typeof(self) __weak weakSelf = self;
    
    NSArray *ads = nil;
    
    if (self.jsonNews.count>0) {
        ads = [self.jsonNews.firstObject ads] ? : @[self.jsonNews.firstObject];
    }
    
    //轮播赋值
    [self.rollVC rollControllerWithAds:ads selectedItem:^(id obj) {
        
        if([obj isKindOfClass:[WSAds class]]){
            
            WSAds *ad = obj;
            
            if ([ad.tag isEqualToString:@"doc"]) {
                
                WSContentController *contentVC = [WSContentController contentControllerWithItem:ad.docid];
                //hideBottomBar

                [weakSelf.navigationController pushViewController:contentVC animated:YES];
            }else{
                
                [weakSelf pushPhotoControllerWithPhotoID:ad.url replyCount:1000];
            }
            
            
        }else if ([obj isKindOfClass:[Newslist class]]){
            
            Newslist *news = obj;
            WSContentController *contentVC = [WSContentController contentControllerWithItem:news.Newslink];
            //hideBottomBar

            [weakSelf.navigationController pushViewController:contentVC animated:YES];
            
        }
        
    }];
    
    //判断是否刷新数据
    if(self.jsonNews.count == 0){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.rollVC.view.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
//    self.index = 0;
    
    //设置刷新
//    [self setRefreshView];
    [self createRefresh];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self isShoulfCheckVersion];
    });
}

- (void)loadDataWithCache:(BOOL)cache{
    [self loadMoreDataCount];
}

- (void)loadMoreDataCount {
    typeof(self) __weak weakSelf = self;
    ECLog(@"加载数据请求:%@",[self newsURL]);
    [QTFHttpTool requestGETURL:[self newsURL] params:nil refreshCach:YES needHud:NO hudView:nil loadingHudText:nil errorHudText:nil sucess:^(id json) {
        WSNewsAllModel *allModel = [WSNewsAllModel objectWithKeyValues:json];
        if (allModel.Newslist.count > 0) {
            
            if (_currentPage == 1){ [weakSelf.jsonNews removeAllObjects];
            }
            
            [weakSelf.jsonNews addObjectsFromArray:allModel.Newslist];
            
            //            weakSelf.index += 20;
            //图片轮播赋值
            
            if (allModel.Blocknews.count>0) {
                Newslist *list = [[Newslist alloc] init];
                list.ads = allModel.Blocknews;
                [weakSelf.jsonNews insertObject:list atIndex:0];
            }
            weakSelf.rollVC.ads = [weakSelf.jsonNews.firstObject ads] ? : @[weakSelf.jsonNews.firstObject] ;
            
            [weakSelf.tableView reloadData];
            [self refreshCurentPg:_currentPage Total:allModel.Total pgSize:allModel.Pagesize];
        }
        
    } failur:^(NSError *error) {
        [self endRefresh];
    }];
}


- (NSString *)newsURL{
    return [NSString stringWithFormat:@"api/newslist?classid=%@&pg=%ld&pagesize=2",self.channelID,(long)_currentPage] ;
}


#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Newslist *news = self.jsonNews[indexPath.row];
    
    WSNewsCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.titleLbl.textColor = [UIColor grayColor];
    	[[DDNewsCache sharedInstance] addObject:cell.titleLbl.text];
    
    
//    if ([news.tag isEqualToString:@"photoset"]) {
//        
//        [self pushPhotoControllerWithPhotoID:news.skipID replyCount:news.replyCount];
//        
//    }else{
    
        WSContentController *contentVC = [WSContentController contentControllerWithItem:news];
//        contentVC.newsLink = @"https://wap.baidu.com";//news.Newslink;
//    contentVC.docid =[NSString convertIntgerToString:news.Id];
//    //hideBottomBar
//    contentVC.wscontentControllerType = WSContentControllerTypeNews;
        [self.navigationController pushViewController:contentVC animated:YES];
//    }
    
}

- (void)pushPhotoControllerWithPhotoID:(NSString *)photoid replyCount:(NSInteger)count{
    
    WSImageContentController *imageContent = [[WSImageContentController alloc] init];
    imageContent.photosetID = photoid;
    imageContent.replycount = count;
    //hideBottomBar

    [self.navigationController pushViewController:imageContent animated:YES];
    
}


#pragma mark - tableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.jsonNews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.rollVC.view.hidden = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    Newslist *news = self.jsonNews[indexPath.row];
    if(indexPath.row == 1){
        news.Showtype = 2;
    }else if(indexPath.row == 5){
        news.Showtype = 1;
    }
    WSNewsCell *cell = [WSNewsCell newsCellWithTableView:tableView cellNews:news IndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Newslist *content = self.jsonNews[indexPath.row];
    
    WSNewsCellType type = 0;
    if (content.Showtype == 2) {//三图
        type = WSNewsCellTypeThreeImage;
    }else if (content.Showtype == 1){ //大图
        type = WSNewsCellTypeBigImage;
    }else{
        type = WSNewsCellTypeNormal;//单图
    }
//      -- 0为左图右标题样式 1 为直栏模式 2为三图模式
    return [WSNewsCell rowHeighWithCellType:type];
}


#pragma mark - lazy loading



- (NSMutableArray *)jsonNews{
    
    if (!_jsonNews) {
        
        NSArray *arr = [Newslist cacheFileArrWithChannelID:self.channelID];
        
        _jsonNews = arr.count > 0 ? [NSMutableArray arrayWithArray:arr] :[NSMutableArray array];
        
    }
    return _jsonNews;
}


+ (instancetype)newsController{
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    
    WSNewsController *newsVC = [sb instantiateViewControllerWithIdentifier:@"newsController"];
    
    return newsVC;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"rollSegue"]) {
        
        self.rollVC = segue.destinationViewController;
    }
}


@end