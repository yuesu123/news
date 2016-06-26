//
//  NSArray+Extensions.h
//  Vote
//
//  Created by yuan on 13-11-19.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//  将数组或字典存到本地，以data的形式,这个可以解决出现null无法保存的情况

#import <Foundation/Foundation.h>

@interface NSArray(NSArray_Extensions)
//将 targetStr存储到path下面(路径的一个唯一标示即可,可以1,2,3,...)底层会将path 拼接为真正的沙盒路径
+ (BOOL)writetargetStr:(NSString*)targetStr ToFilePath:(NSString *)path ;
//读取到path下面(路径的一个唯一标示即可,可以1,2,3,...)的一个数组,底层会将path 拼接为真正的沙盒路径
+(NSArray*)readFile:(NSString*)path;
@end

@interface NSDictionary(NSDictionary_Extensions)
- (BOOL)writeToFile:(NSString *)path;
+(NSDictionary*)readFile:(NSString*)path;
@end
