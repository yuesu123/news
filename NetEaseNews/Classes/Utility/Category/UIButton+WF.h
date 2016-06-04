//
//  UIButton+WF.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-20.
//  Copyright (c) 2015年 qitian. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIButton (WF)

/**
 * 设置普通状态与高亮状态的背景图片
 */
-(void)setN_BG:(NSString *)nbg H_BG:(NSString *)hbg;

/**
 * 设置普通状态与高亮状态的拉伸后背景图片
 */
-(void)setResizeN_BG:(NSString *)nbg H_BG:(NSString *)hbg;
@end

