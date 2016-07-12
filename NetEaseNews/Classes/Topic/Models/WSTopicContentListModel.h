//
//  WSTOpicAllModel.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/28.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "WSGetDataTool.h"
#import "WSNewsAllModel.h"

@class ZtNewslist,Blocknews;
@interface WSTopicContentListModel : NSObject

@property (nonatomic, assign) NSInteger Total;

@property (nonatomic, assign) NSInteger Curpage;

@property (nonatomic, assign) NSInteger Pagesize;
@property (nonatomic, strong) NSArray<ZtNewslist *> *ZtNewslist;

@property (nonatomic, strong) NSArray<Blocknews *> *Blocknews;

@end

@interface ZtNewslist : NSObject;
@property (nonatomic, assign) NSInteger Ztid;

@property (nonatomic, assign) NSInteger Ztclassid;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger Infoid;

@property (nonatomic, copy) NSString *Newslink;

@property (nonatomic, copy) NSString *HomeTitle;

@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, assign) NSInteger Hits;

@property (nonatomic, copy) NSString *Picsmall;

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Ztdes;

/** <#name#> */
@property (nonatomic, assign) NSInteger Showtype;


+ (void)topicWithIndex:(NSInteger)index isCache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success getDataFaileure:(GetDataFailureBlock)failure;
+ (NSArray *)cacheTopic;
@end




