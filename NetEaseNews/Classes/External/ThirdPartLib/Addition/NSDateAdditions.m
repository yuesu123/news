//
//  NSDateAdditions.m
//  LifeInChengdu
//
//  Created by kiwi on 5/31/13.
//  Copyright (c) 2013 pinyou. All rights reserved.
//

#import "NSDateAdditions.h"

@implementation NSDate (Additions)

- (NSString*)convertStringFromDate:(NSString*)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString * res = [formatter stringFromDate:self];
    if ([res hasPrefix:@"0"]) {
        res = [res substringFromIndex:1];
    }
    return res;
}

- (NSString*)convertDateToString {
    return [self convertStringFromDate:@"yyyy/MM/dd"];
}

- (NSString*)yearsPastFromNow {
    NSString * pastDate = [self convertStringFromDate:@"yyyy"];
    NSString * nowDate = [[NSDate date] convertStringFromDate:@"yyyy"];
    return [NSString stringWithFormat:@"%d", [nowDate intValue]-[pastDate intValue]];
}

@end
