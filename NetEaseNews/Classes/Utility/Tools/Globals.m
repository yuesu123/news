//
//  Globals.m
//  CarPool
//
//  Created by kiwi on 14-6-23..
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//

#import "Globals.h"

@implementation Globals

- (NSMutableDictionary*)setObjectInDict:(NSMutableDictionary*)dic object:(NSString*)str forKey:(NSString*)key{
    if (strNotNil(str)) {
        [dic setObject:str forKey:key];
    }
    return dic;
}


+ (BOOL) isValidPhone:(NSString*)value {
    
    if(!strNotNil(value)){//为空直接返回 防止崩溃
        return NO;
    }
    
    const char *cvalue = [value UTF8String];

    int len = strlen(cvalue);
    if (len != 11) {
        return FALSE;
    }
    
    NSString *preString = [[NSString stringWithFormat:@"%@",value] substringToIndex:2];
    if ([preString isEqualToString:@"13"] ||
        [preString isEqualToString: @"14"] ||
        [preString isEqualToString: @"15"]||
        [preString isEqualToString: @"16"]||
        [preString isEqualToString: @"17"]||
        [preString isEqualToString: @"18"]||
        [preString isEqualToString: @"19"]
        )
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
+ (UIColor*)getColorViewBkg {
    return bkgColor;
}

+ (UIColor*)getColorGrayLine {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"bkg_gray_line"]];
}

+ (UIImage*)getImageInputViewBkg {
    return [[UIImage imageNamed:bkgNameOfInputView] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
}

+ (UIImage*)getImageRoomHeadDefault {
    return [UIImage imageNamed:@"roomHeadImage"];
}

+ (UIImage*)getImageUserHeadDefault {
    return [UIImage imageNamed:@"defaultHeadImage"];
}

+ (UIImage*)getImageDefault {
    return [UIImage imageNamed:@"Icon"];
}

+ (UIImage*)getImageGray {
    return [[UIImage imageNamed:@"bkg_gray_line"] stretchableImageWithLeftCapWidth:2 topCapHeight:2];
}



+ (NSString*)showCouponNameWithName:(NSString*)name extent:(float)extent unit:(NSString*)unit type:(int)type{
    NSString *str = nil;
    if(type == 1){
        str = [NSString stringWithFormat:@"%@ 优先报名权",name];
    }else{
       str = [NSString stringWithFormat:@"%@  面值:%0.1f%@",name,extent,unit];
    }
        return str;
}


+ (NSString*)showCouponNameWith_Noprice:(NSString*)name extent:(float)extent unit:(NSString*)unit type:(int)type{
    NSString *str = nil;
    if(type == 1){
        str = [NSString stringWithFormat:@"%@",name];
    }else{
        str = [NSString stringWithFormat:@"%@",name];
    }
    return str;
}

+ (CGSize)calculateLableWidth:(float)contentLabelMaxH  content:(NSString*)str  font:(UIFont*)font{
    CGSize contentLabelMaxSize = CGSizeMake(MAXFLOAT, contentLabelMaxH);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:contentLabelMaxSize];
    return labelSize;
}


+ (CGSize)calculateLableSizeWithMaxWidth:(float)contentLabelMaxW  content:(NSString*)str  font:(UIFont*)font{
    CGSize contentLabelMaxSize = CGSizeMake(contentLabelMaxW, MAXFLOAT);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:contentLabelMaxSize];
    return labelSize;
}

+ (UIImage *)getImageWithColor:(UIColor*)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSString*)timeStringWith:(NSTimeInterval)timestamp {
    NSString *_timestamp;
    // Calculate distance time string
    //
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, timestamp);
    if (distance < 0) distance = 0;
    
    if (distance < 10) {
        _timestamp = [NSString stringWithFormat:@"刚刚"];
    } else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
    } else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"小时前"];
    } else if (distance < 60 * 60 * 24 * 4) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    } else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd hh:mm"];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString *)convertDateFromString:(NSString*)uiDate timeType:(int)timeType
{
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:uiDate.doubleValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (timeType == 0) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    } else if (timeType == 1){
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    } else if (timeType == 2){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    } else if (timeType == 3){
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    } else if (timeType == 4){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString *strDate = [dateFormatter stringFromDate:data];
    return strDate;
}


+ (void)initializeGlobals {
    NSFileManager * fMan = [NSFileManager defaultManager];
    NSString * new_path_b = [NSString stringWithFormat:@"%@/Library/Cache",NSHomeDirectory()];
    NSString * new_path = [NSString stringWithFormat:@"%@/Library/Cache/Images",NSHomeDirectory()];
    NSString * new_path_a = [NSString stringWithFormat:@"%@/Library/Cache/Audios",NSHomeDirectory()];
    if ((![fMan fileExistsAtPath:new_path_b]) || (![fMan fileExistsAtPath:new_path])) {
        [fMan createDirectoryAtPath:new_path_b withIntermediateDirectories:YES attributes:nil error:nil];
        [fMan createDirectoryAtPath:new_path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![fMan fileExistsAtPath:new_path_a]) {
        [fMan createDirectoryAtPath:new_path_a withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (NSString*)getBaiduAdrPic:(CGFloat)lat lng:(CGFloat)lng {
    return [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?center=%f,%f&width=300&height=200&zoom=11", lng, lat];
}

+ (NSString*)getBaiduAdrPicForTalk:(CGFloat)lat lng:(CGFloat)lng {
    return [NSString stringWithFormat:@"http://api.map.baidu.com/staticimage?center=%f,%f&width=200&height=120&zoom=12&markers=%f,%f&markerStyles=s", lng, lat, lng, lat];
}

+(UIButton*)clipButton:(float)cor btn:(UIButton*)btn{
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = cor;
    return btn;
}
+(UIView*)clipView:(float)cor view:(UIView*)view{
    view.clipsToBounds = YES;
    view.layer.cornerRadius = cor;
    return view;
}

+ (UILabel*)createLable:(CGRect)rect
                   font:(float)font
               boldFont:(BOOL)boldFont
             numoflines:(int)numsofline
          adjustYesOrNo:(BOOL)adjustYesOrNo
                content:(NSString*)str
                  color:(UIColor*)color
{
    UILabel *lable = [[UILabel alloc] initWithFrame:rect];
    if (boldFont) {
        lable.font = [UIFont boldSystemFontOfSize:font];
    }else{
        lable.font = [UIFont systemFontOfSize:font];
    }
    lable.numberOfLines = numsofline;
    lable.adjustsFontSizeToFitWidth = adjustYesOrNo;
    lable.text = str;
    lable.textColor = color;
    return lable;
}




#pragma mark 移除Folder中的路劲为path的文件
+ (void)removeAllItemsInFolder:(NSString*)path {
    NSFileManager * fm = [NSFileManager defaultManager];
    NSArray * tmps = [fm subpathsAtPath:path];
    for (NSString * fileName in tmps) {
        NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        [fm removeItemAtPath:fileAbsolutePath error:nil];
    }
}

+ (NSTimeInterval)fileCreateDate:(NSString*)filePath {
    NSFileManager * fm = [NSFileManager defaultManager];
    NSDate * fileModDate = nil;
    NSDictionary * fileAttributes = [fm attributesOfItemAtPath:filePath error:nil];
    if ((fileModDate = [fileAttributes objectForKey:NSFileModificationDate])) {
        return [fileModDate timeIntervalSinceNow];
    }
    return 0;
}

+ (NSString*)timeString {
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
}


#pragma mark 设置时间格式字符串
+ (NSString*)sendTimeStringZhurenwong:(double)sendTime {
    NSString * _timestamp;
    NSTimeInterval timestamp = sendTime/ 1000;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, timestamp);
    if (distance < 0) distance = 0;
    /*
    if (distance < 10) {
        _timestamp = [NSString stringWithFormat:@"刚刚"];
    } else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒前"];
    } else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
    } else
        */
    if (distance < 60 * 60 * 1) {//24小时

        distance = distance / (60*60);
        _timestamp = [NSString stringWithFormat:@"%d%@", 1, @"小时前"];
    }else if (distance < 60 * 60 * 24 * 30*6) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M月d日 hh:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    } else {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-M-d hh:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}


+ (NSString*)sendTimeStringZhurenwongHaveYear:(double)sendTime {
    NSString * _timestamp;
    NSTimeInterval timestamp = sendTime/ 1000;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, timestamp);
    if (distance < 0) distance = 0;
    /*
     if (distance < 10) {
     _timestamp = [NSString stringWithFormat:@"刚刚"];
     } else if (distance < 60) {
     _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒前"];
     } else if (distance < 60 * 60) {
     distance = distance / 60;
     _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
     } else
     */
//    if (distance < 60 * 60 * 1) {//24小时
//        
//        distance = distance / (60*60);
//        _timestamp = [NSString stringWithFormat:@"%d%@", 1, @"小时前"];
//    }else if (distance < 60 * 60 * 24 * 30*6) {
//        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"M月d日 hh:mm"];
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
//        _timestamp = [dateFormatter stringFromDate:date];
//    } else {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年M月d日 hh:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
//    }
    
    return _timestamp;
}



#pragma mark 设置时间格式字符串
+ (NSString*)sendTimeString:(double)sendTime {
    NSString * _timestamp;
    NSTimeInterval timestamp = sendTime/ 1000;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, timestamp);
    if (distance < 0) distance = 0;
    
    if (distance < 10) {
        _timestamp = [NSString stringWithFormat:@"刚刚"];
    } else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒前"];
    } else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
    } else if (distance < 60 * 60 * 24) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M月d日 hh:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    } else if (distance < 60 * 60 * 24 * 30) {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"M月d日 hh:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    } else {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-M-d hh:mm"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    
    return _timestamp;
}

#pragma mark 是否是有效的邮箱地址
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


#pragma mark 获得UUID
+ (NSString *)generateUUID
{
	NSString *result = nil;
	
	CFUUIDRef uuid = CFUUIDCreate(NULL);
	if (uuid)
	{
		result = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
		CFRelease(uuid);
	}
	
	return result;
}

//- (NSString *)compareDate:(NSDate *)date{
//    NSTimeInterval secondsPerDay = 24 * 60 * 60;
//    NSDate *today = [[NSDate alloc] init];
//    NSDate *tomorrow, *yesterday;
//    
//    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
//    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
//    
//    // 10 first characters of description is the calendar date:
//    NSString * todayString = [[today description] substringToIndex:10];
//    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
//    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
//    
//    NSString * dateString = [[date description] substringToIndex:10];
//    
//    if ([dateString isEqualToString:todayString])
//    {
//        return @"今天";
//    } else if ([dateString isEqualToString:yesterdayString])
//    {
//        return @"昨天";
//    }else if ([dateString isEqualToString:tomorrowString])
//    {
//        return @"明天";
//    }
//    else
//    {
//        return dateString;
//    }
//}

+ (NSString*)compareDate:(NSDate*)date{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([dateString isEqualToString:tomorrowString])
    {
        return @"明天";
    }
    else
    {
        return dateString;
    }
}


#pragma mark 创建时间


+ (BOOL)isTheSameTodayFromTime:(NSDate*)toDate{
    if (!toDate) {
        return NO;
    }
//    NSDate * toDate = [NSDate dateWithTimeIntervalSince1970:createtime];
    NSString *str1 = [Globals compareDate:toDate];
     DLog(@"存储时间toDate--%@",toDate);
    if ([str1 isEqualToString:@"明天"]){
        return NO;
    }else if([str1 isEqualToString:@"今天"]){
        return YES;
    }else{
        return NO;
    }

}

+ (NSString*)getDate:(NSTimeInterval)createtime {
       /* NSString *str = nil;
    NSDate * toDate = [NSDate dateWithTimeIntervalSince1970:createtime];
    NSDate * startDate  = [NSDate date];
    NSCalendar * chineseClendar = [[NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger unitFlags =  NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:startDate  toDate:toDate  options:0];
    NSInteger diffDay = [cps day];
    DLog(@"toDate--%@",toDate);

    if (diffDay == 0) {
        // 今天
        str = [NSString stringWithFormat:@"今天:%@",[self getTime:createtime]];
    } else if (diffDay == -1) {
        // 昨天
       str = [NSString stringWithFormat:@"昨天:%@",[self getTime:createtime]];
     str = [Globals convertDateFromString:[NSString stringWithFormat:@"%f", createtime] timeType:3];
    } else if (diffDay == 1) {
        // 明天
        str = [NSString stringWithFormat:@"明天:%@",[self getTime:createtime]];
    } else {
        str = [Globals convertDateFromString:[NSString stringWithFormat:@"%f", createtime] timeType:3];
    }
     */
    NSDate * toDate = [NSDate dateWithTimeIntervalSince1970:createtime];
    NSString *str1 = [Globals compareDate:toDate];
    if ([str1 isEqualToString:@"明天"]){
        str1 =[NSString stringWithFormat:@"明天%@",[self getTime:createtime]];
    }else if([str1 isEqualToString:@"今天"]){
        str1 =[NSString stringWithFormat:@"今天%@",[self getTime:createtime]];
    }
    else{
        
        //当前日期
        NSDate *date = [NSDate date];
        //穿过来得日期
        NSDate *dateB = [NSDate dateWithTimeIntervalSince1970:createtime];
        
        NSString *dateStr =  [[date description] substringToIndex:4];
        NSString *dateBStr =  [[dateB description] substringToIndex:4];

        
        if (dateBStr.intValue == (dateStr.intValue)) {//今年
            str1 = [Globals convertDateFromString:[NSString stringWithFormat:@"%f", createtime] timeType:3];
        }else if( dateBStr.intValue == (dateStr.intValue +1)){//明年
            str1 = [Globals convertDateFromString:[NSString stringWithFormat:@"%f", createtime] timeType:4];
        }else{ //去年或者后年以后
            str1 = [Globals convertDateFromString:[NSString stringWithFormat:@"%f", createtime] timeType:4];
        }

    }
    return str1;
}


+ (UIButton*)CreatCellLable:(UITableViewCell*)cell
               content:(NSString*)str
                CGrectOut:(CGRect)rectOut
                CGrectIn:(CGRect)rectIn
         textAlignment:(NSTextAlignment)textAlignment
                  font:(int)font
                isBold:(BOOL)isBold
                  nums:(int)nums
              isAdjust:(BOOL)isAdjust
                color:(UIColor*)color
{
    UILabel *cusBtnLable = [[UILabel alloc]  initWithFrame:rectIn];  //CGRectMake(0, 0,17, 17)];str;//
    cusBtnLable.text = [Globals one_to_two_oldStr:str numToClip:16];
    cusBtnLable.adjustsFontSizeToFitWidth = isAdjust;
    cusBtnLable.numberOfLines = nums;
    cusBtnLable.textAlignment = textAlignment;

    if (isBold) {
        cusBtnLable.font = [UIFont boldSystemFontOfSize:font];
    }else{
        cusBtnLable.font = [UIFont systemFontOfSize:font];
    }
    cusBtnLable.textColor = color;
    cusBtnLable.userInteractionEnabled = NO;
    UIButton *cusBtn = [[UIButton alloc]  initWithFrame: rectOut]; //CGRectMake(cell.width - 20*mark, 4,17, 17)];
    [cusBtn addSubview:cusBtnLable];
    [cusBtn setBackgroundColor:[UIColor whiteColor]];
    cusBtn.titleLabel.userInteractionEnabled = NO;
    cusBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    cusBtn.titleLabel.textAlignment = textAlignment;
    cusBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    cusBtn.adjustsImageWhenHighlighted = NO;
    cusBtn.adjustsImageWhenDisabled = NO;
    cusBtn.userInteractionEnabled = NO;
    [cusBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    return cusBtn;
}

+ (NSString*)one_to_two_oldStr:(NSString*)str numToClip:(int)num{
    if (str.length<=num) {
        return str;
    }
    int cut = (int)(str.length*0.5);
    if (cut<12) {
        cut = 12;
    }
    NSString *a = [str substringToIndex:cut]; //到cut 不包含cut
    NSString  *b = [str  substringFromIndex:cut]; //cut 开始 包含cut
    NSString *newStr = [NSString stringWithFormat:@"%@\n%@",a,b];
    return newStr;
}

+ (NSString *)getTime:(NSTimeInterval)createtime {
    NSDate *data = [NSDate dateWithTimeIntervalSince1970:createtime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:data];
    if ([strDate isEqualToString:@"00:00"]) {
        return @"24:00";
    }
    return strDate;
}

+ (void)callAction:(NSString *)phone parentView:(UIView*)view {
    NSString * num = [NSString stringWithFormat:@"tel:%@", phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:num];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [view addSubview:callWebview];
}


#pragma mark 是否是通知
+ (BOOL)isNotify {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return ![defaults boolForKey:kBaseIfCloseAPNS];
}

#pragma mark 设置通知值
+ (void)setIsNotify:(BOOL)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:!value forKey:kBaseIfCloseAPNS];
    [defaults synchronize];
}
@end
