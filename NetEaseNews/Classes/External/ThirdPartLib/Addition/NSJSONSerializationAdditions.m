//
//  NSJSONSerializationAdditions.m
//  CarPool
//
//  Created by kiwi on 14-1-25.
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//

#import "NSJSONSerializationAdditions.h"

@implementation NSJSONSerialization (Additions)

+ (id)JSONObjectWithString:(NSString *)string options:(NSJSONReadingOptions)opt error:(NSError **)error {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self JSONObjectWithData:data options:opt error:error];
}

@end
