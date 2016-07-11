//
//  ServiceExampleViewController.m
//  ZhuRenWong
//
//  Created by Colin on 16/2/23.
//  Copyright © 2016年 qitian. All rights reserved.
//

#import "ServiceExampleViewController.h"
#import "QTUMShareTool.h"
@interface ServiceExampleViewController ()<UIWebViewDelegate>{
    UIWebView *webView;
    
    
}

@end

@implementation ServiceExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _titleStr;
    
//    [self setShareButton];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
    //    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://8235.wx.cdn.aodianyun.com/layout/party/4532"]];
    
    NSString *allUrl =[NSString stringWithFormat:@"%@%@",sg_privateNetworkBaseUrl,_urlStr];
    ECLog(@"控制器地址,无前缀的是广告%@, 短%@",allUrl,_urlStr);
    allUrl =  (_type == TypeKindAdd)?_urlStr:allUrl;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:allUrl]];
    webView.delegate = self;
    [self.view addSubview: webView];
    [webView loadRequest:request];

    // Do any additional setup after loading the view.
}

- (void)shareButtonClicked{
    [self shareApplication];
}
- (void)shareApplication{
    NSString *invite_code =  standardUserForKey(@"invite_code");
    NSString *shareContendHasInviteCode = nil;
    if(self.type == zeroArt){
    shareContendHasInviteCode = [NSString stringWithFormat:@"主人翁APP里的这篇文章不错"];
    }else{
//        shareContendHasInviteCode = shareContend;
    }

    
    //1.定制分享的内容
    
    [QTUMShareTool shareWithTitle:shareTitleDownload  //shareTitleHasCode
                          contend:shareContendHasInviteCode
                           urlStr:shareurlStr
                          platArr:nil      //shareBtnOrder
                         delegate:self
                            image:nil]; //[UIImage imageNamed:@"Icon-60"];
    
}
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    //    if ([platformName isEqualToString:@"wxtimeline"]) {
    //        _isChooseWxCircle = YES;
    //    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //        if (_isChooseWxCircle) {//如果是朋友圈,调分享app到朋友圈
        //            [QTRequestTools addIntegralWithValue:addIntegerShareAppToCircle typeId:nil];
        //            _isChooseWxCircle = NO;
        //        }else{
        //调用积分 添加积分
        //        }
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


//网页开始加载的时候调用
- (void )webViewDidStartLoad:(UIWebView  *)webView{
    
//    [MBProgressHUD showMessage:loadingNetWorkStr toView:self.view];
}
//网页加载完成的时候调用
- (void )webViewDidFinishLoad:(UIWebView  *)webView{
     [MBProgressHUD hideHUDForView:self.view];
}
//网页加载错误的时候调用
- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
