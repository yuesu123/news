    //
    //  BaseViewController.m
    //  ZhuRenWong
    //
    //  Created by wangfeng on 15-5-5.
    //  Copyright (c) 2015年 qitian. All rights reserved.
    //

#import "BaseViewController2.h"

@interface BaseViewController2 ()
@property (nonatomic, strong) UIView  *nothingView;
@property (nonatomic, strong) UIButton  *leftBtn;

@end

@implementation BaseViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self noNetView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setImage:[UIImage imageNamed:@"top_navigation_back"] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 45, 45)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    
    [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    _leftBtn = btn;
    self.navigationItem.leftBarButtonItem= rightItem;

}

- (void)backBtnClicked:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    ECLog(@"父类名字:%@",[self class]);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    ECLog(@"父类名字:%@",[self class]);
}
-(UIView *)noNetViewScroll
{
    if (!_noNetViewScroll) {
        _noNetViewScroll = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64)
                      ];
        _noNetViewScroll.backgroundColor = [UIColor whiteColor];
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.center = CGPointMake( _noNetViewScroll.center.x,_noNetViewScroll.center.y-64);
        imageView.bounds = CGRectMake(0, 0, 100, 100);
        imageView.image = [UIImage imageNamed:@"nowifi"];
        //_noNetView.backgroundColor = [UIColor redColor];
        [_noNetViewScroll addSubview:imageView];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat y = CGRectGetMaxY(imageView.frame);
        btn.bounds = CGRectMake(0, 0, 300, 40 );
        btn.center = CGPointMake(self.noNetViewScroll.center.x, y+20);
        [btn setTitle:@"连接失败，点我，重新加载" forState: UIControlStateNormal];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        self.reLoad = btn;
        
        [_noNetViewScroll addSubview:btn];
        
        _noNetViewScroll.hidden = YES;
        [self.view addSubview:_noNetViewScroll];
    }
    return _noNetViewScroll;
}

-(UIView *)noNetView
{
    if (!_noNetView) {
        _noNetView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)
                      ];

        _noNetView.backgroundColor = [UIColor whiteColor];
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.center = CGPointMake( _noNetView.center.x,_noNetView.center.y-64);
        imageView.bounds = CGRectMake(0, 0, 100, 100);
        imageView.image = [UIImage imageNamed:@"nowifi"];
            //_noNetView.backgroundColor = [UIColor redColor];
        [_noNetView addSubview:imageView];
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];

        CGFloat y = CGRectGetMaxY(imageView.frame);
        btn.bounds = CGRectMake(0, 0, 300, 40 );
        btn.center = CGPointMake(self.noNetView.center.x, y+20);

        [btn setTitle:@"连接失败，点我，重新加载" forState: UIControlStateNormal];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        self.reLoad = btn;

        [_noNetView addSubview:btn];
        
        _noNetView.hidden = YES;
        [self.view addSubview:_noNetView];
    }
    return _noNetView;
}



- (void)addNotingView:(NSInteger)count view:(id)oldview title:(NSString*)title font:(UIFont*)font color:(UIColor*)color{
    UIView *view ;
    if([oldview isKindOfClass:[UIView class]]){
        view = (UIView*)oldview;
//        view.backgroundColor = redCommon;
    }

//    UIView *bigview = [[UIView alloc] initWithFrame:view.bounds];
//    bigview.backgroundColor = [UIColor whiteColor];
//    UIImageView* imageView = [[UIImageView alloc]init];
//    int minValue = MIN(view.size.width, view.size.height);
//    int imageH = minValue*0.44;//182/414 = 0.44
//    CGFloat rate = 244.0/182.0;
//    int imageW = rate*imageH;
//    imageView.frame = CGRectMake((bigview.width-imageW)*0.5, (bigview.height - imageH)*0.5-20, imageW, imageH);
    
    UIView *bigview = [[UIView alloc] initWithFrame:view.bounds];
    bigview.backgroundColor = [UIColor whiteColor];
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    int minValue = MIN(view.size.width, view.size.height);
    int imageH = minValue*0.44;//182/414 = 0.44
    CGFloat rate = 182.0/182.0;
    int imageW = rate*imageH;
    imageView.frame = CGRectMake((bigview.width-imageW)*0.5, (bigview.height - imageH)*0.5-20, imageH, imageH);
    imageView.image = [UIImage imageNamed:@"logo"];
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
    if (title) {
        [btn setTitle:@"暂无数据" forState: UIControlStateNormal];
    }else{
        [btn setTitle:title forState: UIControlStateNormal];
    }
    
    [self.view bringSubviewToFront:bigview];
//    if(count>0){ //不隐藏
//        for (UIView*view in bigview.subviews) {
//            [view removeFromSuperview];
//        }
//        [bigview removeFromSuperview];
//        return;
//    }
    
    
    if(count>0){ //不隐藏
        //        for (UIView*view1 in bigview.subviews) {
        //            [view1 removeFromSuperview];
        //        }
        //        [bigview removeFromSuperview];
        //        [view removeFromSuperview];
        //        return;
        bigview.hidden = YES;
        self.view.userInteractionEnabled = YES;

//        view.hidden = YES;
    }else{
        bigview.hidden = NO;
        self.view.userInteractionEnabled = NO;
//        view.hidden = NO;
    }
    
}

@end
