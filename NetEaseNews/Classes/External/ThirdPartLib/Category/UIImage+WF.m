//
//  UIImage+WF.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-20.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import "UIImage+WF.h"

@implementation UIImage(WF)

+(UIImage *)stretchedImageWithName:(NSString *)name{

    UIImage *image = [UIImage imageNamed:name];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    return [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

@end
