//
//  WSTopicCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/10.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSTopicCell.h"
//#import "WSTOpicAllModel.h"
#import "UIImageView+WebCache.h"
#import "WSImageView.h"
#import "WSTopicModel.h"

@interface WSTopicCell ()

@property (weak, nonatomic) IBOutlet WSImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UILabel *concernCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *categoryLbl;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end



@implementation WSTopicCell

+ (CGFloat)rowHeight{
    
    return 245;
}

- (void)setTopic:(Ztlist *)topic{
    
    _topic = topic;
    
    self.imgView.contentMode = UIViewContentModeScaleToFill;
//    self.imgView.contentMode =UIViewContentModeScaleAspectFit ;//UIViewContentModeScaleAspectFill;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:topic.Picsmall] placeholderImage:[UIImage imageNamed:[WSImageView getImageName:@"zhuanti"]]];
    self.detailLbl.text = topic.Ztdes;
    self.concernCountLbl.text = [NSString stringWithFormat:@"%@关注",topic.Ztpinyin];
    self.nameLbl.text = topic.Zttitle;
    self.categoryLbl.text = [NSString stringWithFormat:@"topic.Hits"];
    
}


+ (instancetype)topicCellWithTableView:(UITableView *)tableView{
    
    WSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell"];
    
    cell.iconView.layer.cornerRadius = cell.iconView.bounds.size.width * 0.5;
    cell.iconView.layer.masksToBounds = YES;
    
    return cell;
}


@end
