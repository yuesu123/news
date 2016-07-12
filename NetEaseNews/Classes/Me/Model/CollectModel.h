//
//  CollectModel.h
//  新闻
//
//  Created by gyh on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@class NewsMode,ZtNewsMode;
@interface CollectModel : NSObject


@property (nonatomic, assign) NSInteger Userid;

@property (nonatomic, assign) NSInteger Newsid;
@property (nonatomic, assign) NSInteger ZtNewsid;
@property (nonatomic, strong) NewsMode *NewsMode;
@property (nonatomic, strong) ZtNewsMode *ztNewsMode;

@property (nonatomic, assign) NSInteger Id;

//newsModel 里面到
@property (nonatomic, assign) NSInteger Classid;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger Subid;

@property (nonatomic, assign) NSInteger Hits;








@end
@interface NewsMode : NSObject

@property (nonatomic, assign) NSInteger Classid;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger Subid;

@property (nonatomic, assign) NSInteger Hits;
@property (nonatomic, copy) NSString *Edittime;


@end


@interface ZtNewsMode : NSObject

@property (nonatomic, assign) NSInteger Ztid;
@property (nonatomic, assign) NSInteger Ztclassid;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, assign) NSInteger Hits;
@property (nonatomic, copy) NSString *Edittime;
@end
