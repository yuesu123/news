//
//  UILabel+WF.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-21.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import "UILabel+WF.h"

@implementation UILabel(WF)



-(CGFloat)getHeightOfContentForWidth:(CGFloat)width fontSize:(CGFloat)font
{
    CGSize size = [ self.text  sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(width, 500.0f) lineBreakMode:NSLineBreakByCharWrapping];

    return size.height;
}


    //根据字体的大小和宽度计算高度
- (CGFloat)heightForStringFontSize:(CGFloat)fontSize andWidth:(CGFloat)width//根据字符串的的长度来计算UITextView的高度
{
    CGFloat height = [[NSString stringWithFormat:@"%@\n ",self.text] boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize: fontSize], NSFontAttributeName, nil] context:nil].size.height;

    return height;
    
}

@end
