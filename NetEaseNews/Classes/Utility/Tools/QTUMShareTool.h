//
//  QTUMShareTool.h
//  ZhuRenWong
//
//  Created by HLH on 15/12/10.
//  Copyright © 2015年 qitian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMSocialDataService.h"

typedef void (^QTShareResult)(UMSocialResponseEntity * result);

@interface QTUMShareTool : NSObject

/**
 *  分享的公共方法
 *
 *  @param title    分享的标题    若传nil 就为shareTitleHasCode
 *  @param content  分享的内容
 *  @param urlStr   点击分享调到的地址
 *  @param platArr  分享那些平台  传nil 就为shareBtnOrder
 *  @param delegate 分享的代理 一般传self
 *  @param image    分享的图像  传nil   image 就为 [UIImage imageNamed:@"Icon-60"]
 */
+ (void)shareWithTitle:(NSString*)title
               contend:(NSString*)content
                urlStr:(NSString*)urlStr
               platArr:(NSArray*)platArr
              delegate:(id)delegate
                 image:(UIImage*)image;

/**
 *  分享的指定的某一平台
 *
 *  @param title    分享的标题    若传nil 就为shareTitleHasCode
 *  @param content  分享的内容
 *  @param urlStr   点击分享调到的地址
 *  @param platName  分享指定平台  nil 是发送到朋友圈
 *  @param delegate 分享的代理 一般传self
 *  @param image    分享的图像  传nil   image 就为 [UIImage imageNamed:@"Icon-60"]
 */
+ (void)shareToOnePlatTitle:(NSString*)title
                    contend:(NSString*)content
                     urlStr:(NSString*)urlStr
                   platName:(NSString*)platName
                   delegate:(id)delegate
                      image:(UIImage*)image result:(QTShareResult)result;
@end
