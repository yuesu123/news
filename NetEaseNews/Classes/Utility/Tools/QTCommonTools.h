//
//  QTCommonTools.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-25.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import"Singleton.h"



typedef enum : NSUInteger {
    AnimateTypefade,
    AnimateTypemoveIn,
    AnimateTypereveal,
    AnimateTypepush,
    AnimateTypeFromRight,
    AnimateTypeFromLeft,
    AnimateTypeFromTop,
    AnimateTypeFromBottom
} AnimateType;

typedef void (^QTPhotoCanuse)(BOOL canUse);
typedef void (^QTPhotoNotCanuse)(BOOL notCanUse);
typedef void (^QTCamaraCanuse)(BOOL canUse);
typedef void (^QTCamaraNotCanuse)(BOOL notCanUse);


@interface QTCommonTools : NSObject
@property (nonatomic, assign) float rowHeight;

singleton_interface(QTCommonTools)
+ (NSString*)nsnumberToStr:(NSNumber*)number;

-(void)showAlert:(NSString*)msg;
-(void)showAlertIKnow:(NSString*)msg;

-(void)showAlert:(NSString*)msg andDelegate:(id<UIAlertViewDelegate>)  delegate
;
- (NSString *)getNewUrlChangeServerWithStr:(NSString *)str withURL:(NSString*)url;
// 关于密码安全
- (NSString *)salt:(NSString *)str;
// 关于密码安全
//- (NSString *)saltForHuanxingUid:(NSString *)str;
//// 关于密码安全
//- (NSString *)saltOfStr:(NSString *)str saltStr:(NSString*)saltStr;

/**
 *  字典转json
 *
 *  @param dic 需要转的字典
 */
- (NSString*)convertTojson:(NSDictionary*)dic;

/**
 *  NSNumber转NSString
 */
+ (NSString*)convertNSnumberToString:(NSNumber*)num;


+(void)clipButton:(UIButton*)btn Radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth __deprecated_msg("Method deprecated. Use `clipImageView:Radius:borderWidth:`");
+ (void)clipImageView:(UIImageView*)btn Radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth __deprecated_msg("Method deprecated. Use `clipImageView:Radius:borderWidth:`");

/**
 *  剪切所有的控件
 *
 *  @param view        控件对象
 *  @param radius      剪切的半径
 *  @param borderWidth 边框的宽度 无需边框传0 传0 就是边框宽度为0
 *  @param color       边框的颜色 无需颜色传nil 传nil 就是clearColor
 */
+ (void)clipAllView:(id)view Radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;
                                                                                                 
                                                                                                 
 /*
 *  设置btn属性 不设置传nil
 *  @param btn        要设置的btn
 */
+ (void)setButton:(UIButton*)btn title:(NSString*)title titleColor:(UIColor*)color titleFont:(UIFont*)font backColor:(UIColor*)color;
+ (void)setLabel:(UILabel*)label text:(NSString*)text textColor:(UIColor*)textcolor textFont:(CGFloat)fontSize backColor:(UIColor*)backcolor;
- (void)addTextfeildLeftView:(UITextField*)textF image:(UIImage*)image;
//计算文字的大小
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize;

//讲主人翁后台服务器的2015-09-12 20:39 时间转化为 3小时前等标准的格式
+ (NSString*)convertServiceTimeToStandartShowTime:(NSString*)time;
+ (NSString*)convertServiceTimeToStandartShowTimeHaveYear:(NSString*)time;

+ (void)alignCenter:(UILabel*)lable;

/**
 *  避免按钮重复点击
 *
 *  @param view      那一个按钮或者VIew
 *  @param floatTime 间隔多长实际那可以点击
 */
+ (void)avoidRepeatClick:(id)view float:(CGFloat)floatTime;

+ (NSString*)replaceStringWithOldLongStr:(NSString*)Longstr oldSmallstr:(NSString*)oldSmallstr withNew:(NSString*)newSmallStr;
/**
 *  为View添加动画
 *
 *  @param view 所添加动画的View
 *  @param time 动画持续的时间
 *  @param type 动画的类型AimateType
 *  @param hide 是出现还是影藏的动画
 */
+ (void)addAnimate:(id)view duration:(CGFloat)time type:(AnimateType)type hide:(BOOL)hide;
/**
 *  防止数组崩溃
 *
 *  @param totalCount 数组的总个数
 *  @param index      index的值
 *  不能index 就返回
 */
+ (void)canArrIndex:(NSInteger)totalCount index:(NSInteger)index;
/**
 *  手机号加星
 *
 *  @param str 传入的字符串
 *
 *  @return 是手机号加星  不是手机号不做任何改变
 */
+(NSString*)phoneNumAddStar:(NSString*)str;

+ (void)camaraCanuse:(QTCamaraCanuse)camaraCanUse camaraNotCanuse:(QTCamaraNotCanuse)camaraNotCanUse showAlert:(BOOL)showAlert showMsg:(NSString*)showMsg;
+(void)photoCanuse:(QTPhotoCanuse)photoCanUse photoNotCanuse:(QTPhotoNotCanuse)photoNotCanUse showAlert:(BOOL)showAlert showMsg:(NSString*)showMsg;

+ (BOOL)hasMoreData:(NSInteger)currentPage totalNews:(NSInteger)totalNews pageSize:(NSInteger)pageSize;
@end
