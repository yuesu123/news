//
//  WSTopicModel.h
//  NetEaseNews
//
//  Created by HLH on 16/5/28.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "WSGetDataTool.h"
@class Ztlist;
@interface WSTopicModel : NSObject

@property (nonatomic, assign) NSInteger Total;

@property (nonatomic, assign) NSInteger Curpage;

@property (nonatomic, assign) NSInteger Pagesize;

@property (nonatomic, strong) NSArray<Ztlist *> *Ztlist;

@end
@interface Ztlist : NSObject<NSCopying>

@property (nonatomic, copy) NSString *Ztlink;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, copy) NSString *Zttitle;

@property (nonatomic, copy) NSString *Picsmall;

@property (nonatomic, copy) NSString *Ztpinyin;

@property (nonatomic, copy) NSString *Ztdes;
+ (void)topicWithIndex:(NSInteger)currentPage isCache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success getDataFaileure:(GetDataFailureBlock)failure;
+ (NSArray *)cacheTopic;

@end

