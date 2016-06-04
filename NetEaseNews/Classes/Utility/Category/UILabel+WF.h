//
//  UILabel+WF.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-21.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(WF)


-(CGFloat)getHeightOfContentForWidth:(CGFloat)width fontSize:(CGFloat)font;

- (CGFloat)heightForStringFontSize:(CGFloat)fontSize andWidth:(CGFloat)width;
@end
