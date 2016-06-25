//
//  NSArray+safeMethod.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/6/24.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "NSArray+safeMethod.h"

@implementation NSArray (safeMethod)
- (id)objectAtIndexSafe:(NSUInteger)index{
    if (self.count<=index) {
        NSAssert(self.count>index, @"数组越界了");
        return nil;
    }else{
        id obj = [self objectAtIndex:index];
        return obj;
    }
}
@end
