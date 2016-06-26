//
//  WSContentController.m
//  网易新闻
//
//  Created by WackoSix on 15/12/30.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSContentController.h"
#import "WSGetDataTool.h"
#import "WSContent.h"
#import "WSCommentController.h"
#import "MBProgressHUD.h"
#import "XFZCustomKeyBoard.h"
#import "WSNewsAllModel.h"
#import "WSTopicContentListModel.h"
#import "QTUMShareTool.h"
#import "UIImageView+WebCache.h"
#import "UMSocialControllerService.h"
#import "NSArray+Extensions.h"
#import "QTLoginViewController.h"
@interface WSContentController ()<UIWebViewDelegate,UMSocialUIDelegate,XFZCustomKeyBoardDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;

@property (strong, nonatomic) WSContent *content;
@property (weak, nonatomic) IBOutlet UIButton *bottomCommentBtn;
@property (weak, nonatomic) IBOutlet UIButton *writeBtn;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (nonatomic, strong) XFZCustomKeyBoard *cuskeyBoard;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLable;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;

@property (weak, nonatomic) IBOutlet UILabel *commmentLable;
@end

@implementation WSContentController

- (void)setNewsItem:(id)newsItem{
    _newsItem = newsItem;
}


- (IBAction)praiseBtnClicked:(UIButton *)sender {
    NSString *docid = nil;
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Infoid];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Infoid];
    }
    if (_praiseBtn.selected) {
        [MBProgressHUD showError:@"已经点赞"];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"api/newsgoodsave?infoid=%@",docid];
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        if (![json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        NSDictionary *dic = (NSDictionary*)json;
        BOOL success = (BOOL)[dic[@"Success"] boolValue];
        NSString *Msg = dic[@"Msg"];
        if (!success) {return;}
        _praiseBtn.selected = YES;
//        _praiseBtn.enabled = NO;
        [MBProgressHUD showSuccess:Msg];
    }  failur:^(NSError *error) {
    }];

}

- (IBAction)writeCommentBtnClicked:(UIButton *)sender {
    NSString *passW =[QTUserInfo sharedQTUserInfo].passWD;
    if (!strNotNil(passW)) {//密码不存在 存在 退出了 存在本地
        [self showHint:@"登录才能评论"];
        [self gotoLoginVc];
        return;
    }
    if (_bottomCommentBtn.selected) {
        [MBProgressHUD showError:@"已经评论"];
        return;
    }
    [[XFZCustomKeyBoard customKeyBoard]textViewShowView:self delegate:self];

    XFZCustomKeyBoard *cus =  [XFZCustomKeyBoard customKeyBoard];
    
    [self setHide:NO];

    [cus.contentTextView becomeFirstResponder];
    
}
- (void)sendButtonClick:(XFZCustomKeyBoard*)keyBoard{
    
    NSLog(@"%@",keyBoard.contentTextView.text);
        [keyBoard textDidChanged:nil];
    [keyBoard.contentTextView resignFirstResponder];
    [self loadDataComment: keyBoard.contentTextView.text];
    keyBoard.contentTextView.text = @"";

}

- (void)gotoLoginVc{
    
    ECLog(@"点击用户头像");
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    QTLoginViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"登录";
//    [vc loginSuccessBlock:^(NSDictionary *dic) {
//        NSString *phone =[QTUserInfo sharedQTUserInfo].phoneNum;
//        [_loginBtn setTitle:phone forState:UIControlStateNormal];
//        [MBProgressHUD showSuccess:@"登录成功"];
//    }];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)loadDataPinlunDianzan{
    
    NSString *docid = nil;
    NSString *partUrl = nil;
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"%@%@",@"newsid=",docid];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"%@%@",@"ztnewsid=",docid];
    }

    NSString *url = [NSString stringWithFormat:@"api/pinglun?%@",partUrl];
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        if (![json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        NSDictionary *dic = (NSDictionary*)json;
        _dic = dic;
        
        NSString *Mvc_pingTotal = [QTCommonTools nsnumberToStr:_dic[@"Mvc_pingTotal"]];
        
        NSString *IsShare = [QTCommonTools nsnumberToStr:_dic[@"IsShare"]];
        _shareBtn.hidden = ![IsShare isEqualToString:@"1"];
        if([Mvc_pingTotal intValue]>0){
            _commentNumLable.text = Mvc_pingTotal;
        }
        NSString *Goods = [QTCommonTools nsnumberToStr:_dic[@"Goods"]];
        if( [Goods intValue] > 0){
            self.commmentLable.text = Goods;
        }

    }  failur:^(NSError *error) {
        
    }];

    
    
}

- (void)loadDataComment:(NSString*)content{
    NSString *userid =[QTUserInfo sharedQTUserInfo].userId;
    NSString *partUrl = nil;
    NSString *docid = nil;
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"%@%@",@"newsid=",docid];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"%@%@",@"ztnewsid=",docid];
    }
    NSMutableDictionary *para = createMutDict;
    para[@"content"] = content;
    NSString *url = [NSString stringWithFormat:@"api/pinglunAdd?userid=%@&%@",userid,partUrl];
    [QTFHttpTool requestGETURL:url params:para refreshCach:YES needHud:YES hudView:self.view loadingHudText:nil errorHudText:nil sucess:^(id json) {
        if (![json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        NSDictionary *dic = (NSDictionary*)json;
        BOOL success = (BOOL)[dic[@"Success"] boolValue];
        NSString *Msg = dic[@"Msg"];
        if (!success) {return;}
        _bottomCommentBtn.selected = YES;
        [MBProgressHUD showSuccess:Msg];
    }  failur:^(NSError *error) {
        
    }];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
   self.title = @"新闻内容";
    
    self.webView.delegate = self;
    
//    [self.webView loadHTMLString:@"<html><body bgcolor=\"#F9F6FA\"></body></html>" baseURL:nil];
//    NSString *newsLink = nil;
//    if ([_newsItem isKindOfClass:[Newslist class]]) {
//        Newslist *news = (Newslist*)_newsItem;
//        newsLink = news.Newslink;
//    }else{
//        ZtNewslist *news = (ZtNewslist*)_newsItem;
//        newsLink = news.Newslink;
//    }
    NSString *docid = nil;
    NSString *partUrl = nil;
    _shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _shareImage.hidden = YES;
    [self.view addSubview:_shareImage];

    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"/s/news_article/%@",docid];
    [_shareImage sd_setImageWithURL:[NSURL URLWithString:news.Picsmall] placeholderImage:[UIImage imageNamed:@"logo108"]];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"/s/ztnews_article/%@",docid];
    [_shareImage sd_setImageWithURL:[NSURL URLWithString:news.Picsmall] placeholderImage:[UIImage imageNamed:@"logo108"]];

    }
    NSString *url = [NSString stringWithFormat:@"%@%@",sg_privateNetworkBaseUrl,partUrl];
    ECLog(@"加载的网址%@",url);
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
    
//    [MBProgressHUD showHUDAddedTo:self.webView animated:YES];
    
//    [self loadData];
    [_collectionBtn addTarget:self action:@selector(collectionViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    _writeBtn.hidden = NO;
    self.bottomView.hidden = NO;
    self.shareBtn.hidden = YES;
    
    
    
    
}

- (void)loadData {
    
    typeof(self) __weak weakSelf = self;
    NSString *docid = nil;
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
    }
    [WSContent contentWithNewsID:docid getDataSucces:^(WSContent *content) {
        
        weakSelf.content = content;
        
    } getDataFailure:^(NSError *error) {
        
        NSLog(@"加载失败%@",error);
        [MBProgressHUD hideHUDForView:self.webView animated:YES];
        
    }];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *urlStr = request.URL.absoluteString;
    
    if ([urlStr containsString:@"imgsrc"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否保存图片？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *save = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }];
        [alert addAction:cancel];
        [alert addAction:save];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.webView animated:YES];

    [self loadDataPinlunDianzan];
}

- (void)setContent:(WSContent *)content{
    
    _content = content;
    
    NSString *count = (content.replyCount <= 9999) ? [NSString stringWithFormat:@"%ld跟帖",content.replyCount] : [NSString stringWithFormat:@"%.1f万跟帖",(float)content.replyCount / 10000];
    
//    [self.shareBtn setTitle:count forState:UIControlStateNormal];/
    [self.bottomCommentBtn setTitle:[NSString stringWithFormat:@"%ld",content.replyCount] forState:UIControlStateNormal];
    
    [self setDataWithContent:content];
}

- (void)setDataWithContent:(WSContent *)content{
    
    //拼接html文档
    NSMutableString *htmlStr = [NSMutableString stringWithFormat:@"<body bgcolor=\"#F9F6FA\" style=\"font-size:17px;\"><h2>%@</h2><p  style=\"color:#008B8B;font-size:13px;\">%@ %@</p> %@ </body>",_content.title,_content.ptime,_content.source,_content.body];
    
    CGFloat width = _webView.bounds.size.width - 16;
    
    //设置图片
    NSString *imageOnload = @"this.onclick = function() {window.location.href = 'sx:imgsrc=' +this.src;};";
    for (NSDictionary *dict in _content.img) {
        
        NSString *imgSize = dict[@"pixel"];
        CGFloat imgWidth = [imgSize substringToIndex:[imgSize rangeOfString:@"*"].location].floatValue;
        CGFloat imgHeight = [imgSize substringFromIndex:[imgSize rangeOfString:@"*"].location + 1].floatValue;
        
        [htmlStr replaceOccurrencesOfString:dict[@"ref"] withString:[NSString stringWithFormat:@"<img onload=\"%@\" src=\"%@\" width=\"%f\" height=\"%f\"/>",imageOnload ,dict[@"src"], width, imgHeight/imgWidth * width] options:0 range:NSMakeRange(0, [htmlStr length])];
    }
    
    //设置视频
    //            <video width="320" height="240" controls="controls">
    //            <source src="movie.mp4" type="video/mp4" />
    //            </video>
    
    NSString *videoOnload = @"this.onclick = function() {window.location.href = 'sx:videosrc=' +this.src;};";
    for (NSDictionary *dict in _content.video) {
        
        [htmlStr replaceOccurrencesOfString:dict[@"ref"] withString:[NSString stringWithFormat:@"<video onload=\"%@\" width=\"%f\" height=\"200\" poster=\"%@\"><source src=\"%@\"></video>",videoOnload ,width,dict[@"cover"],dict[@"url_mp4"]] options:0 range:NSMakeRange(0, [htmlStr length])];
        
    }
    
    
    [_webView loadHTMLString:htmlStr baseURL:nil];
    self.bottomView.hidden = NO;
    self.shareBtn.hidden = NO;
    [MBProgressHUD hideHUDForView:self.webView animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)backItem {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)shareBtnClicked:(UIButton *)sender {
    NSString *title = nil;
    NSString *content = nil;
    NSString *urlClick = nil;
    UIImage* image =  self.shareImage.image;
    [self setHide:YES];
    [[XFZCustomKeyBoard customKeyBoard]textViewShowView:nil delegate:nil];

    
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        title  = news.Title;
        content = news.Descriptions;
        urlClick = [NSString stringWithFormat:@"%@/s/news_article/%ld",sg_privateNetworkBaseUrl,news.Id];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        title  = news.Title;
        content = news.HomeTitle;
        urlClick = [NSString stringWithFormat:@"%@/s/ztnews_article/%ld",sg_privateNetworkBaseUrl,news.Id];
    }
    [QTUMShareTool shareWithTitle:title  //
                          contend:content
                           urlStr:urlClick
                          platArr:nil
                         delegate:self
                            image:image];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    ECLog(@"分享完成");
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        
    }
}




- (void)setHide:(BOOL)hide{
    [XFZCustomKeyBoard customKeyBoard].backView.hidden = hide;
    [XFZCustomKeyBoard customKeyBoard].cancelButton.hidden = hide;
    [XFZCustomKeyBoard customKeyBoard].sendButton.hidden = hide;
}

- (IBAction)commentBtn { //这里修改为分享
    
    WSCommentController *vc = [[WSCommentController alloc] init];
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        vc.item = news;
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        vc.item = news;
    }
    //hideBottomBar
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionViewClicked:(UIButton*)sender{
    NSString *userid =[QTUserInfo sharedQTUserInfo].userId;
    NSString *passW =[QTUserInfo sharedQTUserInfo].passWD;
    if (!strNotNil(passW)) {//密码不存在 存在 退出了 存在本地
        [self showHint:@"登录才能收藏"];
        [self gotoLoginVc];
        return;
    }
    if (_collectionBtn.selected) {
        [MBProgressHUD showError:@"已经收藏"];
        return;
    }
    NSString *partUrl = nil;
    NSString *docid = nil;
    if ([_newsItem isKindOfClass:[Newslist class]]) {
        Newslist *news = (Newslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"%@%@",@"newsid=",docid];
    }else{
        ZtNewslist *news = (ZtNewslist*)_newsItem;
        docid = [NSString convertIntgerToString:news.Id];
        partUrl = [NSString stringWithFormat:@"%@%@",@"ztnewsid=",docid];
    }
    NSString *url = [NSString stringWithFormat:@"api/newsshoucangadd?userid=%@&%@",userid,partUrl];
    [QTFHttpTool requestGETURL:url params:nil refreshCach:YES needHud:YES hudView:self.view loadingHudText:@"收藏中..." errorHudText:nil sucess:^(id json) {
        if (![json isKindOfClass:[NSDictionary class]]) {
            return ;
        }
        NSDictionary *dic = (NSDictionary*)json;
        BOOL success = (BOOL)[dic[@"Success"] boolValue];
        NSString *Msg = dic[@"Msg"];
        if (!success) {return;}
        _collectionBtn.selected = YES;
//        _collectionBtn.enabled = NO;
        //收藏成功
        [NSArray writetargetStr:url ToFilePath:@"collection"];
        [MBProgressHUD showSuccess:Msg];
    } failur:^(NSError *error) { }];
}

- (void)refreshState{
    
    
}


#pragma mark - init

+ (instancetype)contentControllerWithItem:(id)newsItem{
    
    id obj = [[self alloc] init];
    
    [obj setNewsItem:newsItem];
    
    return obj;
}



@end
