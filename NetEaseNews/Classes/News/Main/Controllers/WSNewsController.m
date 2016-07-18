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
#import "WSTopicContentListModel.h"
#import "WSMenuInstance.h"
#import "WSOneMenuModel.h"
#import "NSArray+Extensions.h"
#import "ServiceExampleViewController.h"

@interface WSNewsController ()<UIAlertViewDelegate>
{
    
//    YiRefreshHeader *refreshHeader;
//    YiRefreshFooter *refreshFooter;
    NSMutableArray *_jsonNews;
}

@property (strong, nonatomic) NSMutableArray *jsonNews;
@property (strong, nonatomic) NSMutableArray *NewsadArr;


//@property (assign, nonatomic) NSInteger index;

@property (weak, nonatomic) WSRollController *rollVC;
@property (nonatomic, strong) NSDictionary *activeNotiInfo;
@property (nonatomic, assign) BOOL isShowAlert;

@end

@implementation WSNewsController

#pragma mark - view

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self createRefresh];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self isShoulfCheckVersion];
    });
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(notificationInactiveDic:) name:kNotificationInactiveDic object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(notificationActiveDic:) name:kNotificationActiveDic object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(notificationAddTap:) name:kNotificationAddTap object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _isShowAlert = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationAddTap object:nil];
    });
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _isShowAlert = NO;
}


- (void)notificationInactiveDic:(NSNotification*)noti{
    ECLog(@"后台通知:%@",noti.userInfo);
    [self gotoNotiControllercreatItem:noti.userInfo];
    
}

- (void)gotoNotiControllercreatItem:(NSDictionary*)userInfo{
//    NSDictionary *userInfoDic = userInfo[@"userInfo"];
    //标题
    NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    //ID
    NSInteger newsid = (NSInteger)userInfo[@"newsid"];
    NSInteger ztnewsid = (NSInteger)userInfo[@"ztnewsid"];
    if (newsid>0) {
        Newslist *newsList = [[Newslist alloc] init];
        newsList.Title = messageAlert;
        newsList.Id = newsid;
        [self gotoWSContentController:newsList];
    }else{
        ZtNewslist *ztnews = [[ZtNewslist alloc] init];
        ztnews.Title = messageAlert;
        ztnews.Id = ztnewsid;
        [self gotoWSContentController:ztnews];
    }
}

- (void)notificationAddTap:(NSNotification*)noti{
    ECLog(@"接受到通知:%@",noti);
    [self gotoAddViewController];
}
- (void)gotoAddViewController{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"详情";
    vc.urlStr = [QTUserInfo sharedQTUserInfo].adlink;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)notificationActiveDic:(NSNotification*)noti{
    ECLog(@"前台通知:%@",noti);
    NSDictionary *userInfo = noti.userInfo;
    _activeNotiInfo = userInfo;
    NSString *messageAlert = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"新闻通知" message:messageAlert delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往", nil];
    alertView.delegate = self;
    //        self.pushAlertClickBtnFlag = 55;  // 判断是不是远程推送消息的弹窗
    if (_isShowAlert) {
        [alertView show];//只在新闻页面弹框
    }
    // 将消息保存着  等待点击alert按钮 进行跳不跳转
    //        self.notiUserInfo = userInfo;
    // 8秒后将退出弹框
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
    [self gotoNotiControllercreatItem:_activeNotiInfo];
}
//cell即将展示的时候调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}



- (void)addRoll:(NSArray*)arr {
    typeof(self) __weak weakSelf = self;

    
    //轮播赋值
    [self.rollVC rollControllerWithAds:arr selectedItem:^(id obj) {
        Blocknews *model = (Blocknews*)obj;
        Newslist *newsList =[[Newslist alloc] init];
        newsList.Id = model.Id; //id == classId
        newsList.Title = model.Title;
        newsList.Hits = model.Hits;
        [self gotoWSContentController:newsList];

        /*
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
            
        }*/
        
    }];
    
    //判断是否刷新数据
    if(self.jsonNews.count == 0){
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.rollVC.view.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}



- (void)loadDataWithCache:(BOOL)cache{
    [self loadMoreDataCount];
}

- (void)loadMoreDataCount {
    typeof(self) __weak weakSelf = self;
    ECLog(@"加载数据请求:%@",[self newsURL]);
    [QTFHttpTool requestGETURL:[self newsURL] params:nil refreshCach:YES needHud:NO hudView:nil loadingHudText:nil errorHudText:nil sucess:^(id json) {
        WSNewsAllModel *allModel = [WSNewsAllModel objectWithKeyValues:json];
        [self endRefresh];
        if (allModel.Newslist.count > 0) {
            if (_currentPage == 1){ [weakSelf.jsonNews removeAllObjects];
                _NewsadArr = [NSMutableArray arrayWithArray:allModel.Newsad];
            }
            [weakSelf.jsonNews addObjectsFromArray:allModel.Tjnews];
            [weakSelf.jsonNews addObjectsFromArray:allModel.Newslist];
            
            [WSAdModel  inserAdArr:_NewsadArr toArr:weakSelf.jsonNews  path:3];
               //轮播赋值
            if(_currentPage == 1){
                [self addRoll:allModel.Blocknews];
            }
            [weakSelf.tableView reloadData];
            [self refreshCurentPg:_currentPage Total:allModel.Total pgSize:allModel.Pagesize];
            self.rollVC.view.hidden = NO;
           
        }else if((weakSelf.jsonNews.count==0)&&(allModel.Newsad.count==0)){
            [self addNotingViewTop:weakSelf.jsonNews.count view:self.view title:@"暂无新闻" font:[UIFont systemFontOfSize:15] color:[UIColor darkGrayColor]];
            
            self.tableView.mj_footer.hidden = YES;
            self.rollVC.view.hidden = YES;
        }
        
    } failur:^(NSError *error) {
        [self endRefresh];
    }];
}


- (NSString *)newsURL{
    return [NSString stringWithFormat:@"api/newslist?classid=%@&pg=%ld&pagesize=20",self.channelID,(long)_currentPage] ;
}


#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Newslist *news = self.jsonNews[indexPath.row];
    WSNewsCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.titleLbl.textColor = [UIColor grayColor];
    [NSArray writetargetStr:cell.titleLbl.text ToFilePath:@"state"];
    if ([self isAdd:news])
    {
        [self gotoAddViewController:news.Newslink];
    }else
    {
        [self gotoWSContentController:news];
    }
    
    
}

- (BOOL)isAdd:(Newslist*)list {
    if([list isKindOfClass:[Newslist class]]){
        return  list.isAdd;
    }else{
        return NO;
    }
}


//去天气webView控制器
- (void)gotoAddViewController:(NSString*)url{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"详情";
    vc.urlStr = url;
    vc.type = TypeKindAdd;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)gotoWSContentController:(id)news{
    WSContentController *contentVC = [WSContentController contentControllerWithItem:news];
    //        contentVC.newsLink = @"https://wap.baidu.com";//news.Newslink;
    //    contentVC.docid =[NSString convertIntgerToString:news.Id];
    //    //hideBottomBar
    //    contentVC.wscontentControllerType = WSContentControllerTypeNews;
    [self.navigationController pushViewController:contentVC animated:YES];

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
//    news.Showtype = 1;
//    if(indexPath.row == 1){
//        news.Showtype = 2;
//    }else if(indexPath.row == 5){
//        news.Showtype = 1;
//    }
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

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end