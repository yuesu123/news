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
//    self.imageView.contentMode = UIViewContentModeScaleToFill;//
////    UIViewContentModeScaleToFill/UIViewContentModeScaleAspectFill;//UIViewContentModeScaleAspectFit;//UIViewContentModeScaleToFill;
//    ECLog(@"轮播:%@",ad.Picsmall);
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:ad.Picsmall] placeholderImage:[UIImage imageNamed:[WSImageView getImageName:@"home_roll"]]];
//    self.imageView.backgroundColor  = [UIColor redColor];
}


@end
