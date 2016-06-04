//
//  WSContent.m
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSNews.h"
#import "WSAds.h"
#import "WSNewsAllModel.h"
#import "WSNewsModel.h"

@implementation WSNews

+ (void)newsListDataWithNewsID:(NSString *)newsID newsCache:(BOOL)isCache getDataSuccess:(GetDataSuccessBlock)success getFailure:(GetDataFailureBlock)failure{
    
    
    [WSGetDataTool GETJSON:newsID GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        WSNewsAllModel *allModel = [WSNewsAllModel objectWithKeyValues:responseObject];
        
//        NSDictionary *dict = responseObject;
//        NSEnumerator *keyEnum = dict.keyEnumerator;
        
        
        //缓存的key 使用每个classId 作为key
        /*classId 相当于以前的频道ID*/
        NSString *key =[NSString convertIntgerToString:allModel.Newsclass.Id];//keyEnum.nextObject;
        //dictArr 装的模型 写入plist文件 话题那边的模型是归档的
        NSArray *dictArr = [self getWSNewsModel:allModel];
        //dict[key];
        
//        NSMutableArray *arrM = [NSMutableArray array];
//        for (NSDictionary *dict in dictArr) {
//            WSNews *news = [self contentWithDict:dict];
//            [arrM addObject:news];
//        }
        
        
        if (isCache) {
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath = [filePath stringByAppendingFormat:@"/%@.plist",key];
            [dictArr writeToFile:filePath atomically:NO];
        }
        
        success(dictArr.copy);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       
        failure(error);
        
    }];

}

+ (NSMutableArray*)getWSNewsModel:(WSNewsAllModel*)allModel{
    NSArray *NewslistArr = allModel.Newslist;
//    NSArray *BlocknewsArr = allModel.Blocknews;
    NSMutableArray *NewslistArrOther = [NSMutableArray array];
    for (Newslist*list in NewslistArr) {
        list.Type = @"1";
        [NewslistArrOther addObject:list];
    }
    //blocknews不要显示
//    NSMutableArray *BlocknewsArrOther = [NSMutableArray array];
//    for (Blocknews*news in BlocknewsArr) {
//        Newslist *list = [[Newslist alloc] init];
//        list.Id = news.Id ;
//        list.Newslink = news.Newslink ;
//        list. Edittime= news.Edittime ;
//        list.HomeTitle = news.HomeTitle ;
//        list.Descriptions = news.Descriptions ;
//        list.Hits = news.Hits ;
//        list.Picsmall = news.Picsmall ;
//        list.Subid = news.Subid ;
//        list.Classid = news.Classid ;
//        list.Title = news.Title ;
//        list.Type = @"2" ;
//        [BlocknewsArrOther addObject:list];
//    }
//    [NewslistArrOther addObjectsFromArray:BlocknewsArrOther];
    return NewslistArrOther;
}



+ (NSArray *)cacheFileArrWithChannelID:(NSString *)channelID{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath = [filePath stringByAppendingFormat:@"/%@.plist",channelID];
    
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSDictionary * dict in dictArr) {
        
        WSNews *news = [WSNews contentWithDict:dict];
        [arrM addObject:news];
    }
    
    return arrM;
}


+ (instancetype)contentWithDict:(NSDictionary *)dict{
    
    WSNews *obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setAds:(NSArray *)ads{
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:ads.count];
    
    for (NSDictionary *dict in ads) {
        
        WSAds *ad = [WSAds adsWithDict:dict];
        [arrM addObject:ad];
    }
    _ads = [arrM copy];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
