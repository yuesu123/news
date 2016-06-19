//
//  CheckNetWorkState.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/6/19.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CheckNetWorkState : NSObject
+ (NetworkStatus)checkNetworkState;
@end
