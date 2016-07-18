//
//  WSNewsAllModel.m
//  NetEaseNews
//
//  Created by HLH on 16/5/27.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSNewsAllModel.h"

@implementation WSNewsAllModel


+ (NSDictionary *)objectClassInArray{
    return @{@"Blocknews" : [Blocknews class], @"Newslist" : [Newslist class],@"Newsad":[WSAdModel class],@"Tjnews":[Tjnews class]};
}
@end
@implementation Newsclass

@end


@implementation Blocknews

@end


@implementation Tjnews

@end

@implementation Newslist






+ (void)newsListDataWithNewsID:(NSString *)newsID newsCache:(BOOL)isCache getDataSuccess:(GetDataSuccessBlock)success getFailure:(GetDataFailureBlock)failure{
    
    [WSGetDataTool GETJSON:newsID GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        WSNewsAllModel *allModel = [WSNewsAllModel objectWithKeyValues:responseObject];
        
        //        NSDictionary *dict = responseObject;
        //        NSEnumerator *keyEnum = dict.keyEnumerator;
        
        
        //缓存的key 使用每个classId 作为key
        /*classId 相当于以前的频道ID*/
        NSString *key =[NSString convertIntgerToString:allModel.Newsclass.Id];//keyEnum.nextObject;
        //dictArr 装的模型 写入plist文件 话题那边的模型是归档的
        NSArray *ModleArr = [self getWSNewsModel:allModel];
        //通过模型数组创建字典数组 字典数组用来写入plsit
        NSMutableArray *dictArr = [Newslist keyValuesArrayWithObjectArray:ModleArr];
        
        NSMutableArray *retureArr =[NSMutableArray array];
        [retureArr addObject:allModel];
        
        //dict[key];
        
        //        NSMutableArray *arrM = [NSMutableArray array];
        //        for (NSDictionary *dict in dictArr) {
        //            WSNews *news = [self contentWithDict:dict];
        //            [arrM addObject:news];
        //        }

        
        if (isCache) {//写入plist 的是对象
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath = [filePath stringByAppendingFormat:@"/%@.plist",key];
            [dictArr writeToFile:filePath atomically:NO];
        }
        
//        success(ModleArr.copy);
        success(retureArr);
        
        
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
    //通过字典数组获取模型数组
    NSArray *modelArr = [Newslist objectArrayWithKeyValuesArray:dictArr];
//    NSMutableArray *arrM = [NSMutableArray array];
    
//    for (NSDictionary * dict in dictArr) {
        //取出的字典转化为模型
        //        WSNews *news = [WSNews contentWithDict:dict];
        //        [arrM addObject:news];
//    }
    
    return modelArr/*arrM*/;
}



- (void)setAds:(NSArray *)ads{
    
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:ads.count];
    
    for (NSDictionary *dict in ads) {
        
//        WSAds *ad = [WSAds adsWithDict:dict];
//        [arrM addObject:ad];
    }
    _ads = [arrM copy];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end


