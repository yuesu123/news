//
//  WSCommentCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/1.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSCommentCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "WSCommentModel.h"

@interface WSCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *placeView;
@property (weak, nonatomic) IBOutlet UILabel *commentView;
@property (weak, nonatomic) IBOutlet UILabel *timeSpanView;
@property (weak, nonatomic) IBOutlet UILabel *supportCount;
@property (weak, nonatomic) IBOutlet UIButton *supportBtn;


@end

@implementation WSCommentCell

//#pragma mark - 设置数据
- (void)setComment:(Mvc_Pingitems *)comment{
    _comment = comment;
    self.commentView.text = comment.Pldetail;

    self.iconView.image  = [UIImage imageNamed:@"logo108"];

        self.timeSpanView.text = [QTCommonTools convertServiceTimeToStandartShowTime:comment.Addtime];
    self.titleView.text = [QTCommonTools phoneNumAddStar:comment.Plsign];

}
//
//
//
#pragma mark - init

- (void)awakeFromNib{
    
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
}

+ (instancetype)commentCellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"commentCell";
    
    WSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"WSCommentCell" owner:nil options:nil].firstObject;
    }
    
    return cell;
}



@end
