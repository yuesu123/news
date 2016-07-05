//
//  QTTgView.m

//
//  Created by apple on 14-4-25.
//  Copyright (c) 2014年 gw. All rights reserved.
//

#import "WSTopicNewsListCell.h"
#import "UIImageView+WebCache.h"
#import "WSTopicContentListModel.h"
#import "NSArray+Extensions.h"

@interface WSTopicNewsListCell ()

@property (nonatomic, copy) NSString  *classfication;




@end

@implementation WSTopicNewsListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"vediolist";
    WSTopicNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WSTopicNewsListCell" owner:nil options:nil] lastObject];
           cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}

- (void)setZtNewslist:(ZtNewslist *)ztNewslist{
    _ztNewslist = ztNewslist;
    self.recommendBtn.hidden = YES;
    self.titleLable.text = ztNewslist.Title;
    
    if ([[NSArray  readFile:@"zhuanti"] containsObject:ztNewslist.Title]) {
        self.titleLable.textColor = [UIColor grayColor];
    } else {
        self.titleLable.textColor = [UIColor blackColor];
    }
    
    
    [self.videoImage  sd_setImageWithURL:NSURLWithStr(ztNewslist.Picsmall)
                        placeholderImage:[UIImage imageNamed:@"zhuanti_lIst"]];
    self.viewNumLab.text = [QTCommonTools convertServiceTimeToStandartShowTime:ztNewslist.Edittime];

}




@end
