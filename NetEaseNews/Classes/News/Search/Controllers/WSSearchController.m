//
//  WSSearchController.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSSearchController.h"
#import "WSSearchResult.h"
#import "WSContentController.h"
#import "WSImageContentController.h"
#import "WSNewsAllModel.h"
#import "WSTopicContentListModel.h"

@interface WSSearchController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *result;
@property (nonatomic, copy) NSString *url;
@end

@implementation WSSearchController



#pragma mark - searchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSString *url = [NSString stringWithFormat:@"api/infosearch?key=%@",searchBar.text];
    ECLog(@"搜索字段%@",searchBar.text);
         url= [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _url = url;
    [self loadDataWithCacheUrl];
}

- (void)loadDataWithCacheUrl{
    NSString  *urlNew= [_url stringByAppendingString:[NSString stringWithFormat:@"&pg=%ld&pagesize=20",_currentPage]];
    [QTFHttpTool requestPOSTURL:urlNew paras:nil needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        NSArray * wsResultArr = [WSSearchResult objectArrayWithKeyValuesArray:json[@"List"]];
        if (_currentPage == 1) {
            [self.result removeAllObjects];
        }
        [self.result addObjectsFromArray:wsResultArr];
        [self.tableView reloadData];
        [self.searchBar resignFirstResponder];
        if (wsResultArr.count == 0) {
            [self showHint:@"暂无相关新闻"];
        }
        self.tableView.mj_footer.hidden = NO;
        [self refreshCurentPg:_currentPage Total:(NSInteger)json[@"Total"] pgSize:(NSInteger)json[@"Pagesize"]];


    } failur:^(NSError *error) {
    }];

}






- (void)gotoNotiControllercreatItem:(WSSearchResult*)result{

    NSInteger newsid = result.Newsid;
    NSInteger ztnewsid = result.ZtNewsid;
    if (newsid>0) {
        Newslist *newsList = [[Newslist alloc] init];
        newsList.Title = result.Title;
        newsList.Id = newsid;
        [self gotoWSContentController:newsList];
    }else{
        ZtNewslist *ztnews = [[ZtNewslist alloc] init];
        ztnews.Title = result.Title;
        ztnews.Id = ztnewsid;
        [self gotoWSContentController:ztnews];
    }
}
- (void)gotoWSContentController:(id)news{
    WSContentController *contentVC = [WSContentController contentControllerWithItem:news];
    //        contentVC.newsLink = @"https://wap.baidu.com";//news.Newslink;
    //    contentVC.docid =[NSString convertIntgerToString:news.Id];
    //    //hideBottomBar
    //    contentVC.wscontentControllerType = WSContentControllerTypeNews;
    [self.navigationController pushViewController:contentVC animated:YES];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WSSearchResult *result = self.result[indexPath.row];
    [self gotoNotiControllercreatItem:result];
}



#pragma mark - tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.result.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"resultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    WSSearchResult *result = self.result[indexPath.row];
    
    cell.textLabel.text = result.Title;
    cell.detailTextLabel.text =[QTCommonTools convertServiceTimeToStandartShowTime:result.Edittime];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    
    cell.textLabel.numberOfLines = 2;
    
    return cell;
    
}





#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    _currentPage = 1;
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self createRefreshNoBegin:self.tableView];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadDataWithCache:(BOOL)cache{
    [self loadDataWithCacheUrl];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (NSMutableArray *)result{
    
    if (!_result) {
        _result = [NSMutableArray array];
    }
    return _result;
}

@end
