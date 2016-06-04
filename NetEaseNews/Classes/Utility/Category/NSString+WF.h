//
//  NSString+WF.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-21.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(WF)


- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;
+ (NSString *)addHttp:(NSString *)str;
+ (NSString *)convertIntgerToString:(NSInteger)intStr;
+ (NSString *)convertIntToString:(int)intStr;
@end
