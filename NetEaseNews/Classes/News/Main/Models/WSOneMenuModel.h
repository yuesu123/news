//
//  WSOneMenuModel.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/26.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

//这是一个菜单的模型
@interface WSOneMenuModel : NSObject

@property (nonatomic, assign) NSInteger Sortid;

@property (nonatomic, copy) NSString *Classen;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Parentpath;

@property (nonatomic, assign) NSInteger Depth;

@property (nonatomic, copy) NSString *Mobanen;

@property (nonatomic, assign) NSInteger Parentid;

@property (nonatomic, copy) NSString *Classname;

@property (nonatomic, copy) NSString *Referurl;

@property (nonatomic, copy) NSString *Classdes;

@end
