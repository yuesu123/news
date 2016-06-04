//
//  NetworkConnection.m
//  Leshi
//
//  Created by 杨晓东 on 14-9-25.
//  Copyright (m. All rights reserved.
//

#import "NetworkConnection.h"

@implementation NetworkConnection



-(id)initWithURL:(NSString *)aurl
      successful:(successful )asuccessful
            fail:(fail )error
{
    self = [super init];
    if (self) {
        self.url = aurl;
        self.success = asuccessful;
        self.fai = error;
        
        
    }
    return self;
}

-(void)handleget
{
    
    NSURL *aurl = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:aurl];
    //默认开辟子线程去请求
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
  
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *str=[[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    
    _success(str);
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _fai(error);
}


@end
