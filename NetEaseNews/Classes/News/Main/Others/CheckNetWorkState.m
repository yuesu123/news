//
//  CheckNetWorkState.m
//  NetEaseNews
//
//  Created by  汪刚 on 16/6/19.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "CheckNetWorkState.h"

@implementation CheckNetWorkState
+ (NetworkStatus)checkNetworkState
 {
        // 1.检测wifi状态
         Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
       // 2.检测手机是否能上网络(WIFI\3G\2.5G)
        Reachability *conn = [Reachability reachabilityForInternetConnection];
    
        // 3.判断网络状态
         if ([wifi currentReachabilityStatus] == ReachableViaWiFi) { // 有wifi
                 NSLog(@"有wifi");
        
             } else if ([conn currentReachabilityStatus] == ReachableViaWWAN) { // 没有使用wifi, 使用手机自带网络进行上网
                     NSLog(@"使用手机自带网络进行上网");
            
                 } else { // 没有网络
                     
                         NSLog(@"没有网络");
    }
     return [wifi currentReachabilityStatus];
}
@end
