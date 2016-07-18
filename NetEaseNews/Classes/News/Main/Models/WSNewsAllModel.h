//
//  WSNewsAllModel.h
//  NetEaseNews
//
//  Created by HLH on 16/5/27.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "WSGetDataTool.h"
#import "WSAdModel.h"

@class Newsclass,Blocknews,Newslist,Tjnews;
@interface WSNewsAllModel : NSObject

@property (nonatomic, assign) NSInteger Total;

@property (nonatomic, strong) NSArray<Blocknews *> *Blocknews;
@property (nonatomic, strong) NSArray<Tjnews *> *Tjnews;


@property (nonatomic, strong) NSMutableArray<Newslist *> *Newslist;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, assign) NSInteger Lines;

@property (nonatomic, assign) NSInteger Curpage;

@property (nonatomic, strong) Newsclass *Newsclass;
@property (nonatomic, strong)NSArray<WSAdModel *> *Newsad;


@property (nonatomic, assign) NSInteger Pagesize;


@end
@interface Newsclass : NSObject

@property (nonatomic, assign) NSInteger Sortid;

@property (nonatomic, copy) NSString *Classen;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Parentpath;

@property (nonatomic, assign) NSInteger Depth;

@property (nonatomic, copy) NSString *Mobanen;

@property (nonatomic, assign) NSInteger Parentid;
@property (nonatomic, assign) NSInteger Infoid;
@property (nonatomic, copy) NSString *Classname;

@property (nonatomic, copy) NSString *Referurl;

@property (nonatomic, copy) NSString *Classdes;

@end

@interface Blocknews : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger Showtype;
@property (nonatomic, copy) NSString *Newslink;

@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, copy) NSString *HomeTitle;

@property (nonatomic, copy) NSString *Descriptions;

@property (nonatomic, assign) NSInteger Hits;

@property (nonatomic, copy) NSString *Picsmall;
@property (nonatomic, copy) NSString *Picsmall2;
@property (nonatomic, copy) NSString *Picsmall3;

@property (nonatomic, assign) NSInteger Subid;

@property (nonatomic, assign) NSInteger Classid;

@property (nonatomic, copy) NSString *Title;

@end



@interface Tjnews : NSObject

@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger Showtype;
@property (nonatomic, copy) NSString *Newslink;

@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, copy) NSString *HomeTitle;

@property (nonatomic, copy) NSString *Descriptions;

@property (nonatomic, assign) NSInteger Hits;

@property (nonatomic, copy) NSString *Picsmall;
@property (nonatomic, copy) NSString *Picsmall2;
@property (nonatomic, copy) NSString *Picsmall3;

@property (nonatomic, assign) NSInteger Subid;

@property (nonatomic, assign) NSInteger Classid;

@property (nonatomic, copy) NSString *Title;

@end


//每一个新闻的news 模型 == WSNews
@interface Newslist : NSObject
+ (NSArray *)cacheFileArrWithChannelID:(NSString *)channelID;
+ (void)newsListDataWithNewsID:(NSString *)newsID newsCache:(BOOL)isCache getDataSuccess:(GetDataSuccessBlock)success getFailure:(GetDataFailureBlock)failure;

/**广告数组*/
@property (strong, nonatomic) NSArray *ads;

@property (nonatomic, assign) NSInteger Infoid;
@property (nonatomic, assign) NSInteger Showtype;
@property (nonatomic, assign) NSInteger Isshen;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Newslink;

@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, assign) NSInteger Hits;

@property (nonatomic, copy) NSString *Picsmall;
@property (nonatomic, copy  ) NSString   *Picsmall2;
@property (nonatomic, copy  ) NSString   *Picsmall3;
@property (nonatomic, assign) NSInteger Goods;

@property (nonatomic, assign) NSInteger Subid;

@property (nonatomic, assign) NSInteger Classid;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *HomeTitle;

@property (nonatomic, copy) NSString *Descriptions;

@property (nonatomic, copy  ) NSString   *Type;
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, copy) NSString *tag;


@end

