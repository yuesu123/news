//
//  Config.h
//  CarPool
//
//  Created by kiwi on 14-6-23..
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//

#ifndef Spartan_Education_Config_h
#define Spartan_Education_Config_h

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
#define kCGImageAlphaPremultipliedLast  (kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast)
#else
#define kCGImageAlphaPremultipliedLast  kCGImageAlphaPremultipliedLast
#endif
#define String(__key) NSLocalizedString(__key, nil)

#define KDeafultBtn [[UIImage imageNamed:@"btn_Login_d"] stretchableImageWithLeftCapWidth:11 topCapHeight:0]
#define KDeafultBtn_D [[UIImage imageNamed:@"btn_Login_n"] stretchableImageWithLeftCapWidth:11 topCapHeight:0]

#define KWAlertBtnCan [[UIImage imageNamed:@"GreenColorBtn"] stretchableImageWithLeftCapWidth:5 topCapHeight:0]
#define KWAlertBtnOt [[UIImage imageNamed:@"WhiteColor"] stretchableImageWithLeftCapWidth:5 topCapHeight:0]
#define BkgSkinColor RGBCOLOR(0, 121, 220)
#define NtfLogin @"BSNotificationLogin"
#define NtSubfLogin @"BSSubNotificationLogin"
#define NtfInfoUpdate @"BSNotificationInfoUpdate"
#define UMShareKey @"53d5fda456240bbd0f0096b0"
#define kBaseIfCloseAPNS                @"baseIfCloseAPNS"
#define marg5               5
#define kAlixUUID  @"AlixUuid"
#define huanxinsuccess  @"huanxinsuccess"
#define kusernameMe  @"usernameMe"
//#import "Globals.h"
#define isLouzhuOnlyNum 999999 //代表楼主的标示

#define PassX 120

#define Release(__object) if(__object){__object=nil;}


#define kUnCharchiveFilePathUser [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"offenUser.data"]
#define isLoginHX @"isLogInHX"
#define outOfKeyBoard @"outOfKeyBoard"
#define checkNewworkHostName  @"www.baidu.com"



#define KNotificationOfHadLoginin @"NotificationOfHadLoginin"
/*------------主人翁0730--------*/
//方法
#define createMutArray [NSMutableArray array]
#define createMutDict  [NSMutableDictionary dictionary]
#define strNotNil(str)  (str.length>0&&str)
#define strEq(str1,str2)  ([str1 isEqualToString:str2])
#define strEqInt(str,aIntValue)  ([str isEqualToString:[aIntValue integerValue]])

#define strIsNil(str)  ((str.length==0)||(!str))

#define getStrFromFloat(floatValue)      [NSString stringWithFormat:@"%f",floatValue]
#define getStrFromInt(intValue)      [NSString stringWithFormat:@"%d",intValue]
#define getStrFromIntger(NSInteger)      [NSString stringWithFormat:@"%ld",NSInteger]
#define NSURLWithStr(NSString)   [NSURL URLWithString:NSString]
#define standardUser [NSUserDefaults standardUserDefaults]
#define standardUserForKey(NSString)   [[NSUserDefaults standardUserDefaults] objectForKey:NSString]
#define    kNotificationFreshHomeTable @"kNotifireFreshHomeTable"

#define codeStr  standardUserForKey(@"invite_code")?[NSString stringWithFormat:@"邀请码%@",standardUserForKey(@"invite_code")]:@""
#define shareTitleHasCode [NSString  stringWithFormat:@"%@%@",@"【北仑新区时刊】",@""]

//常量
//适配时放缩比例
#define SCALE ([UIScreen mainScreen].bounds.size.width/320.0)
#define  prescripDict  @"kPrescripDict"
#define  MD5_Check_Code  @""//
//#define redCommon RGBACOLOR(248, 78, 90, 0.85)
//#define redCommon RGBACOLOR(248, 78, 90, 0.85)
#define redCommon  [UIColor colorWithPatternImage:[UIImage imageNamed:@"redDotColor"]]
#define bgcolor [UIColor colorWithRed:239.0/255 green:239.0/255 blue:260.0/255 alpha:1]
//RGBACOLOR(252.0, 103.0, 109.0, 1.0)//后来给的;
#define lightTabCommon [UIColor colorWithRed:239.0/255 green:239.0/255 blue:260.0/255 alpha:1]
#define darkRed [UIColor colorWithRed:100.0/255 green:3.0/255 blue:6.0/255 alpha:1]
//#define shareBtnOrder        [NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToSina,UMShareToTencent,UMShareToSms,UMShareToEmail,nil]

#define shareBtnOrder        [NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToSina,UMShareToSms,nil]

#define shareContend   [QTPastValue sharedQTPastValue].hintData
#define shareForAddInteger [QTPastValue sharedQTPastValue].prescriptionShareHint
#define shareTitleDownload  @"【北仑新区时刊】"
#define shareTitle  @"【北仑新区时刊】"
#define shareurlStr  @"http://a.app.qq.com/o/simple.jsp?pkgname=com.qitian.massage"

#define faceCheckNo @"检测失败,请重新拍照检测"
#define toochCheckNo @"舌头检测失败,请重新拍照检测"
//#define isShouldCloseWhenChecking @"isShouldCloseWhenChecking"
#define isContactServiceTag  @"isContactServiceTag"

#if DEBUG
#define notifyURLAlipay @"http://112.74.208.243:9013/AlipayNotifyUrl/notifyUrl"
#else
#define notifyURLAlipay @"http://api.zrwjk.com:9011/AlipayNotifyUrl/notifyUrl"
#endif   // 崩溃

#define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];\
[alert show];

#define SHOW_ALERT_Error(_msg_,str)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:str, nil];\
[alert show];

#define  setObjectWithStr(dic,objectStr,key) \
if (strNotNil(objectStr)) {\
    [dic setObject:objectStr forKey:key];\
}\

#define crashStr @"crashStr"

#define blackColorMe     [UIColor blackColor]
#define darkGrayColorMe  [UIColor darkGrayColor]
#define lightGrayColorMe [UIColor lightGrayColor]
#define whiteColorMe      [UIColor whiteColor]
#define grayColorMe        [UIColor grayColor]
#define blueColorMe       [UIColor blueColor]
#define greenColorMe     [UIColor greenColor]
#define yellowColorMe    [UIColor yellowColor]
#define magentaColorMe  [UIColor magentaColor]
#define orangeColorMe   [UIColor orangeColor]
#define purpleColorMe   [UIColor purpleColor]
#define brownColorMe   [UIColor brownColor]
#define clearColorMe   [UIColor clearColor]





/*------------主人翁0730--------*/


#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height
#define MAIN         [UIScreen mainScreen].bounds
// 使用方法: x和w 用XHpixw      y和h 用pixw

#define pixw(p)  ((SCREEN_WIDTH/320.0)*p)
#define pixh(p)  SCREEN_HEIGHT/568.0*p
#define XHpixw(p)  ((SCREEN_WIDTH/375.0)*p)
#define XHpixh(p)  SCREEN_HEIGHT/667.0*p

//#define pixw(p)  ((SCREEN_WIDTH/414.0)*p)
//#define pixh(p)  SCREEN_HEIGHT/736.0*p
//
//#define XHpixw(p)  ((SCREEN_WIDTH/375.0)*p/2)
//#define XHpixh(p)  SCREEN_HEIGHT/667.0*p/2

// 配图
// 1张配图的宽度
#define IWPhotoW IWPhotoH*0.7
// 1张配图的高度
#define IWPhotoH 300
// 配图之间的间距
#define IWPhotoMargin 10
// 返回最大列数
#define IWPhotosMaxCols(count) ((count == 4) ? 1 : 1)

#define lightCyneCommon RGBCOLOR(239,255,247)
#define blackCommon RGBCOLOR(51, 51, 51)
#define greenCommon RGBCOLOR(88, 225, 179)
#define bkgColor RGBCOLOR(164, 158, 163)
#define RbkgColor RGBACOLOR(164, 158, 163, 0.382)
#define bkgViewColor RGBCOLOR(234, 234, 234)
#define Sys_Version [[UIDevice currentDevice].systemVersion doubleValue]
/**当前应用版本*/
#define appCurVersionStr  ([[[NSBundle mainBundle] infoDictionary]  objectForKey:@"CFBundleShortVersionString"])
//app build版本号
#define kAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define APPKEY @"0e93f53b5b02e29ca3eb6f37da3b05b9"

#define kQueueDEFAULT dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kQueueHIGH dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
#define kQueueLOW dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
#define kQueueBACKGROUND dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
#define kQueueMain dispatch_get_main_queue()

#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@"png"]]
#define LOADIMAGECACHES(file) [UIImage imageNamed:file]

//register:用户注册 不需要
//Login:用户注册
//shareApp：APP分享
//invitationCode：邀请码 不需要

//用户注册 -1   不需要
#define addIntegerRegister @"register"
//用户签到   不需要
#define addIntegerLogin @"login"
//APP分享 -1  不需要
#define addIntegershareApp @"shareApp"
//APP分享到朋友圈
#define addIntegerShareAppToCircle @"shareAppToCircle"
#define addIntegerprescriptionShareToCircle @"prescriptionShareToCircle" //播放完分享到朋友圈
//专家分享 -1  不需要
#define addIntegershareExpertDownloadApp @"shareExpertDownloadApp"
#define addIntegershareExpertNew @"shareExpert"//最新的逻辑

//补填邀请码 -1  不需要
#define addIntegerinvitationCode @"invitationCode"
//浏览文章
#define addIntegerarticleView @"articleView"
//分享文章
#define addIntegerarticleShare @"articleShare"
//专家评论 -1
#define addIntegerexpertComment @"expertComment"
//视频评论 -1
#define addIntegercourseComment @"courseComment"
//方子分享 -1
#define addIntegerprescriptionShare @"prescriptionShare"
//学位分享 -1
#define addIntegeracupointShare @"acupointShare"
//购买视频 -1
#define addIntegercoursePay @"coursePay"
//购买咨询 -1
#define addIntegerConsultation @"consultation"
//妈妈班培训报名费
#define addIntegerRrainingRegPay @"trainingRegPay"
//上门服务
#define addIntegerReservationPay @"reservationPay"
//在线直播付费获取积分
#define addIntegerRrainingClassPay @"trainingClassPay"


/******************************************************/

/****  debug log **/ //NSLog输出信息

#ifdef DEBUG

#define DLog( s, ... ) NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#else

#define DLog( s, ... ) NSLog(@"")

#endif


/***  DEBUG RELEASE  */

#if DEBUG

#define MCRelease(x)

#else

#define MCRelease(x)

#endif
#define msgForcell  @"*0123456789*0123456789*0123456789*0123456789*0123456789*0123456789*0123456789*0123456789*01234567890123456789"

#if DEBUG
//develop 证书
#else
 //生产证书 调试发布
#endif   // 崩溃

#pragma mark - Frame(宏 x,y,width,height)

 
#define MainScreenScale [[UIScreen mainScreen]scale] //屏幕的分辨率 当结果为1时，显示的是普通屏幕，结果为2时，显示的是Retian屏幕
// App Frame Height&Width
#define Application_Frame  [[UIScreen mainScreen] applicationFrame] //除去信号区的屏幕的frame
#define APP_Frame_Height   [[UIScreen mainScreen] applicationFrame].size.height //应用程序的屏幕高度
#define App_Frame_Width    [[UIScreen mainScreen] applicationFrame].size.width  //应用程序的屏幕宽度
/*** MainScreen Height Width */
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define iPhone6plusHeight  736//主屏幕的高度
#define iPhone6Height  667//主屏幕的高度
#define iPhone5Height  568//主屏幕的高度
#define rate120  1.2
//#define rate130  1.3

//  <=iphone5 1.0    =iphone6 1.1    =iphone6plus 1.1                                5
#define rate101213 ((Main_Screen_Height < iPhone6Height)?1.0:       ((Main_Screen_Height<iPhone6plusHeight)?1.1:((Main_Screen_Height==iPhone6plusHeight)?1.2:1.3 ))   )


/*
 ((Main_Screen_Height==iPhone6plusHeight)?1.2:1.3 )
 (Main_Screen_Height<iPhone6plusHeight)?1.1:()
 
 ((Main_Screen_Height = iPhone6plusHeight)?1.2:1.3)
(Main_Screen_Height<iPhone6plusHeight)?1.1:()
 ((Main_Screen_Height = iPhone6plusHeight)?1.2:1.3))
*/


#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度

// View 坐标(x,y)和宽高(width,height)
#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define ViewWIDTH(v)           (v).frame.size.width
#define ViewHEIGHT(v)          (v).frame.size.height

#define MinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
#define MinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define MidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define MidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

#define CONTRLOS_FRAME(x,y,width,height)     CGRectMake(x,y,width,height)

//    系统控件的默认高度
#define kStatusBarHeight   (20.f)
#define kTopBarHeight      (44.f)
#define kBottomBarHeight   (49.f)

#define kCellDefaultHeight (44.f)

// 当控件为全屏时的横纵左边
#define kFrameX             (0.0)
#define kFrameY             (0.0)

#define kPhoneFrameWidth                 (320.0)
#define kPhoneWithStatusNoPhone5Height   (480.0)
#define kPhoneNoWithStatusNoPhone5Height (460.0)
#define kPhoneWithStatusPhone5Height     (568.0)
#define kPhoneNoWithStatusPhone5Height   (548.0)

#define kPadFrameWidth                   (768.0)
#define kPadWithStatusHeight             (1024.0)
#define kPadNoWithStatusHeight           (1004.0)

#define isiOS7 ([UIDevice currentDevice].systemVersion.doubleValue >= 7.0)&&([UIDevice currentDevice].systemVersion.doubleValue < 8.0)
#define iSiOS6 ([UIDevice currentDevice].systemVersion.doubleValue < 7.0)

#define iOS81 ([UIDevice currentDevice].systemVersion.doubleValue >= 8.1)
#define iOS8 ([UIDevice currentDevice].systemVersion.doubleValue >= 8.0)
// 是否为4inch
#define FourInch ([UIScreen mainScreen].bounds.size.height == 568.0)


//中英状态下键盘的高度
#define kEnglishKeyboardHeight  (216.f)
#define kChineseKeyboardHeight  (252.f)

#pragma mark - Funtion Method (宏 方法)
//PNG JPG 图片路径
#define PNGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)          [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

//加载图片
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMAGENAMED(NAME)       [UIImage imageNamed:NAME]

//字体大小（常规/粗体）
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME,FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define   Bold19     BOLDSYSTEMFONT(19)
#define   Bold18     BOLDSYSTEMFONT(18)
#define   Bold16     BOLDSYSTEMFONT(16)
#define   Bold15     BOLDSYSTEMFONT(15)
#define   Bold14     BOLDSYSTEMFONT(14)
#define   Bold13     BOLDSYSTEMFONT(13)
#define   Bold12     BOLDSYSTEMFONT(12)
#define   System16     SYSTEMFONT(16)
#define   System15     SYSTEMFONT(15)
#define   System14     SYSTEMFONT(14)
#define   System13     SYSTEMFONT(13)
#define   System12     SYSTEMFONT(12)
#define   System11     SYSTEMFONT(11)


//当前版本
#define FSystenVersion            ([[[UIDevice currentDevice] systemVersion] floatValue])
#define DSystenVersion            ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SSystemVersion            ([[UIDevice currentDevice] systemVersion])

//当前语言
#define CURRENTLANGUAGE           ([[NSLocale preferredLanguages] objectAtIndex:0])

//是否Retina屏
#define isRetina                  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) :NO)
//是否iPhone5
#define ISIPHONE                  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define ISIPHONE5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

// UIView - viewWithTag 通过tag值获得子视图
#define VIEWWITHTAG(_OBJECT,_TAG)   (id)[_OBJECT viewWithTag : _TAG]

//应用程序的名字
#define AppDisplayName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

//判断设备室真机还是模拟器
#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

#endif
