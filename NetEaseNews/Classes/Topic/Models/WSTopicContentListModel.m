//
//  WSTOpicAllModel.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/28.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicContentListModel.h"
#import "WSTopicModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation WSTopicContentListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"ZtNewslist" : [ZtNewslist class], @"Blocknews" : [Blocknews class]};
}

@end







@implementation ZtNewslist





@end





