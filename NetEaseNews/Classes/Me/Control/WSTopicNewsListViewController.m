//
//  QTViewController.m
//  问诊;
//
//  Created by apple on 14-4-25.
//  Copyright (c) 2014年 gw. All rights reserved.
//

#import "WSTopicNewsListViewController.h"
#import "QTFHttpTool.h"
#import "WSTopicNewsListCell.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "WSTopicContentListModel.h"
#import "WSContentController.h"
#import "NSArray+Extensions.h"


@interface WSTopicNewsListViewController ()<UIActionSheetDelegate>{
    
    UIView *_bgView;
    

    BOOL _isRefresh;
    int pageNumber;
    NSString *_page;
    NSString *_totalPage;
    
    NSString *_courseId;
    
    BOOL _ispay;//是否进入付款了
    
    BOOL _hasFree;
    
    BOOL _isLoading;
    
    NSInteger _selectedIndex;
}
@property (nonatomic, strong) NSMutableArray* data;

@property (nonatomic, strong) NSMutableArray *tgs;
@property(nonatomic,retain) WSTopicContentListModel *modelAll;


@property (nonatomic, strong) UIView *viewNew;
@end

@implementation WSTopicNewsListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置行高
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delaysContentTouches =NO;
    self.navigationController.navigationBar.translucent = NO;

    _data = [NSMutableArray array];
    self.tableView.backgroundColor = RGBCommonBack;
    _page = @"1";
    pageNumber = 1;
    _totalPage = @"0";
//    [self creatRefresh];
//    [self loadDataZTListPage:1];
    [self createRefresh];
    

}


- (void)loadDataWithCache:(BOOL)cache{
    [self loadDataZTListPage:_currentPage];
}

#pragma mark 网络-获取验证码
- (void)loadDataZTListPage:(NSInteger)page{
    //http://app.53bk.com/api/ztnewslist?ztid=1&pagesize=2&pg=1
    NSString *url = [NSString stringWithFormat:@"api/ztnewslist?ztid=%@&pagesize=20&pg=%ld",self.Id,(long)page];
     __weak typeof (self) w_self = self;
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES  needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            if (![json isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSDictionary *dic = (NSDictionary*)json;
            
//            BOOL success = (BOOL)[dic[@"Success"] boolValue];
//            if (!success) {return;}
            WSTopicContentListModel *modelAll = [WSTopicContentListModel objectWithKeyValues:json];
            
            NSArray *dictArr = dic[@"ZtNewslist"];
            NSMutableArray *ztArr = [ZtNewslist objectArrayWithKeyValuesArray:dictArr];
            
            
            
            //一进来就加载数据
            if(_currentPage == 1) [_data removeAllObjects];
            [w_self.data addObjectsFromArray:ztArr];
            _modelAll = modelAll;
            [self.tableView reloadData];
            [self refreshCurentPg:_currentPage Total:modelAll.Total pgSize:modelAll.Pagesize];
            [self addNotingView:w_self.data.count view:self.view title:@"暂无收藏" font:[UIFont systemFontOfSize:15] color:[UIColor redColor]];
//            [self addNotingView:weakSelf.totalArr.count view:self.view title:@"暂无收藏" font:[UIFont systemFontOfSize:15] color:[UIColor redColor]];

            
        }
    } failur:^(NSError *error) {
        [self endRefresh];
    }];
    
}




- (void)refreshData{
    [_data removeAllObjects];
}
- (void)refreshMyVideoData{
    _isRefresh = YES;
}


//- (void)creatRefresh
//{
//    __unsafe_unretained __typeof(self) weakSelf = self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//    }];
//    
//    // 马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
//}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - 手动移除通知,他妹的老是creash
- (void)removeZeroNoti{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ZeroVideo" object:nil];
}
- (void)dealloc
{
    ECLog(@"视频列表销毁!");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    

}




- (void)addNothView:(NSInteger)count{
    
    if (count>0) {
        _viewNew.hidden = YES;
    }else{
        _viewNew.hidden = NO;
    }
    
    [self addOtherNotingView:count view:self.viewNew title:@"暂时没有视频哦,去其他地方看看吧" font:nil color:nil];
    
    [MBProgressHUD hideHUDForView:self.view];
}
- (UIView *)viewNew{
    
    if (!_viewNew) {
        _viewNew = [[UIView alloc] initWithFrame:CGRectMake(0, 6, self.view.width, Main_Screen_Height)];
        // _viewNew.backgroundColor = redCommon;
        [self.view addSubview:_viewNew];
    }
    return _viewNew;
}
- (void)addOtherNotingView:(NSInteger)count view:(id)oldview title:(NSString*)title font:(UIFont*)font color:(UIColor*)color{
    UIView *view ;
    if([oldview isKindOfClass:[UIView class]]){
        view = (UIView*)oldview;
        //        view.backgroundColor = redCommon;
    }
    
    UIView *bigview = [[UIView alloc] initWithFrame:view.bounds];
    bigview.backgroundColor = [UIColor whiteColor];
    UIImageView* imageView = [[UIImageView alloc]init];
    int minValue = MIN(view.size.width, view.size.height);
    int imageH = minValue*0.44;//182/414 = 0.44
    CGFloat rate = 244.0/182.0;
    int imageW = rate*imageH;
    imageView.frame = CGRectMake((bigview.width-imageW)*0.5, (bigview.height - imageH)*0.5-20-60, imageW, imageH);
    
    imageView.image = [UIImage imageNamed:@"placeHolderImagebaby"];
    [bigview addSubview:imageView];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat y = CGRectGetMaxY(imageView.frame);
    btn.bounds = CGRectMake(0, 0, 300, 40 );
    btn.center = CGPointMake(bigview.center.x, y+20);
    
    if(color){
        [btn setTitleColor:color forState:UIControlStateNormal];
    }else{
        [btn setTitleColor:redCommon forState:UIControlStateNormal];
    }
    
    if(font){
        btn.titleLabel.font = font;
    }else{
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
    btn.userInteractionEnabled = NO;
    
    [bigview addSubview:btn];
    
    
    [view addSubview:bigview];
    [btn setTitle:title forState: UIControlStateNormal];
    
    [self.view bringSubviewToFront:bigview];
    if(count>0){ //不隐藏
        //        for (UIView*view1 in bigview.subviews) {
        //            [view1 removeFromSuperview];
        //        }
        //        [bigview removeFromSuperview];
        //        [view removeFromSuperview];
        //        return;
        bigview.hidden = YES;
        //        view.hidden = YES;
    }else{
        bigview.hidden = NO;
        //        view.hidden = NO;
    }
    
}
- (void) showNoConnect{
    [MBProgressHUD showError:@"网络连接失败"];
    self.noNetView.hidden = NO;
    for (UIView*view in self.noNetView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            view.frame = CGRectMake((self.view.width- view.size.width)*0.5, view.y, view.size.width, view.size.height) ;
        }else if([view isKindOfClass:[UIImageView class]]){
            view.frame = CGRectMake((self.view.width- view.size.width)*0.5, view.y, view.size.width, view.size.height) ;
        }
    }
    
    [self.view bringSubviewToFront: self.noNetView];
    [self.reLoad addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  得到含有加密token的urlStr
 *
 *  @return urlStr
 */

-(void)retry
{
    self.noNetView.hidden = YES;
//    if(_isShowEvaluation == isShowEvaluationYes){//显示评价 是我的视频
//        [self loaddataForMyVideoHavePayed:1];
//    }else{
//        [self loadDataNeedMask:YES]; //不显示评价是视频列表
//    }
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    videoAllListModel *AllList = [_data objectAtIndex:indexPath.row];
//
    WSTopicNewsListCell *cell = [WSTopicNewsListCell cellWithTableView:tableView];
//    [QTCommonTools clipButton:cell.toEvaluateBtn Radius:8 borderWidth:0];
//    
//    cell.videoAllList = AllList;
    cell.ztNewslist = [_data objectAtIndex:indexPath.row];
//    
    return cell;
}
- (void)tableView:(UITableView *)sender didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [sender deselectRowAtIndexPath:indexPath animated:YES];
    if (_data.count == 0) {
        return;
    }
    ZtNewslist *ztNews = [_data objectAtIndex:indexPath.row];
    

    WSContentController *contentVC = [WSContentController contentControllerWithItem:ztNews];
    WSTopicNewsListCell *cell = [sender  cellForRowAtIndexPath:indexPath];
    cell.titleLable.textColor = [UIColor grayColor];
    
    [NSArray writetargetStr:cell.titleLable.text ToFilePath:@"zhuanti"];
    
    [self.navigationController pushViewController:contentVC animated:YES];
    
    
}

- (Newslist *)convertZtnewsToNews:(ZtNewslist*)adModel{
        Newslist *news = [[Newslist alloc] init];
        news.Id = adModel.Id;
        news.Title = adModel.Title;
        news.Descriptions = adModel.Ztdes;
        news.Picsmall = adModel.Picsmall;
        news.Newslink = adModel.Newslink;
        news.Edittime = adModel.Edittime;
        news.Showtype = adModel.Showtype;
        return news;
}


@end
