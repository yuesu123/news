//
//  PrefixHeader.h
//  BaiduNuomi
//
//  Created by WackoSix on 16/1/29.
//  Copyright © 2016年 www.wackosix.cn. All rights reserved.
//

//**************调试和发布版本之间的设置*****************

#ifdef DEBUG //调试模式--模拟器

#define HMLog(...) NSLog(__VA_ARGS__)  //公司自定义打印

#else //发布模式 RELEASE--真机

#define HMLog(...)  //发布版本下取消自定义打印，自定义打印不起作用

#endif

//**************所有objective-c文件共享的头文件*****************

#ifdef __OBJC__  //所有objective-c文件共享的头文件

#import "UIView+Frame.h"
#import <UIKit/UIKit.h>
#import "ThemeManager.h"


static NSString *sg_privateNetworkBaseUrl = @"http://xapp.blnews.com.cn";
//关于我们
static NSString *sg_privateAboutMe = @"/s/aboutus";
//天气
static NSString *sg_privateAboutWether = @"/s/weather";
//隐私政策
static NSString *sg_privateAbouTPrivtazhence = @"/s/items";
//新闻爆料
static NSString *sg_privateAboutBaoliao= @"/s/baoliao";
//新闻爆料
static NSString *sg_privateAboutMyBaoliao= @"/s/baoliaolist";
//积分
static NSString *sg_privateAboutMyJifen= @"/s/jifen";

//我的信息
static NSString *sg_privateAboutMyUserInfo= @"/s/userinfo";

//我的头像
static NSString *sg_privateAboutMyImage= @"/s/userphoto";

//http://xapp.blnews.com.cn/s/userphoto?userid=9
//用户信息：http://xapp.blnews.com.cn/s/userinfo?userid=9


#define kScreenSize [UIScreen mainScreen].bounds
#define kScreenWidth kScreenSize.size.width
#define kScreenHeight kScreenSize.size.height
#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)
#define kTabBarHeight 64
#define kTitleFont [UIFont systemFontOfSize:15]
#define kDetailFont [UIFont systemFontOfSize:13]

#define UmengAppkey  @"574ff7dc67e58eaa1800005b"//公司的


//#define UmengAppkey  @"554b577267e58e761d0027b6"//公司的 //@"5211818556240bc9ee01db2f"//友盟的
#define strNotNil(str)  (str.length>0&&str)

#import "ConfigNews.h"
#import "Config.h"
#import "ColorHelper.h"
#import "MBProgressHUD+HM.h"
#import "UIView+ZLExtension.h"
#import "BaseViewController.h"
#import "BaseViewController2.h"

#endif

//*************************公用的头文件************************