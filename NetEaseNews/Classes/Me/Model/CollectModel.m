//
//  CollectModel.m
//  新闻
//
//  Created by gyh on 16/4/25.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "CollectModel.h"

@implementation CollectModel
+ (NSDictionary *)objectClassInArray{
    return @{@"NewsMode" : [NewsMode class],@"ZtNewsMode" : [ZtNewsMode class]};
}

//
//- (void)encodeWithCoder:(NSCoder *)enCoder{
//    // 取得所有成员变量名
//    [enCoder encodeInteger:_Userid forKey:@"Userid"];
//    [enCoder encodeInteger:_Newsid forKey:@"Newsid"];
//    [enCoder encodeInteger:_Id forKey:@"Id"];
//    [enCoder encodeInteger:_Classid forKey:@"Classid"];
//    [enCoder encodeObject:_Title forKey:@"Title"];
//    [enCoder encodeInteger:_Subid forKey:@"Subid"];
//    [enCoder encodeInteger:_Hits forKey:@"Hits"];
//    
//    
//}
//
//// 解档
//- (id)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        _Userid = [aDecoder decodeIntegerForKey:@"Userid"];
//        _Newsid =[aDecoder decodeIntegerForKey:@"Newsid"];
//        _Id =[aDecoder decodeIntegerForKey:@"Id"];
//        _Classid = [aDecoder decodeIntegerForKey:@"Classid"];
//        _Title = [aDecoder decodeObjectForKey:@"Title"];
//        _Subid = [aDecoder decodeIntegerForKey:@"Subid"];
//        _Hits = [aDecoder decodeIntegerForKey:@"Hits"];
//    }
//    return self;
//}


@end
@implementation NewsMode

@end

@implementation ZtNewsMode

@end


