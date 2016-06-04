//
//  KPickerView.h
//  CarPool
//
//  Created by kiwi on 6/5/13.
//  Copyright (c) 2013 pinyou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPickViewHeight 260         // 216+44
#define kPickViewNavBarHeight 44

typedef enum {
    forPickViewCustom = 1,      // 自定义的 picker
    forPickViewDate = 2,        // 日期
    forPickViewDateAndTime = 3, // 日期 + 时间
    forPickViewTime = 4,        // 时间
}kPickerViewType;

@class KPickerView;

@protocol KPickerViewDelegate <NSObject>

@optional

- (void)kPickerViewWillDismiss:(KPickerView*)sender;
- (void)kPickerViewDidDismiss:(KPickerView*)sender;
- (void)kPickerViewDidCancel:(KPickerView*)sender;

@end

@interface KPickerView : UIView

@property (nonatomic, assign) id <KPickerViewDelegate>  delegate;
@property (nonatomic, strong) NSMutableArray*           content;
@property (nonatomic, strong) NSMutableArray*           selections;
@property (nonatomic, strong) NSDate*                   selectedDate;

@property (nonatomic, assign) id                        picker;
@property (nonatomic, assign) kPickerViewType           type;

- (id)initWithType:(kPickerViewType)theType delegate:(id)del;
- (void)showInView:(UIView*)sup;

@end

@interface KNumber : NSObject

@property (nonatomic, assign) int value;

+ (KNumber*)numberWithValue:(int)val;

@end
