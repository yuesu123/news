//
//  WSAdModel.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/6/18.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface WSAdModel : NSObject

@property (nonatomic, assign) NSInteger Typeid;

@property (nonatomic, copy) NSString *Addes;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Adtitle;

@property (nonatomic, copy) NSString *Adfile;

@property (nonatomic, copy) NSString *Adlink;

@property (nonatomic, copy) NSString *Classen;

@property (nonatomic, assign) NSInteger Adwidth;

@property (nonatomic, copy) NSString *Addtime;

@property (nonatomic, copy) NSString *Classname;

@property (nonatomic, assign) NSInteger Adheight;

+ (void)inserAdArr:(NSArray*)adArr toArr:(NSMutableArray*)allArr path:(NSInteger)path;

@end
