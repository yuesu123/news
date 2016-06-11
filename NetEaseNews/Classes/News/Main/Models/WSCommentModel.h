//
//  WSCommentModel.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/6/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class Mvc_Pingitems;
@interface WSCommentModel : NSObject

@property (nonatomic, assign) NSInteger Newsid;

@property (nonatomic, assign) NSInteger Infoid;

@property (nonatomic, assign) NSInteger IsShare;

@property (nonatomic, strong) NSArray<Mvc_Pingitems *> *Mvc_pingItems;

@property (nonatomic, assign) NSInteger Iszt;

@property (nonatomic, assign) NSInteger Goods;

@property (nonatomic, assign) NSInteger Mvc_pingTotal;




@end
@interface Mvc_Pingitems : NSObject

@property (nonatomic, copy) NSString *Plsign;

@property (nonatomic, assign) NSInteger Userid;

@property (nonatomic, assign) BOOL Iszt;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Plip;

@property (nonatomic, copy) NSString *Plfrom;

@property (nonatomic, copy) NSString *Addtime;

@property (nonatomic, copy) NSString *Pltitle;


@property (nonatomic, copy) NSString *Pldetail;

@property (nonatomic, copy) NSString *Newstitle;

@property (nonatomic, assign) NSInteger Newsid;

@property (nonatomic, assign) BOOL Istj;

@end

