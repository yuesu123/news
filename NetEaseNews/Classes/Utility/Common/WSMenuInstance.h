//
//  WSMenuInstance.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/26.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WSMenuInstance : NSObject
singleton_interface(WSMenuInstance);
@property (nonatomic, strong) NSMutableArray *allMenuArr;

@property (nonatomic, strong) NSMutableArray *menuOneArr;
@property (nonatomic, strong) NSMutableArray *menuTwoArr;
@property (nonatomic, strong) NSMutableArray *menuThreeArr;
@property (nonatomic, strong) NSMutableArray *menuFourArr;

@property (nonatomic, strong) NSMutableArray *tabbarArr;




@end
