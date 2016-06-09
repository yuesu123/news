//
//  WSContentController.h
//  网易新闻
//
//  Created by WackoSix on 15/12/30.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WSContentControllerTypeNews  = 1,
    WSContentControllerTypeZhuanti  = 2,
} WSContentControllerType;


@interface WSContentController : UIViewController

@property (nonatomic, strong) id newsItem;
@property (nonatomic, strong) UIImageView *shareImage;

///**新闻内容标识*/
//@property (copy, nonatomic) NSString *docid;
//@property (copy, nonatomic) NSString *newsLink;
//@property (nonatomic, assign) WSContentControllerType   wscontentControllerType;

+ (instancetype)contentControllerWithItem:(id)newsItem;

@end
