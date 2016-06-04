//
//  QTTgView.h
//  01-团购(基本数据)
//
//  Created by apple on 14-4-25.
//  Copyright (c) 2014年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSTopicNewsListViewController.h"
@class ZtNewslist;
@interface WSTopicNewsListCell : UITableViewCell

@property (nonatomic, strong) ZtNewslist *ztNewslist;

@property (nonatomic, assign) BOOL isFree;
@property (weak, nonatomic) IBOutlet UIButton *toEvaluateBtn;
@property (weak, nonatomic) IBOutlet UILabel *viewNumLab;

@property (weak, nonatomic) IBOutlet UIButton *recommendBtn;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UILabel *introLable;
@property (weak, nonatomic) IBOutlet UILabel *renminbiSign;
@property (weak, nonatomic) IBOutlet UIView *greyLine;


+ (instancetype)cellWithTableView:(UITableView *)tableview;
@end
