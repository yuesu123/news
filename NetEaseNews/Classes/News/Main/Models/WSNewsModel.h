//
//  NSNewsModel.h
//  NetEaseNews
//
//  Created by HLH on 16/5/27.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

//貌似基本没啥用 被Newslist 代替
@interface WSNewsModel : NSObject

@property (nonatomic, assign) NSInteger Infoid;

@property (nonatomic, assign) NSInteger Isshen;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Newslink;

@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, assign) NSInteger Hits;

@property (nonatomic, copy) NSString *Picsmall;

@property (nonatomic, assign) NSInteger Subid;

@property (nonatomic, assign) NSInteger Classid;

@property (nonatomic, copy) NSString *Title;

//@property (nonatomic, assign) NSInteger Id;

//@property (nonatomic, copy) NSString *Newslink;

//@property (nonatomic, copy) NSString *Edittime;

@property (nonatomic, copy) NSString *HomeTitle;

@property (nonatomic, copy) NSString *Descriptions;

//@property (nonatomic, assign) NSInteger Hits;

//@property (nonatomic, copy) NSString *Picsmall;

//@property (nonatomic, assign) NSInteger Subid;

//@property (nonatomic, assign) NSInteger Classid;

//@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy  ) NSString   *type ;

@end
