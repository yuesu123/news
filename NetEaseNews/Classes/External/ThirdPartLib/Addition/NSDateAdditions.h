//
//  NSDateAdditions.h
//  LifeInChengdu
//
//  Created by kiwi on 5/31/13.
//  Copyright (c) 2013 pinyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

- (NSString*)convertStringFromDate:(NSString*)format;

- (NSString*)convertDateToString;

- (NSString*)yearsPastFromNow;

@end
