//
//  WSAdModel.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/6/18.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSAdModel.h"
#import "WSNewsAllModel.h"
static NSString *kremoveTag = @"yu&&**^^";

@implementation WSAdModel
+ (void)inserAdArr:(NSMutableArray*)adArr toArr:(NSMutableArray*)allArr path:(NSInteger)path{
    for (int i = 0 ; i <allArr.count; i++) {
        Newslist *model = [allArr objectAtIndex:i];
        if ([model isKindOfClass:[Newslist class]]) {
            if ([model.tag isEqualToString:kremoveTag]) {
                [allArr removeObjectAtIndex:i];
            }
        }
      
    }
    //每组插入广告
        for (int i = 0; i < adArr.count; i++) {
            WSAdModel *ad = [adArr objectAtIndex:i];
            if ([self getIndex:i]>=allArr.count) {
                return;
            }
            [allArr insertObject:[self convertAdtoNewlist:ad] atIndex:[self getIndex:i]];
        }
}

+ (NSInteger)getIndex:(NSInteger)i {
    return (i+1)*3+i;
}

+ (Newslist*)convertAdtoNewlist:(WSAdModel*)adModel{
    Newslist *news = [[Newslist alloc] init];
    news.Id = adModel.Id;
    news.Title = adModel.Adtitle;
    news.Descriptions = adModel.Addes;
    news.Picsmall = adModel.Adfile;
    news.Newslink = adModel.Adlink;
    news.Edittime = adModel.Addtime;
    news.Showtype = 1;
    news.tag = kremoveTag;
    news.isAdd = YES;
    return news;
}




@end
