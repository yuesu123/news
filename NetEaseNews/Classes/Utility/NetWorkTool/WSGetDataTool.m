//
//  WSGetDataTool.m
//  网易新闻
//
//  Created by WackoSix on 16/1/6.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSGetDataTool.h"

static NSString const * baseURL = @"http://c.m.163.com/";
static NSString const * commentURL = @"http://comment.api.163.com/api/json/post/list/new/";
//static NSString const * baseURL = @"http://c.m.163.com/";





@implementation WSGetDataTool

static id _instance;

+ (NSURLSessionDataTask *)GETJSON:(NSString *)urlStr GetDataType:(WSGETDataType)type progress:(progressBlock)progress success:(successBlock)success failure:(failureBlock)failure{
    
    //判断字符串是否合法
    if([urlStr characterAtIndex:0] == '/') urlStr = [urlStr substringFromIndex:1];
    
    if (type == WSGETDataTypeBaseURL) {
        
        urlStr = [NSString stringWithFormat:@"%@/%@",sg_privateNetworkBaseUrl ,urlStr];
    }else if (type == WSGETDataTypeCommentURL){
        
        urlStr = [NSString stringWithFormat:@"%@%@", commentURL, urlStr];
    }
    ECLog(@"请求url \n\n %@ \n\n",urlStr);
   return [self GETJSON:urlStr progress:progress success:success failure:failure];
    
}


+ (NSURLSessionDataTask *)GETJSON:(NSString *)urlStr progress:(progressBlock)progress success:(successBlock)success failure: (failureBlock)failure{
    
    WSGetDataTool *tool = [self shareGetDataTool];
    
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //设置json解析的可以接收的服务器返回类型(Content-Type)
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    NSSet *set = [NSSet setWithArray:@[@"text/html", @"application/json",@"*/*"]];
    response.acceptableContentTypes = set;
    tool.responseSerializer = response;
    
    
    
    //这里可以进行加密处理
    return [tool GET:urlStr parameters:nil progress:progress success:success failure:failure];
    
}

+ (instancetype)shareGetDataTool{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

@end
