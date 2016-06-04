//
//  AppDelegate.h
//  网易新闻
//
//  Created by WackoSix on 15/12/25.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *appKey = @"07feba3e3c5b848439b3ea01";
static NSString *channel = @"Publish channel";
#if DEBUG //调试
static BOOL isProduction = FALSE;
#else
static BOOL isProduction = TRUE;
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

