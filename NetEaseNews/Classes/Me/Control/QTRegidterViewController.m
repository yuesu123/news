//
//  QTRegidterViewController.m
//  ZhuRenWong
//
//  Created by wangfeng on 15-4-23.
//  Copyright (c) 2015年 qitian. All rights reserved.
//
//#define CHECKPHONE_URL @"http://api.zrwjk.cytong.cn/api?method=reg-sms-code"
//#define CHECKPHONE_URL_CHECK @"http://api.zrwjk.cytong.cn/api?method=sms-code-check"
//#define REGISTER @"http://api.zrwjk.cytong.cn/api?method=password-edit"



//#define CHECKPHONE_URL @"http://192.168.0.106:80/api?method=reg-sms-code"
//#define CHECKPHONE_URL_CHECK @"http://192.168.0.106:80/api?method=sms-code-check"
//#define REGISTER @"http://192.168.0.106:80/api?method=password-edit"



#import "QTRegidterViewController.h"
#import "UIButton+WF.h"
#import "UITextField+WF.h"
#import "QTLoginViewController.h"
#import "QTCommonTools.h"
#import "ServiceExampleViewController.h"
@interface QTRegidterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *checkNum;
@property (weak, nonatomic) IBOutlet UITextField *passwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswd;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *itemBtn;
@property (nonatomic, copy  ) NSString   *url;
@end

@implementation QTRegidterViewController

NSInteger _count;
NSTimer* _countTimer;
BOOL _sendCheckCode;
BOOL _codeRight;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.passwd.delegate = self;
    self.confirmPasswd.delegate = self;
    self.checkBtn.enabled = YES;
    self.selectBtn.selected = YES;

        //设置控件的显示属性

//    [self.checkBtn setResizeN_BG:@"btn_normal" H_BG:@"btn_HL"];
//    [self.registerBtn setResizeN_BG:@"btn_normal" H_BG:@"btn_HL"];

    self.registerBtn.backgroundColor = BlueColorCommon;
    [QTCommonTools clipAllView:_registerBtn Radius:kclipCornerSmall borderWidth:0 borderColor:nil];
    self.checkBtn.backgroundColor = BlueColorCommon;
    [QTCommonTools clipAllView:_checkBtn Radius:kclipCornerSmall borderWidth:0 borderColor:nil];
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
    
    [[QTCommonTools sharedQTCommonTools] addTextfeildLeftView:self.phoneNum image:[UIImage imageNamed:@"smallImage_phone"]];
    [[QTCommonTools sharedQTCommonTools] addTextfeildLeftView:self.passwd image:[UIImage imageNamed:@"smallImage_password"]];
    [[QTCommonTools sharedQTCommonTools] addTextfeildLeftView:self.checkNum image:[UIImage imageNamed:@"smallImage_checkCode"]];
    [[QTCommonTools sharedQTCommonTools] addTextfeildLeftView:self.confirmPasswd image:[UIImage imageNamed:@"smallImage_username"]];







}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    
    
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    if(Main_Screen_Height<=568){
//        [UIView animateWithDuration:0.25 animations:^{
//            if (self.view.top<80) { //这个地方是64
//                self.view.top -= 120;
//                //这个地方是  -56
//            }
//            
//        }];
//    }


    
    
}


- (void)textFieldDidEndEditing:(UITextView *)textView {
  
//    if(Main_Screen_Height<=568){
//        [UIView animateWithDuration:0.25 animations:^{
//            if (self.view.top<=-56) {//顶上去-56 归位是64
//                self.view.top += 120;
//            }
//            
//        }];
//    }


    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneNum resignFirstResponder];
    [self.passwd resignFirstResponder];
    [self.checkNum resignFirstResponder];
    [self.confirmPasswd resignFirstResponder];
}
    //获取验证码按钮

- (IBAction)checkClick:(id)sender {

    NSString* phone = self.phoneNum.text;

        //0.判断是否输入正确手机号
    if(!phone ||[phone isEqualToString:@""]){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入手机号"];
        return;

    }
    if (![self.phoneNum isTelphoneNum]) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入正确的手机号"];
        return;

    }


        //1.设置timer倒计时
    _count = 60;
    _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setSecond) userInfo:@"countTimer" repeats:YES];
        [self.checkBtn setTitle:@"60秒" forState:UIControlStateNormal];

        //2.发送请求
    [self loadDataCheckCode];


}
-(void)setSecond
{
        //ECLog(@"计时");
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

- (IBAction)registerClick:(id)sender {
    if (!_phoneNum.text || _phoneNum.text.length == 0) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入您的手机号！"];
    } else if (_phoneNum.text.length!=11) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入正确的手机号码！"];
    }else if(!self.passwd.text ||[self.passwd.text isEqualToString:@""]){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入密码!"];
    }else if(self.passwd.text.length>15){
        [[QTCommonTools sharedQTCommonTools] showAlert:@"密码不要超过15位!"];
    }else if (!_checkNum.text || _checkNum.text.length == 0) {
        [[QTCommonTools sharedQTCommonTools] showAlert:@"请输入验证码!"];
    }else if(!self.selectBtn.selected){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请同意注册协议" message:@"请勾选灰色小方框同意注册协议,点击\"我同意..\"可查看协议" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alertView show];
    }else{
        [self loadDataCommitRegedit];
    }
}

#pragma mark 选择哪一个alertView
- (void)alertView:(UIAlertView *)sender didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self requestCheckCode:self.phoneNum.text andCode:self.checkNum.text];
    }
    
}





-(void)viewWillDisappear:(BOOL)animated
{
    [_countTimer invalidate];
    [super viewWillDisappear:animated];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return  YES;
}

#pragma mark 网络访问，放在这里便于获取结果
    //发送验证码
-(void)requestCheckNumForNum:(NSString*)phoneNum
{

//    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[self getUrlStrForSendCode:phoneNum]]];
//
//
//        //避免循环引用
//    __weak typeof (request) w_requset = request;
//
//    [request setCompletionBlock:^{
//
//            //1.得到响应，转化为字典，
//        NSData* response = [ w_requset responseData];
//
//        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//            ECLog(@"验证码信息：%@",dict);
//       BOOL success = [dict[@"success"] boolValue];
//            //是否发送了验证码，记录下来
//        _sendCheckCode = success;
//
//         ECLog(@"发送了验证码：%d",success);
//
//        if(!success){
//
//            [MBProgressHUD showError:dict[@"msg"]];
//            [_countTimer invalidate];
//            self.checkBtn.enabled = YES;
//            [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//
//        }
//
//
//    }];
//    [request setFailedBlock:^{
//
//        _sendCheckCode = NO;
//        [MBProgressHUD showError:@"网络连接失败"];
//        [_countTimer invalidate];
//        self.checkBtn.enabled = YES;
//        [self.checkBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//
//
//        ECLog(@"发送验证码请求失败");
//
//
//    }];
//
//    [request setTimeOutSeconds:10];
//    [request startAsynchronous];
    
    
}

    //验证验证码
-(void)requestCheckCode:(NSString*)phoneNum andCode:(NSString*)code
{

//     [MBProgressHUD showMessage:nil toView:self.view];
//
//
//    NSURL* URL = [NSURL URLWithString:[self getUrlStrForCheckCode:phoneNum andCode:code]];
//    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:URL];
//
//
//        //避免循环引用
//    __weak typeof (request) w_requset = request;
//
//    [request setCompletionBlock:^{
//
//            //1.得到响应，转化为字典，
//        NSData* response = [ w_requset responseData];
//
//        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
//        ECLog(@"%@",dict);
//
//        BOOL success = [dict[@"success"] boolValue];
//
//        if (!success) {
//            [MBProgressHUD hideHUDForView:self.view];
//            [[QTCommonTools sharedQTCommonTools] showAlert:@"验证码不正确"];
//            return;
//        }
//
//         [self registerWith:self.phoneNum.text andCode:self.checkNum.text andPasswd:self.passwd.text invite_code:self.confirmPasswd.text];
//
//    }];
//    [request setFailedBlock:^{
//        [MBProgressHUD showError:@"网络连接失败"];
//
//        ECLog(@"验证验证码请求失败");
//
//        
//        
//    }];
//    
//    [request setTimeOutSeconds:10];
//    [request startAsynchronous];

}

    //设置处事密码，成功即注册成功
-(void)registerWith:(NSString*)phoneNum andCode:(NSString*)code andPasswd:(NSString*)passwd invite_code:(NSString*)invite_code
{

}

- (void)registSuccessToAutoLogin:(NSString*)phoneNum passwd:(NSString*)passwd{
//    //2.单例类记住信息
//    [QTUserInfo sharedQTUserInfo].phoneNum = phoneNum;
//    [QTUserInfo sharedQTUserInfo].passWD = passwd;
//    [QTUserInfo sharedQTUserInfo].type = @"0";
//    [self.view endEditing:YES];
//    [MBProgressHUD showMessage:@"成功注册,自动登陆中..." toView:self.view];
//    __weak typeof (self) w_self = self;
//
//     [[QTRequestTools sharedQTRequestTools]loginWithBlock:^(Status status) {
//         switch (status) {
//             case LOGIN_SUCCESS:
//             {
//                 [MBProgressHUD hideHUDForView:w_self.view];
//                 ECLog(@"登录成功");
//                 //进入主页;
//                 [self enter];
//                 //去环信登录
//                 [[QTLoginViewController  sharedQTLoginViewController] gotoLoginFirst:[QTUserInfo sharedQTUserInfo].phoneNum andPassWord:[QTUserInfo sharedQTUserInfo].passWD];
//                 //3.展示登录成功页面,发送一个通知
//                 
//                 [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
//                 break;
//             }
//             case LOGIN_FAILURE:{
//                 [MBProgressHUD hideHUDForView:w_self.view];
//                 
//                 ECLog(@"登录失败");
//                 [MBProgressHUD showError:@"用户名或者密码不正确"];
//             }
//                 break;
//             case
//             LOGIN_UNKNOW_ERROR:{
//                 [MBProgressHUD hideHUDForView:w_self.view];
//                 ECLog(@"出现网络连接错误");
//                 [MBProgressHUD showError:@"网络错误"];
//             }
//                 break;
//             default:
//                 [MBProgressHUD hideHUDForView:w_self.view];
//                 break;
//         }
//     }];
}

#pragma mark 网络-获取验证码
- (void)loadDataCheckCode{
    NSString *url = [NSString stringWithFormat:@"api/mobilecode?mobile=%@&token=62D9A5A6DBA282B695A1E9DB51F80E7A",self.phoneNum.text];
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            if (![json isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSDictionary *dic = (NSDictionary*)json;
            BOOL success = (BOOL)[dic[@"Success"] boolValue];
            NSString *Msg = dic[@"Msg"];
            if (success) {
                SHOW_ALERT(Msg);
            }else{
                SHOW_ALERT(Msg);
            }
        }
    } failur:^(NSError *error) { }];
}


#pragma mark 网络-获取验证码
- (void)loadDataCommitRegedit{
    
    NSString *url = [NSString stringWithFormat:@"api/regsave?mobile=%@&pass=%@&mobilecode=%@",self.phoneNum.text,self.passwd.text,self.checkNum.text];
    [QTFHttpTool requestPOSTURL:url paras:nil needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            if (![json isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSDictionary *dic = (NSDictionary*)json;
            BOOL success = (BOOL)[dic[@"Success"] boolValue];
            NSString *Msg = dic[@"Msg"];
            if (success) {
                SHOW_ALERT(@"恭喜你注册成功,请登录!");
                [QTUserInfo sharedQTUserInfo].phoneNum = self.phoneNum.text;
                [QTUserInfo sharedQTUserInfo].passWD = self.passwd.text;
                [[QTUserInfo sharedQTUserInfo] writeUserInfoToDefault];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    } failur:^(NSError *error) {
        
    }];
    
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







- (IBAction)selectClick:(id)sender{

    self.selectBtn.selected = ! self.selectBtn.selected;
}

- (IBAction)itemClick:(id)sender {
    [self gotoAboutPrivateZhenze];
}

//去天气webView控制器
- (void)gotoAboutPrivateZhenze{
    ServiceExampleViewController *vc = [[ServiceExampleViewController alloc] init];
    vc.titleStr = @"使用条款和免责声明";
    vc.urlStr = sg_privateAbouTPrivtazhence;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSString *)url{
    NSString *url = [NSString stringWithFormat:@"api/mobilecode?mobile=%@&token=62D9A5A6DBA282B695A1E9DB51F80E7A",self.phoneNum.text];
    return url;
}
@end
