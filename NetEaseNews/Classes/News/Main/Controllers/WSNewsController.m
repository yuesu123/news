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
        ads = nil; // [self.jsonNews.firstObject ads] ? : @[self.jsonNews.firstObject];
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

//- (void)refreshData { //此处代码无用
//    
//    [refreshHeader beginRefreshing];
//}

//- (void)setRefreshView {
//    
//    refreshHeader = [[YiRefreshHeader alloc] init];
//    refreshHeader.titleLoading = @"正在加载中...";
//    refreshHeader.titlePullDown = @"拉动刷新更多数据....";
//    refreshHeader.titleRelease = @"松手加载更多数据...";
//    refreshHeader.scrollView = self.tableView;
//    [refreshHeader header];
//    
//    typeof(self) __weak weakSelf = self;
//    
//    refreshHeader.beginRefreshingBlock = ^(){
//        
//        weakSelf.index = 0;
//        [weakSelf loadMoreDataCount:0];
//        [[SDImageCache sharedImageCache] clearMemory];
//        
//        //        NSLog(@"刷新数据");
//        
//    };
//    
//    refreshFooter = [[YiRefreshFooter alloc] init];
//    refreshFooter.scrollView = self.tableView;
//    [refreshFooter footer];
//    
//    refreshFooter.beginRefreshingBlock = ^(){
//        
//        [weakSelf loadMoreDataCount:weakSelf.index];
//        //        NSLog(@"加载更多数据");
//    };
//    
//    [refreshHeader beginRefreshing];
//}


- (void)loadMoreDataCount {
    
//    typeof(refreshHeader) __weak weakHeader = refreshHeader;
    typeof(self) __weak weakSelf = self;
//    typeof(refreshFooter) __weak weakFooter = refreshFooter;
    
    ECLog(@"加载数据请求:%@",[self newsURL]);
    [Newslist newsListDataWithNewsID:[self newsURL] newsCache:(_currentPage==1) getDataSuccess:^(NSArray *dataArr) {
        WSNewsAllModel *allModel = [dataArr firstObject];
        
        if (allModel.Newslist.count > 0) {
            
            if (/*weakSelf.index == 0*/_currentPage == 1) [weakSelf.jsonNews removeAllObjects];
            
            [weakSelf.jsonNews addObjectsFromArray:allModel.Newslist];
            
//            weakSelf.index += 20;
            //图片轮播赋值
//            weakSelf.rollVC.ads = [weakSelf.jsonNews.firstObject ads] ? : @[weakSelf.jsonNews.firstObject] ;
            
            
            [weakSelf.tableView reloadData];
            [self refreshCurentPg:_currentPage Total:allModel.Total pgSize:allModel.Pagesize];
//            [weakHeader endRefreshing];
//            [weakFooter endRefreshing];
        }
        
    } getFailure:^(NSError *error) {
        
        NSLog(@"刷新失败:%@",error);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefresh];
//            [weakHeader endRefreshing];
//            [weakFooter endRefreshing];
        });
    }];
    
    
    
    
    
    
}

//- (NSString *)newsURL{
//    
//    return [self.channelUrl stringByReplacingOccurrencesOfString:self.channelUrl.lastPathComponent withString:[NSString stringWithFormat:@"%ld-%ld.html?from=toutiao&passport=tg%%2BXeARESp%%2BKk1cvff3CYYHneQ4Vgz8zRIWyqxFlJl4%%3D&devId=vLWbfIXxCa1CK9%%2B20Q0f98IOSn9ZTn2pjLRXOOBn3fttg3OsEQzfSL238z3USCkJ&size=20&version=5.5.0&spever=false&net=wifi&lat=&lon=&ts=1451223862&sign=W1v%%2BccS4kqTPNo1XoI1hRA7NJTZ9WFoR3TGwx3F1fDB48ErR02zJ6%%2FKXOnxX046I&encryption=1&canal=appstore",self.index, self.index+20]];
//}

- (NSString *)newsURL{
//    http://app.53bk.com/api/newslist?classid=3&pg=1&pagesize=1
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
    
    WSNewsCell *cell = [WSNewsCell newsCellWithTableView:tableView cellNews:news IndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Newslist *content = self.jsonNews[indexPath.row];
    
    WSNewsCellType type = 0;
    
//    if (content.imgextra.count == 2) {//三图
//        
//        type = WSNewsCellTypeThreeImage;
//    }else if (content.imgType){ //大图
//        
//        type = WSNewsCellTypeBigImage;
//    }else{
        type = WSNewsCellTypeNormal;//单图
//    }
    
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