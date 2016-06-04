//
//  WSChannel.m
//  网易新闻
//
//  Created by WackoSix on 16/1/8.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSChannel.h"

@implementation WSChannel

+ (instancetype)channelWithDict:(NSDictionary *)dict{
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    //此处基本没啥问题 所有依据classid 加载
//    if([[obj tname] isEqualToString:@"头条"]){
        [obj setChannelURL:[NSString stringWithFormat:@"api/newslist?classid=%@",[obj tid]]];
//    }else{
//        
//        [obj setChannelURL:[NSString stringWithFormat:@"/nc/article/list/%@/0-20.html",[obj tid]]];
//    }
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


@end
