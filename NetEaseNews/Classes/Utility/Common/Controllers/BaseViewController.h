//
//  BaseViewController.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-5-5.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UITableViewController{
        NSInteger _currentPage;
}
@property (nonatomic, strong) UIView* noNetView;
@property (nonatomic, strong) UIButton* reLoad;
@property (nonatomic, strong) UIButton *leftBarButton;

- (void)endRefresh;
- (void)createRefresh;
- (void)refreshCurentPg:(NSInteger)currentPage Total:(NSInteger)Total pgSize:(NSInteger)pgSize;
- (void)loadDataWithCache:(BOOL)cache;


/**
 *  添加在一个指定rect的正中间 里面的btn 和image 随外面的rect改变
 *
 *  @param arr  @param arr  原来的数组个数
 *  @param rect @param rect 指定的rect 上显示娃娃
 *  @param title  提示的文字
 *  @param font  title 字体  使用默认传nil
 *  @param color  title color 使用默认传nil
 */
- (void)addNotingView:(NSInteger)count view:(id)oldview title:(NSString*)title font:(UIFont*)font color:(UIColor*)color;
- (void)addNotingViewTop:(NSInteger)count view:(id)oldview title:(NSString*)title font:(UIFont*)font color:(UIColor*)color;

@end
