//
//  WSNewsCell.h
//  网易新闻
//
//  Created by WackoSix on 16/1/9.
//  Copyright © 2016年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class WSNews;
@class  Newslist;

typedef enum {
    
    WSNewsCellTypeNormal, //正常显示
    WSNewsCellTypeBigImage,  //大图展示
    WSNewsCellTypeThreeImage //三张图片展示
    
}WSNewsCellType;

@interface WSNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@property (strong, nonatomic) Newslist *news;

+ (instancetype)newsCellWithTableView:(UITableView *)tableview cellNews:(Newslist *)news IndexPath:(NSIndexPath *)indexPath;

+ (CGFloat)rowHeighWithCellType:(WSNewsCellType)type;

@end
