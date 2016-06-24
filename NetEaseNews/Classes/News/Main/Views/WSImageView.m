//
//  WSImageView.m
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSImageView.h"

@implementation WSImageView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    }
    return self;
}



- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.contentMode = UIViewContentModeScaleToFill;
//UIViewContentModeScaleAspectFit 会显示不全
//UIViewContentModeScaleToFill 不管大小都会布图片
 //UIViewContentModeScaleAspectFill 小的会填充大的会超出
 //UIViewContentModeRedraw  晓得会显示不全 大的会超出
//UIViewContentModeCenter 晓得会显示不全  大的会超出
    
    //原来网易的
//    if (self.image.size.width < self.bounds.size.width && self.image.size.height < self.bounds.size.height) {
//        
//        self.contentMode = UIViewContentModeCenter;
//    }else if(self.image.size.width >= self.bounds.size.width || self.image.size.height >= self.bounds.size.height){
//        
//        self.contentMode = UIViewContentModeScaleToFill;
//    }
//    
//    if (self.image.size.width < self.bounds.size.width*0.6 && self.image.size.height < self.bounds.size.height*0.6) {
//        self.contentMode = UIViewContentModeCenter;
//    }else if(self.image.size.width >= self.bounds.size.width || self.image.size.height >= self.bounds.size.height){
//        self.contentMode = UIViewContentModeScaleAspectFit;
//    }
}

+(NSString*)getImageName:(NSString*)imageStr{
    if (Main_Screen_Width<321) {
        return [NSString stringWithFormat:@"%@_5",imageStr];
    }else{
        return imageStr;
    }
}

@end
