//
//  WSCommentCell.h
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSCommentModel.h"
@class Mvc_Pingitems;

@interface WSCommentCell : UITableViewCell

@property (strong, nonatomic) Mvc_Pingitems *comment;

+ (instancetype)commentCellWithTableView:(UITableView *)tableView;

@end
