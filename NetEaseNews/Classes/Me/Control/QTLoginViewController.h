//
//  QTLoginViewController.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-22.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WSLoginSuccess)(NSDictionary*dic);


@interface QTLoginViewController : BaseViewController2
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
- (void)gotoLoginFirst:(NSString*)username andPassWord:(NSString*)password;
+ (void)loginWithBlock;
-(void)enter;
@property (nonatomic, copy) WSLoginSuccess loginSuccessBlock;

- (void)loginSuccessBlock:(WSLoginSuccess)loginSuccess;
- (void)loadDataLogin:(BOOL)needHud;
@end
