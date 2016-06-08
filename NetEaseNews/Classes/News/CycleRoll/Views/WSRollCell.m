//
//  WSRollCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSRollCell.h"
#import "UIImageView+WebCache.h"
//#import "WSAds.h"
#import "WSImageView.h"
#import "WSNewsAllModel.h"

@interface WSRollCell ()

@property (weak, nonatomic) IBOutlet WSImageView *imageView;

@end

@implementation WSRollCell

- (void)setAd:(Blocknews *)ad{
    _ad = ad;
    self.imageView.contentMode = UIViewContentModeCenter;
    ECLog(@"轮播:%@",ad.Picsmall);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:ad.Picsmall] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
}


@end
