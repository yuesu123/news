//
//  QTUserInfo.h
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-25.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "MJExtension.h"


@class Urerreg;
@interface QTUserInfo : NSObject
singleton_interface(QTUserInfo)


/**
 *  北仑手机号
 */
@property (nonatomic, copy) NSString* phoneNum;
/**
 *  北仑密码
 */
@property (nonatomic, copy) NSString* passWD;
/**
 *  北仑userid
 */
@property (nonatomic, copy) NSString* userId;

//返回的信息

@property (nonatomic, copy) NSString *Msgtype;

@property (nonatomic, assign) NSInteger Success;

@property (nonatomic, copy) NSString *Tip;

@property (nonatomic, strong) Urerreg *Urerreg;

@property (nonatomic, copy) NSString *Msg;
//yes 当前已经登录  No 未登录状态
@property (nonatomic, assign) BOOL hadLogin;
@property (nonatomic, copy) NSString* adlink;


//-------下面的都没用

@property (nonatomic, copy) NSString* userName;


@property (nonatomic, copy) NSString* invite_code;
@property (nonatomic, copy) NSString* reWriteinvite_code;
@property (nonatomic, copy) NSString  *iconImge;

@property (nonatomic, copy) NSString  *nickName;


//用户信息
@property (nonatomic, copy) NSString  *roles;
@property (nonatomic, copy) NSString  *myProvince;
@property (nonatomic, copy) NSString  *myCity;
@property (nonatomic, copy) NSString  *district;
@property (nonatomic, copy) NSString  *myAddress;
@property (nonatomic, assign) double  myLa;
@property (nonatomic, assign) double  myLo;


//0:注册用户登录，1：微信，2:qq,3：新浪
@property (nonatomic, copy) NSString *type;
//第三方登录的openId,如果是第三方登录的时候必须填写openId
@property (nonatomic, copy) NSString *openId;

//Yes,直接登录

//@property (nonatomic, assign) BOOL loginSuccess;
//性别 1是男  0和其他是女
@property (nonatomic, assign) BOOL gender;

//注册的用户名
@property (nonatomic, copy) NSString *registerPhoneNum;
//注册的密码
@property (nonatomic, copy) NSString *registerPwd;
@property (nonatomic, copy) NSString *point;
@property (nonatomic, copy) NSString *pointUrl;
@property (nonatomic, copy) NSString *pointImage;
@property (nonatomic, copy  ) NSString   *consultationNo;
@property (nonatomic, copy  ) NSString   *coursesNo;
@property (nonatomic, copy  ) NSString   *account;
/**
 *  存储的微信商户订单号
 */
@property (nonatomic, copy) NSString *weiXinorderno;
//是否下单成功
@property (nonatomic, assign) BOOL appoitmentOrder;

//联系人Id
@property (nonatomic, copy) NSString  *contactId;

//写入用户登录信息到UserDefault
-(void)writeUserInfoToDefault;
//得到用户信息
-(void)loadUserInfoFromDefault;
-(void)clearDefault;




+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
@interface Urerreg : NSObject

@property (nonatomic, copy) NSString *Mobile;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger Userid;
@property (nonatomic, assign) NSInteger   Jifen;

@end

