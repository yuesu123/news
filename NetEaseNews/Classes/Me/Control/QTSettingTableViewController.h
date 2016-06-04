//
//  MeTableViewController.h
//  NetEaseNews
//
//  Created by  汪刚 on 16/5/21.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^WSLoginOutSuccess)(NSDictionary*dic);

@interface QTSettingTableViewController : BaseViewController
@property (nonatomic, copy) WSLoginOutSuccess loginOutSuccessBlock;

- (void)loginSuccessBlock:(WSLoginOutSuccess)loginOutSuccess;
@end
