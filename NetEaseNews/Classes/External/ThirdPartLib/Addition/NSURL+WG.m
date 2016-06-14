//
//  NSURL+WG.m
//  NetEaseNews
//
//  Created by HLH on 16/5/28.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "NSURL+WG.h"

@implementation NSURL (WG)

+ (NSURL*)iamgeAddHttpUrl:(NSURL*)url{
    
    NSString *urlNew = nil;
  if (([url.absoluteString hasPrefix:@"http://"] || [url.absoluteString hasPrefix:@"https://"])) {
    urlNew = url.absoluteString;
   }else{
    urlNew = [NSString stringWithFormat:@"%@%@",sg_privateNetworkBaseUrl,url.absoluteString];
  }
//    urlNew = @"http://img5.cache.netease.com/3g/2016/6/14/2016061409494064042.jpg";
    ECLog(@"图片%@",urlNew);
    NSURL *newUrl = [NSURL URLWithString:urlNew];
    return newUrl;
    
}
@end
