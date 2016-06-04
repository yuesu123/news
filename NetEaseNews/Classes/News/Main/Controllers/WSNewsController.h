//
//  WSContentController.h
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    getVersionShould                 = 0,///需要获得版本
    getVersionBegin                  = 1,///开始获取版本
    getVersionDid                        /// 回去版本成功
}getVersion;

@interface WSNewsController : BaseViewController

///**新闻链接标识*/
@property (copy, nonatomic) NSString *channelID;

/**频道的url*/
@property (copy, nonatomic) NSString *channelUrl;
@property (nonatomic, assign)   getVersion  isgetVersion;
//移
@property (nonatomic, assign) BOOL  isShouldForceUP;
@property (nonatomic, copy) NSString  *urlStr;

+ (instancetype)newsController;

@end
