//
//  Globals.h
//  CarPool
//
//  Created by kiwi on 14-6-23..
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//


#import <Foundation/Foundation.h>

// net work
#define ShouldLogAfterRequest   1
#define ShouldLogAfterJson      1
#define ShouldLogXMPPDebugInfo  0

#define DB_Version @"1.0.3"
#define defaultSizeInt 20

#define KBSSDKErrorDomain           @"CarPoolSDKErrorDomain"
#define KBSSDKErrorCodeKey          @"CarPoolSDKErrorCodeKey"
#define KBSSDKErrorLocation         @"获取位置失败请在”设置 - 隐私 - 定位服务“中允许拼友访问您的位置"
#define KBSSDKErrorLocationPublish         @"获取位置失败,请在”设置 - 隐私 - 定位服务“中允许拼友访问您的位置,否则无法发布路线喔!"

typedef enum
{
	KBSErrorCodeInterface	= 100,
	KBSErrorCodeSDK         = 101,
}KBSErrorCode;

typedef enum
{
	KBSSDKErrorCodeParseError       = 200,
	KBSSDKErrorCodeRequestError     = 201,
	KBSSDKErrorCodeAccessError      = 202,
	KBSSDKErrorCodeAuthorizeError	= 203,
}KBSSDKErrorCode;

typedef void (^Img_Block)(UIImage *img);
// data
#define NUMBERS @"0123456789\n"
#define LETTERS @"abcdefghijklmnopqrstuvwxvz\n"
#define SIZE_FONT16 16
#define SIZE_FONT15 15
#define SIZE_FONT14 14
#define SIZE_FONT13 13
#define SIZE_FONT12 12
#define SIZE_FONT10 10
#define kCornerRadiusNormal     5.0
#define kCornerRadiusSmall      4.0
#define bkgNameOfView           @"bkg_view"
#define bkgNameOfInputView      @"bkg_input"

@interface Globals : NSObject
+ (BOOL) isValidPhone:(NSString*)value;
+ (void)createTableIfNotExists;
+ (void)initializeGlobals;
+(UIButton*)clipButton:(float)cor btn:(UIButton*)btn;
+ (UIColor*)getColorViewBkg;
+ (UIColor*)getColorGrayLine;
+ (UIImage*)getImageInputViewBkg;
+ (UIImage*)getImageDefault;
+ (UIImage*)getImageRoomHeadDefault;
+ (UIImage*)getImageUserHeadDefault;
+ (UIImage*)getImageGray;
+ (UIImage *)getImageWithColor:(UIColor*)color;
+(UIView*)clipView:(float)cor view:(UIView*)view;
+ (UILabel*)createLable:(CGRect)rect
                   font:(float)font
               boldFont:(BOOL)boldFont
             numoflines:(int)numsofline
          adjustYesOrNo:(BOOL)adjustYesOrNo
                content:(NSString*)str
                  color:(UIColor*)color;
+ (NSString*)showCouponNameWithName:(NSString*)name extent:(float)extent unit:(NSString*)unit type:(int)type;
+ (CGSize)calculateLableSizeWithMaxWidth:(float)contentLabelMaxW  content:(NSString*)str  font:(UIFont*)font;
+ (CGSize)calculateLableWidth:(float)contentLabelMaxH  content:(NSString*)str  font:(UIFont*)font;

+ (NSString*)showCouponNameWith_Noprice:(NSString*)name extent:(float)extent unit:(NSString*)unit type:(int)type;

+ (UIButton*)CreatCellLable:(UITableViewCell*)cell
                    content:(NSString*)str
                  CGrectOut:(CGRect)rectOut
                   CGrectIn:(CGRect)rectIn
              textAlignment:(NSTextAlignment)textAlignment
                       font:(int)font
                     isBold:(BOOL)isBold
                       nums:(int)nums
                   isAdjust:(BOOL)isAdjust
                      color:(UIColor*)color;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString*)convertDateFromString:(NSString*)uiDate timeType:(int)timeType;
+ (NSString*)timeStringWith:(NSTimeInterval)timestamp;
+ (NSString*)getBaiduAdrPic:(CGFloat)lat lng:(CGFloat)lng;
+ (NSString*)getBaiduAdrPicForTalk:(CGFloat)lat lng:(CGFloat)lng;
+ (void)removeAllItemsInFolder:(NSString*)path;
+ (NSTimeInterval)fileCreateDate:(NSString*)filePath;
+ (NSString*)timeString;
+ (void)imageDownload:(Img_Block)block url:(NSString*)url;

+ (NSString*)sendTimeString:(double)sendTime;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSString *)generateUUID;

+ (NSString*)getDate:(NSTimeInterval)createtime;
+ (NSString *)getTime:(NSTimeInterval)createtime;

+ (void)callAction:(NSString *)phone parentView:(UIView*)view;

+ (BOOL)isNotify;
+ (void)setIsNotify:(BOOL)value;
+ (NSString*)compareDate:(NSDate*)date;
+ (BOOL)isTheSameTodayFromTime:(NSDate*)toDate;
#pragma mark 设置时间格式字符串
+ (NSString*)sendTimeStringZhurenwong:(double)sendTime;

+ (NSString*)sendTimeStringZhurenwongHaveYear:(double)sendTime;
//+ (NSMutableDictionary*)setObject:(NSString*)str forKey:(NSString*)key;
@end
