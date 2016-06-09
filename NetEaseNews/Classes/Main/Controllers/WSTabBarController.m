//
//  WSTabBarController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSTabBarController.h"
#import "WSTabBar.h"
#import "WSNavigationController.h"
#import "SXAdManager.h"
#import "WSOneMenuModel.h"
#import "WSMenuInstance.h"
#import "QTLoginViewController.h"

@interface WSTabBarController ()
@property (nonatomic ,strong) UIView *adView;
@property (nonatomic ,strong) UIButton *skipBtn;
@end

@implementation WSTabBarController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self adImage];

    [self loadDataAllNewsMenu];

}


- (void)loadDataAllNewsMenu{
    [[QTUserInfo sharedQTUserInfo] loadUserInfoFromDefault];
    [HYBNetworking getWithUrl:@"api/menu" refreshCache:NO params:nil success:^(id response) {
        if ([response isKindOfClass:[NSArray class]]){
            NSArray *deserializedArray = (NSArray *)response;
            NSMutableArray *menuAllArr = [WSOneMenuModel objectArrayWithKeyValuesArray:deserializedArray];
            //获取总的数组
            [WSMenuInstance sharedWSMenuInstance].allMenuArr = menuAllArr;
            //获取导航数组
            [WSMenuInstance sharedWSMenuInstance].tabbarArr = [self getTabbarArr:[WSMenuInstance sharedWSMenuInstance].allMenuArr ];
            [self getMenuOneArr];
            [self loadMenu:YES];
            //去登录
            [self LoadDataLogin:NO];
        } else {
            [self loadMenu:NO];
            //去登录 需要延时
            [self LoadDataLogin:YES];
            NSLog(@"I can't deal with it");
        }
    } fail:^(NSError *error) {
        [self loadMenu:NO];
        //去登录 需要延时
        [self LoadDataLogin:YES];
    }];
}

- (void)LoadDataLogin:(BOOL)isDelay{
    QTLoginViewController *con =[[QTLoginViewController alloc] init];

    if (!isDelay) {
        [con loadDataLogin:NO];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [con loadDataLogin:NO];
    });
    
    
}



- (void)loadMenu:(BOOL)success{
    [self loadViewControllers:success];
    [self loadTabBarItems:success];
}


- (NSMutableArray *)getTabbarArr:(NSMutableArray*)arr{
    NSMutableArray *newArr = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        WSOneMenuModel *model = [arr objectAtIndex:i];
        if (0 == model.Parentid) {
            [newArr addObject:model];
        }
    }
    return newArr;
}

- (void)getMenuOneArr{
    //创建四个数组
    NSMutableArray *newArrone = [NSMutableArray array];
    NSMutableArray *newArrTwo = [NSMutableArray array];
    NSMutableArray *newArrThree = [NSMutableArray array];
    NSMutableArray *newArrFour = [NSMutableArray array];
    
    NSMutableArray *tabbarArr = [WSMenuInstance sharedWSMenuInstance].tabbarArr;
    NSMutableArray *allMenuArr = [WSMenuInstance sharedWSMenuInstance].allMenuArr;
    
    
    for (int i = 0; i < tabbarArr.count; i++) {
        
        //取出一个tabbar 元素
        WSOneMenuModel *modelTabar = [tabbarArr objectAtIndex:i];
        
        //遍历所有元素 和上面的tabbar 比较
        for (int j = 0 ;j < allMenuArr.count;j++) {
            WSOneMenuModel *allMenuOne = [allMenuArr objectAtIndex:j];
            //tabBar 的Parentpath
            NSString *paTabStr = modelTabar.Parentpath;
            //一个元素中串
            NSString *oneStr = allMenuOne.Parentpath;
            BOOL isOk = [oneStr hasPrefix:paTabStr]&&oneStr.length >paTabStr.length;
            if (0 == i&& isOk) {
                [newArrone addObject:allMenuOne];
            }else if(1 == i&&isOk) {
                [newArrTwo addObject:allMenuOne];
            }else if(2 == i&&isOk ) {
                [newArrThree addObject:allMenuOne];
            }else if(3 == i&&isOk ) {
                [newArrFour addObject:allMenuOne];
            }
            
        }
    }
    //获取导航数组one
    [WSMenuInstance sharedWSMenuInstance].menuOneArr = newArrone;
    [WSMenuInstance sharedWSMenuInstance].menuTwoArr = newArrTwo;
    [WSMenuInstance sharedWSMenuInstance].menuThreeArr = newArrThree;
    [WSMenuInstance sharedWSMenuInstance].menuFourArr = newArrFour;
    
}


- (void)adImage{
    [SXAdManager loadLatestAdImage];
    if ([SXAdManager isShouldDisplayAd]) {
        
        // ------这里主要是容错一个bug。
//        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"top20"];
//        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rightItem"];
        
        
        // ------本想吧广告设置成广告显示完毕之后再加载rootViewController的，但是由于前期已经使用storyboard搭建了，写在AppDelete里会冲突，只好就随便整个view广告
        UIView *adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _adView = adView;
        UIImageView *adImg = [[UIImageView alloc]initWithImage:[SXAdManager getAdImage]];
        //添加网易新闻有态度的门户的图片
        UIImageView *adBottomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lauch_bottom"]];
        adView.backgroundColor = [UIColor whiteColor];
        [adView addSubview:adBottomImg];
        [adView addSubview:adImg];
        adBottomImg.frame = CGRectMake(0, self.view.height - 135, self.view.width, 135);
        adImg.frame = CGRectMake(0, 0, self.view.width, self.view.height - 135);
        
        //        adImg.frame = [UIScreen mainScreen].bounds;
        adView.alpha = 0.99f;
        [self.view addSubview:adView];
        
        //添加跳过按钮
        UIButton *skipBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width-90, 20, 50, 30)];
        skipBtn.backgroundColor = [UIColor grayColor];
        [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [QTCommonTools clipAllView:skipBtn Radius:skipBtn.height*0.5 borderWidth:0 borderColor:nil];
        _skipBtn = skipBtn;
        [self.view addSubview:skipBtn];
        [skipBtn addTarget:self action:@selector(skipBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        [UIView animateWithDuration:4 animations:^{
            adView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [self addImageFinish:finished];
        }];
    }else{
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"update"];
    }
}

- (void)skipBtnClicked{
    [self addImageFinish:YES];
}

- (void)addImageFinish:(BOOL)finished{
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [UIView animateWithDuration:1.0 animations:^{
        _adView.alpha = 0.0f;
        _skipBtn.hidden = YES;
    } completion:^(BOOL finished) {
       
        [_skipBtn removeFromSuperview];
        [_adView removeFromSuperview];
    }];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"SXAdvertisementKey" object:nil];
}


- (void)loadViewControllers:(BOOL)success{
    
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UIViewController *vc1 = [sb1 instantiateInitialViewController];
    UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UIViewController *vc2 = [sb1 instantiateInitialViewController];
    UIStoryboard *sb3 = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    UIViewController *vc3 = [sb1 instantiateInitialViewController];
 
    //干掉不同的
//    UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"Reader" bundle:nil];
//    UIViewController *vc2 = [sb2 instantiateInitialViewController];
    
//    UIStoryboard *sb3 = [UIStoryboard storyboardWithName:@"Media" bundle:nil];
//    UIViewController *vc3 = [sb3 instantiateInitialViewController];
    
    UIStoryboard *sb4 = [UIStoryboard storyboardWithName:@"Topic" bundle:nil];
    UIViewController *vc4 = [sb4 instantiateInitialViewController];

    UIStoryboard *sb5 = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    UIViewController *vc5 = [sb5 instantiateInitialViewController];
    
    NSMutableArray *tabArr = [NSMutableArray array];
    [tabArr addObject:vc1];
    [tabArr addObject:vc4];
    if ([WSMenuInstance sharedWSMenuInstance].menuTwoArr.count>0) {
        [tabArr addObject:vc2];
    }
    if ([WSMenuInstance sharedWSMenuInstance].menuThreeArr.count>0) {
        [tabArr addObject:vc3];
    }

    [tabArr addObject:vc5];
    if(success){//新闻+专题+...+我的
        self.viewControllers = tabArr;
    }else{//新闻+专题+我的
       self.viewControllers = @[vc1,vc1, vc4, vc5];
    }
}


- (void)loadTabBarItems:(BOOL)success{
    
    WSTabBarItem *item1 = [WSTabBarItem tabBarItemWithTitle:@"新闻" itemImage:[UIImage imageNamed:@"tabbar_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_news_highlight"]];
    
    WSTabBarItem *item2 = [WSTabBarItem tabBarItemWithTitle:@"资讯" itemImage:[UIImage imageNamed:@"tabbar_icon_reader_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_reader_highlight"]];
    
    WSTabBarItem *item3 = [WSTabBarItem tabBarItemWithTitle:@"专栏" itemImage:[UIImage imageNamed:@"tabbar_icon_media_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_media_highlight"]];
    
    WSTabBarItem *item4 = [WSTabBarItem tabBarItemWithTitle:@"话题" itemImage:[UIImage imageNamed:@"tabbar_icon_bar_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_bar_highlight"]];
    
    WSTabBarItem *item5 = [WSTabBarItem tabBarItemWithTitle:@"我" itemImage:[UIImage imageNamed:@"tabbar_icon_me_normal"] selectedImage:[UIImage imageNamed:@"tabbar_icon_me_highlight"]];
    
    
    //固定添加
    NSMutableArray *itemArr = [NSMutableArray array];
    NSMutableArray *itemArrSuccess = [NSMutableArray array];
    [itemArrSuccess addObject:item1];//新闻
    [itemArrSuccess addObject:item4];//话题
    NSMutableArray *itemArrNotSuccess = [NSMutableArray array];
    if ([WSMenuInstance sharedWSMenuInstance].menuTwoArr.count>0) {
        [itemArrSuccess addObject:item2];//资讯
    }
    if ([WSMenuInstance sharedWSMenuInstance].menuThreeArr.count>0) {
        [itemArrSuccess addObject:item3];//专栏
    }
    //固定添加我的
    
    if(success){
        [itemArrSuccess addObject:item5];
        [itemArr addObjectsFromArray:itemArrSuccess];
    }else{
        [itemArrNotSuccess addObject:item1];//新闻
        [itemArrNotSuccess addObject:item2];//新闻

        [itemArrNotSuccess addObject:item4];//话题
        [itemArrNotSuccess addObject:item5];//我的
        [itemArr addObjectsFromArray:itemArrNotSuccess];
    }
    WSTabBar *tabBar = [WSTabBar tabBarWithItems:itemArr itemClick:^(NSInteger index) {
        self.selectedIndex = index;
    } ];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
}


@end
