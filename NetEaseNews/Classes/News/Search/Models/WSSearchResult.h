//
//  WSSearchResult.h
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "WSGetDataTool.h"
#import "MJExtension.h"
@interface WSSearchResult : NSObject
//{
//    Edittime = "2016-06-09T07:51:36";
//    Goods = 0;
//    Hits = 0;
//    Id = 74;
//    Newsid = 60;
//    Newslink = "news/20160609_60.html";
//    Title = "\U4f01\U4e1a\U7528\U5de5\U6210\U672c\U8c03\U67e5\Uff1a\U652f\U4ed81.6\U4e07\U5458\U5de5\U624d\U5230\U624b7300\U5143";
//    ZtNewsid = 0;
//}


@property (copy, nonatomic) NSString *Edittime;
@property (nonatomic, assign) NSInteger Goods;

@property (nonatomic, assign) NSInteger Hits;
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger Newsid;
@property (nonatomic, assign) NSInteger ZtNewsid;
@property (copy, nonatomic) NSString *Newslink;
@property (copy, nonatomic) NSString *Title;



@end
