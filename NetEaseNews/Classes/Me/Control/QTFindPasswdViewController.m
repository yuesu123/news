//
//  QTFindPasswdViewController.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-29.
//  Copyright (c) 2015年 qitian. All rights reserved.
//

#import "QTFindPasswdViewController.h"
#import "QTRegidterViewController.h"
#import "UITextField+WF.h"
#import "ASIFormDataRequest.h"

@interface QTFindPasswdViewController ()<UITextFieldDelegate>{
    NSInteger _count;
    NSTimer* _countTimer;
    BOOL _sendCheckCode;
    BOOL _codeRight;
}

@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;
@property (weak, nonatomic) IBOutlet UITextField *passwd;

@property (weak, nonatomic) IBOutlet UITextField *confirmPasswd;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end



@implementation QTFindPasswdViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.passwd.delegate = self;
    self.confirmPasswd.delegate = self;
    self.checkBtn.enabled = YES;
    [QTCommonTools clipAllView:_phoneNum Radius:3 borderWidth:1 borderColor:BlueColorCommon];
    [QTCommonTools clipAllView:_passwd Radius:3 borderWidth:1 borderColor:BlueColorCommon];
    [QTCommonTools clipAllView:_checkNum Radius:3 borderWidth:1 borderColor:BlueColorCommon];
    [QTCommonTools clipAllView:_confirmPasswd Radius:3 borderWidth:1 borderColor:BlueColorCommon];
    [QTCommonTools clipAllView:_findBtn Radius:3 borderWidth:1 borderColor:BlueColorCommon];
    _findBtn.backgroundColor = BlueColorCommon;
    [QTCommonTools clipAllView:_checkBtn Radius:3 borderWidth:1 borderColor:BlueColorCommon];
    _checkBtn.backgroundColor = BlueColorCommon;


//
//    [self.checkBtn setResizeN_BG:@"btn_normal" H_BG:@"btn_HL"];
//
//    [self.findBtn setResizeN_BG:@"btn_normal" H_BG:@"btn_HL"];

    UIImage *image = [UIImage imageNamed:@"operationbox_text"];
    int leftCap = image.size.width * 0.5;
    int topCap = image.size.height * 0.5;
    image = [image stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    self.phoneNum.background = image;
    self.passwd.background = image;
    self.checkNum.background = image;
    self.confirmPasswd.background = image;
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    UIView*view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    UIView*view3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];
    UIView*view4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 30)];

    self.phoneNum.leftView = view;
    self.phoneNum.leftViewMode = UITextFieldViewModeAlways;
    self.passwd.leftView = view2;
    self.passwd.leftViewMode = UITextFieldViewModeAlways;

    self.checkNum.leftView = view3;
    self.checkNum.leftViewMode = UITextFieldViewModeAlways;
    self.confirmPasswd.leftView = view4;
    self.confirmPasswd.leftViewMode = UITextFieldViewModeAlways;

    CGFloat MaxY = CGRectGetMaxY(self.findBtn.frame);

    if (MaxY+ 5 > self.view.frame.size.height + 0.6 -64  ) {
        self.scrollView.contentSize = CGSizeMake(0, MaxY+5 );

    }
    else
        self.scrollView.contentSize = CGSizeMake(0, self.view.frame.size.height + 0.6 -64 + 64 );

}


- (IBAction)checkClick:(id)sender {

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

    ECLog(@"点击计时");

        //1.设置timer倒计时
    _count = 60;
    _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setSecond) userInfo:@"countTimer" repeats:YES];
    [self.checkBtn setTitle:@"60秒" forState:UIControlStateNormal];

        //2.发送请求
    [self requestCheckNumForNum:phone];


}
-(void)setSecond
{
    ECLog(@"计时");
    if (0 == _count) {
        [_countTimer invalidate];
        self.checkBtn.enabled = YES;
        [self.checkBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        return;
    }
    _count--;
    NSString* seconds = [NSString stringWithFormat:@"%ld秒",(long)_count];
    if([UIDevice currentDevice].systemVersion.doubleValue >= 8.0){//不是iOS7 是
        self.checkBtn.enabled = NO;
    }
    [self.checkBtn setTitle:seconds forState:UIControlStateNormal];
}

- (IBAction)findClick:(id)sender {
    if ([self.phoneNum.text isEqualToString:@""]) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入手机号码"];
        return;
    }
    if (self.phoneNum.text.length!=11) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入正确的手机号码"];
        return;
    }
    if ([self.checkNum.text isEqualToString:@""]) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入手机验证码"];

        return;

    }

    if (!_sendCheckCode) {
        ECLog(@"未发送验证码");
        [[QTCommonTools sharedQTCommonTools] showAlert:@"验证码错误"];

        return;
    }
        //0.判断是否输入密码
    if(!self.passwd.text ||[self.passwd.text isEqualToString:@""]){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入密码"];
        return;

    }
    
    if(self.passwd.text.length>15){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"密码不要超过15位!"];
        return;

    }
    
    if(!self.confirmPasswd.text ||[self.confirmPasswd.text isEqualToString:@""]){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入确认密码"];
        return;

    }



    if (![self.passwd.text isEqualToString:self.confirmPasswd.text]) {

         [[QTCommonTools sharedQTCommonTools] showAlert:@"两次密码不一致"];
        return;

    }

    [self requestCheckCode:self.phoneNum.text andCode:self.checkNum.text];


}

-(void)viewWillDisappear:(BOOL)animated
{
    [_countTimer invalidate];
    [super viewWillDisappear:animated];
}


#pragma mark 网络访问，放在这里便于获取结果
    //发送验证码
-(void)requestCheckNumForNum:(NSString*)phoneNum
{

    NSURL* URL = [NSURL URLWithString:[self getUrlStrForSendCode:phoneNum]];

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:URL];
        //避免循环引用
    __weak typeof (request) w_requset = request;
     __weak typeof (self) w_self = self;
    [MBProgressHUD showMessage:loadingWaitingStr toView:self.view];
    [request setCompletionBlock:^{
            //1.得到响应，转化为字典，
        NSData* response = [ w_requset responseData];

        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        ECLog(@"%@",dict);
        BOOL success = [dict[@"Success"] boolValue];
        _sendCheckCode = success;
        [MBProgressHUD hideHUDForView:w_self.view];
        NSString *msg = dict[@"Msg"];
        if (success) {
            SHOW_ALERT(msg);
        }else{
            [MBProgressHUD showError:dict[@"Msg"]];
            [_countTimer invalidate];
            self.checkBtn.enabled = YES;
            [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        }


    }];
    [request setFailedBlock:^{
        _sendCheckCode = NO;
       [MBProgressHUD showError:@"网络连接失败"];
        [_countTimer invalidate];
        self.checkBtn.enabled = YES;
        [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
}

    //验证验证码
-(void)requestCheckCode:(NSString*)phoneNum andCode:(NSString*)code
{

     [MBProgressHUD showMessage:nil toView:self.view];

    NSURL* URL = [NSURL URLWithString:[self getUrlStrForCheckCode:phoneNum andCode:code]];

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:URL];




        //避免循环引用
    __weak typeof (request) w_requset = request;

    [request setCompletionBlock:^{
            //1.得到响应，转化为字典，
        NSData* response = [ w_requset responseData];

        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        ECLog(@"%@",dict);


//        [self rePasswd:self.phoneNum.text andCode:self.checkNum.text andPasswd:self.passwd.text];
        BOOL success = [dict[@"Success"] boolValue];
        if (success) {
            ECLog(@"修改密码成功");
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showSuccess:@"重置密码成功,请登录!"];
            Urerreg *urrrrg = [Urerreg objectWithKeyValues:dict[@"Urerreg"]];
            [QTUserInfo sharedQTUserInfo].phoneNum = urrrrg.Mobile;
            [QTUserInfo sharedQTUserInfo].passWD = nil;
            [QTUserInfo sharedQTUserInfo].Urerreg = urrrrg;
            [QTUserInfo sharedQTUserInfo].userId = [NSString convertIntgerToString:urrrrg.Userid];
            [[QTUserInfo sharedQTUserInfo] writeUserInfoToDefault];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:dict[@"Msg"]];
            ECLog(@"修改密码失败");
        }
    }];
    [request setFailedBlock:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络连接失败"];
    }];
    [request setTimeOutSeconds:10];
    [request startAsynchronous];
}

    //设置初始密码，成功即注册成功
-(void)rePasswd:(NSString*)phoneNum andCode:(NSString*)code andPasswd:(NSString*)passwd
{


    NSURL* URL = [NSURL URLWithString:[self getUrlStrForReister:phoneNum andCode:code andPasswd:passwd]];

    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:URL];



        //避免循环引用
    __weak typeof (request) w_requset = request;

    [request setCompletionBlock:^{

        [MBProgressHUD hideHUDForView:self.view];



            //1.得到响应，转化为字典，
        NSData* response = [ w_requset responseData];

        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        ECLog(@"%@",dict);

        BOOL success = [dict[@"success"] boolValue];
        if (success) {
            ECLog(@"修改密码成功");
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showSuccess:@"重置密码成功"];
//            [[QTRequestTools sharedQTRequestTools] logOut];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:dict[@"msg"]];


              ECLog(@"修改密码失败");

        }
        
        
        
        
        
    }];
    [request setFailedBlock:^{
        [MBProgressHUD hideHUDForView:self.view];

        [MBProgressHUD showError:@"网络连接失败"];
        
        
    }];
    
    [request setTimeOutSeconds:10];
    [request startAsynchronous];

}



#pragma mark 点击登录
-(void)gotoLogin
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // 获取故事板中某个View
    UINavigationController* vc =  [board instantiateViewControllerWithIdentifier:@"loginNvc"];
    [self presentViewController:vc animated:YES completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.passwd) {
        [self.confirmPasswd becomeFirstResponder];
    }
    if (textField == self.confirmPasswd) {
        [textField resignFirstResponder];
    }
    return YES;
}


/**
 *  得到含有加密token的urlStr
 *
 *  @return urlStr
 */
-(NSString*)getUrlStrForSendCode:(NSString*)phone
{
    NSString* originalUrl = [NSString stringWithFormat:@"%@/api/mobilecode?mobile=%@&token=62D9A5A6DBA282B695A1E9DB51F80E7A",sg_privateNetworkBaseUrl,phone];
    return originalUrl;
}

/**
 *  得到含有加密token的urlStr
 *
 *  @return urlStr
 */
-(NSString*)getUrlStrForCheckCode:(NSString*)phoneNum andCode:(NSString*)code
{
    NSString* originalUrl = [NSString stringWithFormat:@"%@/api/forgetsave?mobile=%@&repass=%@&mobilecode=%@",sg_privateNetworkBaseUrl,phoneNum,self.passwd.text,self.checkNum.text];
    return originalUrl;
}

/**
 *  得到含有加密token的urlStr
 *
 *  @return urlStr
 */
-(NSString*)getUrlStrForReister:(NSString*)phoneNum andCode:(NSString*)code andPasswd:(NSString*)passwd
{
        //1.加入时间标签
    NSDate* date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970];

    NSString* originalUrl = [NSString stringWithFormat:@"%@?code=%@&e=%.0f&method=password-edit&mobile=%@&password=%@&type=1",REQUEST_URL,code,interval,phoneNum,passwd];
        //2.调用工具类，得到最终的URL
//    NSString* finalUrl = [QTRequestTools getSignedUrl:originalUrl];


    return originalUrl;
    
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}
@end
