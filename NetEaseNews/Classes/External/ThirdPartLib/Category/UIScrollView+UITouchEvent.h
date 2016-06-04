//
//  UIScrollView+UITouchEvent.h
//  ZhuRenWong
//
//  Created by HLH on 15/9/16.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (UITouchEvent)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event ;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
