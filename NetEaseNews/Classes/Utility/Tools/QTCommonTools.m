//
//  QTCommonTools.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-25.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import "QTCommonTools.h"
#import "NSDate+Category.h"
#import "NSString+Hash.h"
#import "NSStringAdditions.h"

#import <AVFoundation/AVCaptureDevice.h>//相机的权限
#import <AVFoundation/AVMediaFormat.h> //相机的权限
#import <AssetsLibrary/AssetsLibrary.h>//相册的权限
#import "Globals.h"


@implementation QTCommonTools

singleton_implementation(QTCommonTools)



+ (NSString*)convertServiceTimeToStandartShowTime:(NSString*)time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // Tue May 31 17:46:55 +0800 2011
    //    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 将字符串(NSString)转成时间对象(NSDate), 方便进行日期处理
    NSDate *createdTime = [fmt dateFromString:time];
    //时间
    NSTimeInterval timeStamp= [createdTime timeIntervalSince1970];
    timeStamp = timeStamp*1000;
    NSString *newTime ;
//    if([createdTime isToday]||[createdTime isYesterday]||[createdTime isTomorrow]) {
//        newTime = [Globals sendTimeStringZhurenwong:timeStamp ];
//    }else{
//        newTime =  [NSDate formattedTimeFromTimeInterval:timeStamp];;
//    }
    newTime = [Globals sendTimeStringZhurenwong:timeStamp ];
    return newTime;
}



+ (NSString*)convertServiceTimeToStandartShowTimeHaveYear:(NSString*)time{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // Tue May 31 17:46:55 +0800 2011
    //    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 将字符串(NSString)转成时间对象(NSDate), 方便进行日期处理
    NSDate *createdTime = [fmt dateFromString:time];
    //时间
    NSTimeInterval timeStamp= [createdTime timeIntervalSince1970];
    timeStamp = timeStamp*1000;
    NSString *newTime ;
    //    if([createdTime isToday]||[createdTime isYesterday]||[createdTime isTomorrow]) {
    //        newTime = [Globals sendTimeStringZhurenwong:timeStamp ];
    //    }else{
    //        newTime =  [NSDate formattedTimeFromTimeInterval:timeStamp];;
    //    }
    newTime = [Globals sendTimeStringZhurenwongHaveYear:timeStamp ];
    return newTime;
}



+ (NSString*)nsnumberToStr:(NSNumber*)number{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *str = [numberFormatter stringFromNumber:number];
    return str;
}

/**
 *  设置btn属性 不设置传nil
 *
 *  @param btn        要设置的btn

 */
+ (void)setButton:(UIButton*)btn title:(NSString*)title titleColor:(UIColor*)titlecolor titleFont:(UIFont*)font backColor:(UIColor*)backcolor{
    if(titlecolor){
        [btn setTitleColor:titlecolor forState:UIControlStateNormal];
    }
    if(title){
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if(font){
        btn.titleLabel.font = font;
    }
    if(backcolor){
        btn.backgroundColor = backcolor;
    }
}
+ (void)avoidRepeatClick:(id)view float:(CGFloat)floatTime{
    if([view isKindOfClass:[UIButton class]]){
        UIButton*btn = (UIButton*)view;
        btn.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(floatTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            btn.userInteractionEnabled = YES;
        });
    }
}
+ (void)setLabel:(UILabel*)label text:(NSString*)text textColor:(UIColor*)textcolor textFont:(CGFloat)fontSize backColor:(UIColor*)backcolor{
    if(textcolor){
        [label setTextColor:textcolor];
    }
    if(text){
        [label setText:text];
        
    }
    if(fontSize){
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    if(backcolor){
        label.backgroundColor = backcolor;
    }
}
+ (void)clipImageView:(UIImageView*)btn Radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = radius;
    btn.layer.borderWidth = borderWidth;
}


+ (void)clipButton:(UIButton*)btn Radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth{
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = radius;
    btn.layer.borderWidth = borderWidth;
}

+ (void)alignCenter:(UILabel*)lable{
    lable.textAlignment = NSTextAlignmentCenter;
}

/**
 *  剪切所有的控件
 *
 *  @param view        控件对象
 *  @param radius      剪切的半径
 *  @param borderWidth 边框的宽度 无需边框传0 传0 就是边框宽度为0
 *  @param color       边框的颜色 无需颜色传nil 传nil 就是clearColor
 */
+ (void)clipAllView:(id)view Radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor{
    if(!borderWidth ){
        borderWidth = 0;
    }
    if(!borderColor){
        borderColor = [UIColor clearColor];
    }
    if ([view isKindOfClass:[UIImageView class]]){ //UIImageView
        UIImageView *viewNew = (UIImageView*)view;
        viewNew.layer.masksToBounds = YES;
        viewNew.layer.cornerRadius = radius;
        viewNew.layer.borderWidth = borderWidth;
        viewNew.layer.borderColor = borderColor.CGColor;
    }else if([view isKindOfClass:[UILabel class]]){//UILabel
        UILabel *viewNew = (UILabel*)view;
        viewNew.layer.masksToBounds = YES;
        viewNew.layer.cornerRadius = radius;
        viewNew.layer.borderWidth = borderWidth;
        viewNew.layer.borderColor = borderColor.CGColor;
    }else if([view isKindOfClass:[UIButton class]]){//UIButton
        UIButton *viewNew = (UIButton*)view;
        viewNew.layer.masksToBounds = YES;
        viewNew.layer.cornerRadius = radius;
        viewNew.layer.borderWidth = borderWidth;
        viewNew.layer.borderColor = borderColor.CGColor;
    }else if([view isKindOfClass:[UIView class]]){//UIView
        UIView *viewNew = (UIView*)view;
        viewNew.layer.masksToBounds = YES;
        viewNew.layer.cornerRadius = radius;
        viewNew.layer.borderWidth = borderWidth;
        viewNew.layer.borderColor = borderColor.CGColor;
    }else if([view isKindOfClass:[UITextView class]]){//UITextView
        UIView *viewNew = (UIView*)view;
        viewNew.layer.masksToBounds = YES;
        viewNew.layer.cornerRadius = radius;
        viewNew.layer.borderWidth = borderWidth;
        viewNew.layer.borderColor = borderColor.CGColor;
    }
}


#define  MD5_Check_Code53bk  @"53bk#hao#kfdk0526"//

// 关于密码安全
- (NSString *)salt:(NSString *)str
{
    //#define MD5_Check_Code @"pinyou0123456789" 以前密钥不用
    //#define MD5_Check_Code @"pinyou%x9U![^2,K"
    NSString *saltStr = [NSString stringWithFormat:@"%@%@",str,MD5_Check_Code53bk];
    return [[saltStr md5String]  base64EncodedString];
}
//字典转json

- (NSString*)convertTojson:(NSDictionary*)dic{
    //字典转json
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}


//// 关于密码安全
//- (NSString *)saltForHuanxingUid:(NSString *)str
//{
//    //#define MD5_Check_Code @"pinyou0123456789" 以前密钥不用
//    //#define MD5_Check_Code @"pinyou%x9U![^2,K"
//    NSString *saltStr = [NSString stringWithFormat:@"%@",str];
//    //修改这里:去掉base64EncodedString
//    //    return [[[saltStr md5String]  base64EncodedString] lowercaseString];
//    return [[saltStr md5String]   lowercaseString];
//    
//}



//
// 关于密码安全
//- (NSString *)saltOfStr:(NSString *)str saltStr:(NSString*)saltStr
//{
//    NSString*  strMD51 = [self saltForHuanxingUid:str];
//    NSString *saltStrNew = [NSString stringWithFormat:@"%@%@",saltStr,strMD51];
//    
//    return [[saltStrNew md5String]  lowercaseString] ;//lowercaseString];
//    
//}

-(void)showAlert:(NSString*)msg
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/**
 *  NSNumber转NSString
 */
+ (NSString*)convertNSnumberToString:(NSNumber*)num{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString* str = [numberFormatter stringFromNumber:num];
    return str;
}
//计算文字的大小
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    //    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //计算文本的大小
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return nameSize;
}


-(void)showAlertIKnow:(NSString*)msg
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)showAlert:(NSString*)msg andDelegate:(id<UIAlertViewDelegate>)  delegate
{
    if (!delegate ) {
        return;
    }
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}
- (NSString *)getNewUrlChangeServerWithStr:(NSString *)str withURL:(NSString*)url{
    return [NSString stringWithFormat:@"%@%@",url,str];
}
- (void)addTextfeildLeftView:(UITextField*)textF image:(UIImage*)image {
    int marg = 25;
    UIView *leftView = [[UIView alloc] init];
    leftView.frame = CGRectMake(0, 0, marg+10+7, marg+3);
    UIImageView *lefyimage = [[UIImageView alloc] init];
    lefyimage.image = image;//[UIImage imageNamed:@"smallImage_username"];
    if(Main_Screen_Width>=540){
        lefyimage.frame = CGRectMake(10+2, 0, marg, marg);
    }else{
        lefyimage.frame = CGRectMake(10, 0, marg, marg);
    }
    [leftView addSubview:lefyimage];
    textF.leftView = leftView;
}

+ (NSString*)replaceStringWithOldLongStr:(NSString*)Longstr oldSmallstr:(NSString*)oldSmallstr withNew:(NSString*)newSmallStr{
    NSString *strUrl = [Longstr stringByReplacingOccurrencesOfString:oldSmallstr withString:newSmallStr];
    ;
    return strUrl;
}

+ (void)addAnimate:(id)view duration:(CGFloat)time type:(AnimateType)type hide:(BOOL)hide{
    CATransition *animation = [CATransition animation];
    switch (AnimateTypefade) {
        case AnimateTypefade:
            animation.type = kCATransitionFade;
            break;
        case AnimateTypepush:
            animation.type = kCATransitionPush;
            break;
        case AnimateTypemoveIn:
            animation.type = kCATransitionMoveIn;
            break;
        case AnimateTypereveal:
            animation.type = kCATransitionReveal;
            break;
        case AnimateTypeFromTop:
            animation.type = kCATransitionFromTop;
            break;
        case AnimateTypeFromLeft:
            animation.type = kCATransitionFromLeft;
            break;
        case AnimateTypeFromRight:
            animation.type = kCATransitionFromRight;
            break;
        case AnimateTypeFromBottom:
            animation.type = kCATransitionFromBottom;
            break;
    }
    animation.type = kCATransitionFade;
    animation.duration = time;
    if ([view isKindOfClass:[UIImageView class]]){ //UIImageView
        UIImageView *viewNew = (UIImageView*)view;
        [viewNew.layer addAnimation:animation forKey:nil];
        viewNew.hidden = hide;

    }else if([view isKindOfClass:[UILabel class]]){//UILabel
        UILabel *viewNew = (UILabel*)view;
        [viewNew.layer addAnimation:animation forKey:nil];
        viewNew.hidden = hide;
    }else if([view isKindOfClass:[UIButton class]]){//UIButton
        UIButton *viewNew = (UIButton*)view;
        [viewNew.layer addAnimation:animation forKey:nil];
        viewNew.hidden = hide;
    }else if([view isKindOfClass:[UIView class]]){//UIView
        UIView *viewNew = (UIView*)view;
        [viewNew.layer addAnimation:animation forKey:nil];
        viewNew.hidden = hide;
    }

}

+ (void)canArrIndex:(NSInteger)totalCount index:(NSInteger)index{
    if (totalCount<=index) {
        return;
    }
}

+(NSString*)phoneNumAddStar:(NSString*)str{
    str = [QTCommonTools replaceStringWithOldLongStr:str oldSmallstr:@" " withNew:@""];
    if ([Globals isValidPhone:str]) {
        NSString *tel = [str stringByReplacingCharactersInRange:NSMakeRange(3, 6) withString:@"******"];
        return tel;
    }
    return str;
}

+ (void)camaraCanuse:(QTCamaraCanuse)camaraCanUse camaraNotCanuse:(QTCamaraNotCanuse)camaraNotCanUse showAlert:(BOOL)showAlert showMsg:(NSString*)showMsg{
    BOOL canUse = [self camaraHadAuthorizationAndShowAlert:showAlert showMsg:showMsg];
    if (canUse) {
        camaraCanUse(canUse);
    }else{
        camaraNotCanUse(canUse);
    }
        
}
+(void)photoCanuse:(QTPhotoCanuse)photoCanUse photoNotCanuse:(QTPhotoNotCanuse)photoNotCanUse showAlert:(BOOL)showAlert showMsg:(NSString*)showMsg {
    BOOL canUse = [self checkPhotoAuthorizationAndShowAlert:showAlert showMsg:showMsg];
    if (canUse) {
        photoCanUse(canUse);
    }else{
        photoNotCanUse(canUse);
    }
}



+ (BOOL)camaraHadAuthorizationAndShowAlert:(BOOL)show showMsg:(NSString*)showMsg{
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    NSLog(@"---授权状态:--------%ld",(long)authStatus);
    // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
    if(authStatus ==AVAuthorizationStatusRestricted){
        NSLog(@"Restricted,授权限制");
        return NO;

    }else if(authStatus == AVAuthorizationStatusDenied){
        // The user has explicitly denied permission for media capture.
        NSLog(@"Denied,授权拒绝");     //应该是这个，如果不允许的话
       NSString *showStr = @"请在设备的\"设置-隐私-相机\"中允许访问相机。";
        if (strNotNil(showMsg)) {
            showStr = showMsg;
        }
        if (show) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:showStr
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
             [alert show];
        }
       
        return NO;
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        NSLog(@"Authorized,授权啦");
        return YES;
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){//点击允许访问时调用
                //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                NSLog(@"Granted access to %@", mediaType);
            }
            else {
                NSLog(@"Not granted access to %@", mediaType);
            }
        }];
        return NO;
    }else {
        return YES;
//        NSLog(@"未知的授权状态!");
    }
}



+ (BOOL)checkPhotoAuthorizationAndShowAlert:(BOOL)show showMsg:(NSString*)showMsg{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied)
    {
        if (show) {
            NSString *showStr = @"请在设备的\"设置-隐私-照片\"中允许访问相机。";
            if (strNotNil(showMsg)) {
                showStr = showMsg;
            }
            //无权限
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:showStr
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];

        }
               NSLog(@"相册没授权");
        return NO;
    }else{
        return YES;
        NSLog(@"相册授权了");
    }
}

+ (BOOL)hasMoreData:(NSInteger)currentPage totalNews:(NSInteger)totalNews pageSize:(NSInteger)pageSize{
    NSInteger curr = pageSize*currentPage;
    if (totalNews>curr) {
        return YES;
    }else{
        return NO;
    }
}

@end
