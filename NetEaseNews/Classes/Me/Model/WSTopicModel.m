
//
//  WSTopicModel.m
//  NetEaseNews
//
//  Created by HLH on 16/5/28.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicModel.h"

@implementation WSTopicModel


+ (NSDictionary *)objectClassInArray{
    return @{@"Ztlist" : [Ztlist class]};
}
@end


@implementation Ztlist

- (void)encodeWithCoder:(NSCoder *)enCoder{
    // 取得所有成员变量名
    [enCoder encodeInteger:_Id forKey:@"Id"];
    [enCoder encodeObject:_Ztlink forKey:@"Ztlink"];
    [enCoder encodeObject:_Ztpinyin forKey:@"Ztpinyin"];
    [enCoder encodeObject:_Edittime forKey:@"Edittime"];
    [enCoder encodeObject:_Picsmall forKey:@"Picsmall"];
    [enCoder encodeObject:_Zttitle forKey:@"Zttitle"];
    [enCoder encodeObject:_Ztdes forKey:@"Ztdes"];

    
}

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _Id = [aDecoder decodeIntegerForKey:@"Id"];
        _Ztlink =  [aDecoder decodeObjectForKey:@"Ztlink"];
        _Ztpinyin =  [aDecoder decodeObjectForKey:@"Ztpinyin"];
        _Edittime =  [aDecoder decodeObjectForKey:@"Edittime"];
        _Picsmall =  [aDecoder decodeObjectForKey:@"Picsmall"];
        _Zttitle =  [aDecoder decodeObjectForKey:@"Zttitle"];
        _Ztdes =  [aDecoder decodeObjectForKey:@"Ztdes"];
    }
    return self;
}


+ (void)topicWithIndex:(NSInteger)currentPage isCache:(BOOL)cache getDataSuccess:(GetDataSuccessBlock)success getDataFaileure:(GetDataFailureBlock)failure{
//http://app.53bk.com/api/ztlist?pg=1&pagesize=3
    NSString *url = [NSString stringWithFormat:@"api/ztlist?pg=%ld&pagesize=20",currentPage];
    [WSGetDataTool GETJSON:url GetDataType:WSGETDataTypeBaseURL progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dict = (NSDictionary*)responseObject;
        //        NSArray *dictArr = responseObject[@"data"][@"expertList"];
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        //
        //        for (NSDictionary *dict in dictArr) {
        //
        //            WSTopic *topic = [WSTopic topicWithDict:dict];
        //            [arrM addObject:topic];
        //        }
        //转成全部的模型
        WSTopicModel *topModel = [WSTopicModel objectWithKeyValues:dict];
        [arrM addObject:topModel];

        NSArray *dictArr = dict[@"Ztlist"];
        NSMutableArray *ztModelArr = [Ztlist objectArrayWithKeyValuesArray:dictArr];
        
        if(cache && arrM.copy>0){
            
            NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            filePath  = [filePath stringByAppendingPathComponent:@"topic.data"];
            [NSKeyedArchiver archiveRootObject:ztModelArr toFile:filePath];
        }
        
        
        success(arrM.copy);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        failure(error);
        
    }];
}



+ (NSArray *)cacheTopic{
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    filePath  = [filePath stringByAppendingPathComponent:@"topic.data"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


//+ (instancetype)topicWithDict:(NSDictionary *)dict{
//
//    id obj = [[self alloc] init];
//
//    [obj setDesc:dict[@"description"]];
//
//    [obj setValuesForKeysWithDictionary:dict];
//
//    return obj;
//}
@end


