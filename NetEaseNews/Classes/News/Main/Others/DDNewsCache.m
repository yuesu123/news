//
//  DDNewsCache.m
//  DDNews
//
//  Created by Dvel on 16/4/16.
//  Copyright © 2016年 Dvel. All rights reserved.
//

#import "DDNewsCache.h"

@implementation DDNewsCache


+ (instancetype)sharedInstance
{
	static id _instance;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [NSMutableArray array];
	});
	return _instance;
}

- (NSString *)getPath
{
    //获得文件夹的路径
    /*
     NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
     NSString *newPath = [filePath stringByAppendingPathComponent:@"archive"];
     return newPath;
     */
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *newPath = [path stringByAppendingPathComponent:@"archiver"];
    return newPath;
}




@end
