//
//  NSJSONSerializationAdditions.h
//  CarPool
//
//  Created by kiwi on 14-1-25.
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Additions)

+ (id)JSONObjectWithString:(NSString *)string options:(NSJSONReadingOptions)opt error:(NSError **)error;

@end
