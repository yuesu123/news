//
//  QTLoginViewController.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-22.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import "QTLoginViewController.h"
#import "UIButton+WF.h"
#import "UIImage+WF.h"
#import "UITextField+WF.h"
#import "QTRegidterViewController.h"

//#import "QTUserInfo.h"
//#import "UMSLoginViewController.h"


//#import "XMPPHeader.h"
//#import "Reachability.h"
//#import "CeShiTabBarController.h"
//#import "DBManager.h"
//#import "NSString+Hash.h"

#import "UIViewController+HUD.h"
#import "UMSocialQQHandler.h"

@interface QTLoginViewController ()<UITextFieldDelegate>

//@property (nonatomic,strong) SetMessageSoundModel * setMessageModel;
@property (weak, nonatomic) IBOutlet UITextField *passwd;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;


@property (weak, nonatomic) IBOutlet UILabel *thirdPartWenZiIsShow;

@property (weak, nonatomic) IBOutlet UIView *grayLineIsShow;

@property (weak, nonatomic) IBOutlet UIButton *weixinIsShow;
@property (weak, nonatomic) IBOutlet UIButton *weiboIsshow;
@property (nonatomic, copy  ) NSString   *lastInputPhonenum;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation QTLoginViewController


-(void)loginWithTag:(UIButton *)btn{
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"operationbox_text"];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    image = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
//    self.phoneNum.background = image;
//    self.passwd.background = image;
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    UIView*view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    self.phoneNum.leftView = view;
    self.phoneNum.leftViewMode = UITextFieldViewModeAlways;
    self.passwd.leftView = view2;
    self.passwd.leftViewMode = UITextFieldViewModeAlways;
    self.passwd.delegate =self;
//    NSString *phoneSave = standardUserForKey(@"phoneNum");
//    if (strNotNil(phoneSave)) {
//        self.phoneNum.text = phoneSave;
//    }
//    
    [[QTCommonTools sharedQTCommonTools] addTextfeildLeftView:self.phoneNum image:[UIImage imageNamed:@"smallImage_username"]];
    [[QTCommonTools sharedQTCommonTools] addTextfeildLeftView:self.passwd image:[UIImage imageNamed:@"smallImage_password"]];
    self.loginBtn.backgroundColor = BlueColorCommon;
    self.registBtn.backgroundColor = BlueColorCommon;
    self.forgetBtn.backgroundColor = BlueColorCommon;
    [QTCommonTools clipAllView:_loginBtn Radius:kclipCornerSmall borderWidth:0 borderColor:nil];
    [QTCommonTools clipAllView:_registBtn Radius:kclipCornerSmall borderWidth:0 borderColor:nil];
    [QTCommonTools clipAllView:_forgetBtn Radius:kclipCornerSmall borderWidth:0 borderColor:nil];
    self.loginBtn.hidden = NO;


}


- (void)injected{
    NSLog(@"I've been injected: %@", self);
    [self viewDidLoad];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSString *phone = [QTUserInfo sharedQTUserInfo].phoneNum;
    if (strNotNil(phone)) {
        self.phoneNum.text = phone;
    } 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

   
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.phoneNum resignFirstResponder];
    [self.passwd resignFirstResponder];
    [super viewWillDisappear:animated];
}



//- (IBAction)backToMe:(id)sender {
//
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


- (IBAction)loginClick
{
        //1.获取输入信息并判断
    NSString* phoneNum = self.phoneNum.text;
    NSString* passwd = self.passwd.text;

        //判断是否手机号和面都输入了
    if (!phoneNum || !passwd||[phoneNum isEqualToString:@""]||[passwd isEqualToString:@""])
        {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"用户名或密码为空"delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;

        }
    
    
    
    NSString* phone = self.phoneNum.text;
    ECLog(@" == %@",phone);
    //0.判断是否输入正确手机号
    if(!phone ||[phone isEqualToString:@""]){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入手机号"];
        return;
        
    }
    if (![self.phoneNum isTelphoneNum]) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入正确的手机号"];
        return;
        
    }

    [self.view endEditing:YES];
    [self loadDataLogin:YES];
    _lastInputPhonenum = phoneNum;
}


- (void)loadDataLogin:(BOOL)needHud{
    NSString *phone = self.phoneNum.text;
    NSString *passw = self.passwd.text;

    if (!needHud) {
        phone = [QTUserInfo sharedQTUserInfo].phoneNum;
        passw = [QTUserInfo sharedQTUserInfo].passWD;
        if (!strNotNil(passw)) {
            ECLog(@"自动登录缺用户名密码!");
            return;
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"api/loginsave?mobile=%@&pass=%@",phone,passw];
    [QTFHttpTool requestPOSTURL:url paras:nil needHud:needHud hudView:self.view   loadingHudText:@"登录中..." errorHudText:nil sucess:^(id json) {
        if (![json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        NSDictionary *dic = (NSDictionary*)json;
        BOOL success = (BOOL)[dic[@"Success"] boolValue];
        NSString *Msg = dic[@"Msg"];
        if (!success) {return;}
        if (needHud) {
//            SHOW_ALERT(Msg);
        }else{
            ECLog(@"自动登录成功!");
        }
        Urerreg *urrrrg = [Urerreg objectWithKeyValues:json[@"Urerreg"]];
        [QTUserInfo sharedQTUserInfo].phoneNum = urrrrg.Mobile;
        [QTUserInfo sharedQTUserInfo].userId =[NSString convertIntgerToString:urrrrg.Userid] ;
        [QTUserInfo sharedQTUserInfo].passWD = passw;
        [QTUserInfo sharedQTUserInfo].Urerreg = urrrrg;
        [QTUserInfo sharedQTUserInfo].hadLogin = YES;

        [[QTUserInfo sharedQTUserInfo] writeUserInfoToDefault];
        if (_loginSuccessBlock) {
            _loginSuccessBlock(dic);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } failur:nil];
}
- (void)loginSuccessBlock:(WSLoginSuccess)loginSuccess{
    _loginSuccessBlock = loginSuccess;
}

#pragma mark –
#pragma mark Action and UI Event

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneNum resignFirstResponder];
    [self.passwd resignFirstResponder];

}


- (IBAction)registBtnClicked:(UIButton *)sender {
    [self gotoRegisterVc];
}


-(void)gotoLogin
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 获取故事板中某个View
    UINavigationController* vc =  [board instantiateViewControllerWithIdentifier:@"loginNvc"];
}


- (void)gotoRegisterVc{
    ECLog(@"点击用户头像");
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    QTRegidterViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"registerMeID"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}




@end
