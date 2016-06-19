//
//  WSNewsController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNewsContainerController.h"
#import "UIView+Frame.h"
#import "WSContainerController.h"
#import "WSNewsController.h"
#import "WSChannel.h"
#import "WSSearchController.h"
#import "WSDayNewsController.h"
#import "WSMenuInstance.h"
#import "WSOneMenuModel.h"

@interface WSNewsContainerController ()

@property (strong, nonatomic) NSArray *news;

@end

@implementation WSNewsContainerController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:self.news.count];
    
    
    for (WSChannel *ch in self.news) {
        
        WSNewsController *newVC = [WSNewsController newsController];
        newVC.channelUrl = ch.channelURL;
        newVC.title = ch.tname;
        newVC.channelID = ch.tid;
        [vcs addObject:newVC];
    }
    
    WSContainerController *containVC = [WSContainerController containerControllerWithSubControlers:vcs parentController:self];
    containVC.navigationBarBackgrourdColor = [UIColor whiteColor];
    
    [self loadInterface];
}


- (void)loadInterface {
    
    //titleView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_netease"]];
    self.navigationItem.titleView = imageView;
    
    if (self.tabBarController.selectedIndex == 0) {
        //leftitem
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_navi_bell_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
        leftItem.enabled = NO;
        self.navigationItem.leftBarButtonItem = leftItem;
        
        //rightItem
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
   
    
    
}

- (void)leftItemClick {
    //不允许点击
    return;
    WSDayNewsController *dayNews = [WSDayNewsController dayNews];
    //hideBottomBar

    [self.navigationController pushViewController:dayNews animated:YES];
}

- (void)rightItemClick {
    
    WSSearchController *searchVC = [[WSSearchController alloc] init];
    //hideBottomBar

    [self.navigationController pushViewController:searchVC animated:YES];
    
}

#pragma mark - lazy loading

- (NSArray *)news{
    
//    if (!_news) {
        NSMutableArray *arrM = [NSMutableArray array];
        NSMutableArray* arrModelAll;
        if (self.tabBarController.selectedIndex == 0&&([WSMenuInstance  sharedWSMenuInstance].tabbarArr.count == 1)) {
            arrModelAll  = [WSMenuInstance sharedWSMenuInstance].menuOneArr;
        }else if(self.tabBarController.selectedIndex == 0&&([WSMenuInstance  sharedWSMenuInstance].tabbarArr.count == 2)) {
            arrModelAll  = [WSMenuInstance sharedWSMenuInstance].menuOneArr;
        }else if(self.tabBarController.selectedIndex == 2&&([WSMenuInstance  sharedWSMenuInstance].tabbarArr.count == 2)) {
            arrModelAll  = [WSMenuInstance sharedWSMenuInstance].menuTwoArr;
        }else if(self.tabBarController.selectedIndex == 0&&([WSMenuInstance  sharedWSMenuInstance].tabbarArr.count == 3)) {
            arrModelAll  = [WSMenuInstance sharedWSMenuInstance].menuOneArr;
            
        }else if(self.tabBarController.selectedIndex == 2&&([WSMenuInstance  sharedWSMenuInstance].tabbarArr.count == 3)) {
            arrModelAll  = [WSMenuInstance sharedWSMenuInstance].menuTwoArr;
        }else if(self.tabBarController.selectedIndex == 3&&([WSMenuInstance  sharedWSMenuInstance].tabbarArr.count == 3)) {
            arrModelAll  = [WSMenuInstance sharedWSMenuInstance].menuThreeArr;
        }
        
        for (WSOneMenuModel *model in arrModelAll) {
            /**频道的标识*/
            WSChannel *ch = [[WSChannel alloc] init];
            ch.tid = [NSString convertIntgerToString:model.Id];
            ch.tname= model.Classname;
            ch.channelURL = [NSString convertIntgerToString:model.Id];
            
            [arrM addObject:ch];
        }
        
        _news = arrM.copy;
        
//    }
    return _news;
}



@end
