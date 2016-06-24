//
//  ColorHelper.h
//  CarPool
//
//  Created by kiwi on 14-6-23..
//  Copyright (c) 2014年 NigasMone. All rights reserved.
//


#ifndef Custom_ColorHelper_h
#define Custom_ColorHelper_h

#define kYellowColor [UIColor colorWithRed:233/255.0 green: 182/255.0 blue: 77/255.0 alpha: 1.0]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 \
alpha:(a)]

//RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define  RGBCommonBack  RGBACOLOR(239,239,244,1)
#define  RGBCommonLineBack  RGBACOLOR(235,235,236,1)
#define  RGBCommonBlue  RGBACOLOR(66,175,249,1)

#endif
