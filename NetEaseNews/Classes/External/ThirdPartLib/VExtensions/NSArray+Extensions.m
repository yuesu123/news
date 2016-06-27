//
//  NSArray+Extensions.m
//  Vote
//
//  Created by yuan on 13-11-19.
//  Copyright (c) 2013年 yuan.he. All rights reserved.
//

#import "NSArray+Extensions.h"

@implementation NSArray (NSArray_Extensions)

+ (BOOL)writetargetStr:(NSString*)targetStr ToFilePath:(NSString *)path{
    //1.写入之前先读取已经存在过的数组
    NSArray *Arr =  [NSArray readFile:path];
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:Arr];
    if (!strNotNil(targetStr)) return NO;
    
    [mutArr addObject:targetStr];
    NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newPath = [path1 stringByAppendingPathComponent:path];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:mutArr];
    return [data writeToFile:newPath
                  atomically:YES];
}

+(NSArray*)readFile:(NSString*)path{
    NSString *path1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newPath = [path1 stringByAppendingPathComponent:path];
    NSData * data = [NSData dataWithContentsOfFile:newPath];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}





@end

@implementation NSDictionary (NSDictionary_Extensions)
- (BOOL)writeToFile:(NSString *)path{
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [data writeToFile:path
                  atomically:YES];
}

+(NSArray*)readFile:(NSString*)path{
    NSData * data = [NSData dataWithContentsOfFile:path];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end
