//
//  ConfigNews.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/21.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#ifndef ConfigNews_h
#define ConfigNews_h

#import "QTCommonTools.h"
#import "PSTAlertController.h"
#import "QTFHttpTool.h"
#import "HYBNetworking.h"
#import "QTUserInfo.h"
#import "NSString+WF.h"
#import "MJRefresh.h"

#define BlueColorCommon [UIColor colorWithRed:61.0/255 green:161.0/255 blue:229.0/255 alpha:1]
#define  loadingNetWorkStr  @"请稍候..."
#define  loadingWaitingStr  @"请稍候..."
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define  kNotificationInactiveDic  @"NotificationInactiveDic"
#define  kNotificationActiveDic   @"NotificationActiveDic"
#define  kNotificationAddTap   @"kNotificationAddTap"


#define XCODE_COLORS_ESCAPE @"\033[" #define XCODE_COLORS_RESET_FG XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color #define XCODE_COLORS_RESET_BG XCODE_COLORS_ESCAPE @"bg;" // Clear any background color #define XCODE_COLORS_RESET XCODE_COLORS_ESCAPE @";" // Clear any foreground or background color
#define LogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define LogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)



#import "UIViewController+HUD.h"

/**
 *  自定义Log,课放入pch文件
 */
#ifdef DEBUG

#define ECLog(...) NSLog(@"行号:%d 方法名:%s\n %@\n\n",__LINE__,__func__,[NSString stringWithFormat:__VA_ARGS__])

#else
#define ECLog(...)

#endif

static const CGFloat kclipCorner = 5.0;
static const CGFloat kclipCornerSmall = 3.0;
#define REQUEST_URL @"http://api.zrwjk.com:9011/api"
#define REQUEST_URL_root @"http://api.zrwjk.com:9011"





#define kCachedSelectCell     ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:@"/select."])


#endif /* ConfigNews_h */
