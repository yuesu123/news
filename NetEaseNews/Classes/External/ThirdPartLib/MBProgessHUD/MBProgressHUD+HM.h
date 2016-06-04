//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 gw. All rights reserved.
//

#import "MBProgressHUD.h"
#import "Singleton.h"

@interface MBProgressHUD (HM)<MBProgressHUDDelegate>

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
- (void)showWithCustomView:(NSString*)showText
                detailText:(NSString*)detailText
                     isCue:(int)isCue
                 delayTime:(CGFloat)delayTime isKeyShow:(BOOL)isKeyboardShow;

@end
