//
//  WSNewsCell.m
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import "WSNewsCell.h"
#import "UIImageView+WebCache.h"
//#import "WSNews.h"
#import "WSNewsAllModel.h"
#import "WSImageView.h"
#import "NSString+WS.h"
#import "DDNewsCache.h"
#import "NSArray+Extensions.h"
#import "QTCommonTools.h"

@interface WSNewsCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *replyCountBtnWidth;
@property (weak, nonatomic) IBOutlet WSImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property (strong, nonatomic) IBOutletCollection(WSImageView) NSArray *extraImageViews;
@property (assign, nonatomic) WSNewsCellType cellType;

@end

static NSString * normalID = @"normalCell";
static NSString * bigImageID = @"bigImageCell";
static NSString * threeImageID = @"threeImageCell";

@implementation WSNewsCell

+ (CGFloat)rowHeighWithCellType:(WSNewsCellType)type{
    
    switch (type) {
        case WSNewsCellTypeNormal:
            return 100;
            break;
        case WSNewsCellTypeBigImage:
            return 100;
            break;
        case WSNewsCellTypeThreeImage:
            return 120;
            break;
            
        default:
            break;
    }
}

+ (instancetype)newsCellWithTableView:(UITableView *)tableview cellNews:(Newslist *)news IndexPath:(NSIndexPath *)indexPath{
    
    WSNewsCell *cell = nil;
    
   if (/*news.Type.count == 2*/news.Showtype == 2){//图片数组的个数
       cell = [tableview dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",threeImageID] forIndexPath:indexPath];
        cell.cellType = WSNewsCellTypeThreeImage;
    
    }else if (news.Showtype == 1){ //一个图
    
        cell = [tableview dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",bigImageID] forIndexPath:indexPath];
        cell.cellType = WSNewsCellTypeBigImage;
   }else{ //左图又文字
      cell = [tableview dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",normalID] forIndexPath:indexPath];
        cell.cellType = WSNewsCellTypeNormal;
    }
    
    [cell setNews:news];
    
    return cell;
}




- (void)setNews:(Newslist *)news{
    
    _news = news;
    self.iconView.contentMode = UIViewContentModeScaleToFill;
    
    NSString *placeStr = nil;
    switch (news.Showtype)
    {
        case 2: //三图
            placeStr = @"zhuanti_lIst";
            break;
        case 1://直栏
            placeStr = [WSImageView getImageName:@"home_zhilan"];
            break;
        case 0: //左图右文字 
            placeStr = @"zhuanti_lIst";
            break;
    }
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.Picsmall] placeholderImage:[UIImage imageNamed:placeStr]];

    
    if ([[NSArray  readFile:@"state"] containsObject:news.Title]) {
        self.titleLbl.textColor = [UIColor grayColor];
    } else {
        self.titleLbl.textColor = [UIColor blackColor];
    }
    self.titleLbl.text = news.Title;
    self.detailLbl.hidden = YES;
    if (strNotNil(news.Edittime)) {
            [self.replyCountBtn setTitle:[NSString stringWithFormat:@"%@",[QTCommonTools convertServiceTimeToStandartShowTime:news.Edittime]] forState:UIControlStateNormal];
    }else{
        [self.replyCountBtn setTitle:@"" forState:UIControlStateNormal];
    }

    if(news.Showtype == 2){//
        for (NSInteger i=0; i<news.Showtype; i++) {
            UIImageView *imgView = self.extraImageViews[i];
            imgView.contentMode = UIViewContentModeScaleToFill;
            [imgView sd_setImageWithURL:[NSURL URLWithString:[self getImage:news  i:i]] placeholderImage:[UIImage imageNamed:[WSImageView getImageName:@"home_three"]]];
        }
    }    
    CGSize fontSize = [self.replyCountBtn.titleLabel.text sizeOfFont:self.replyCountBtn.titleLabel.font textMaxSize:CGSizeMake(125, 21)];
    self.replyCountBtnWidth.constant = fontSize.width + 8;
}


- (NSString*)getImage:(Newslist*)news i:(NSInteger)i{
        if (i == 0) {
            return news.Picsmall;
        }else if(i ==1 ){
            return news.Picsmall2;
        }else{
            return news.Picsmall3;
        }
}


@end
