//
//  QTUMShareTool.m
//  ZhuRenWong
//
//  Created by HLH on 15/12/10.
//  Copyright © 2015年 qitian. All rights reserved.
//

#import "QTUMShareTool.h"
#import "UMSocial.h"
#define shareTitleHasCode [NSString  stringWithFormat:@"%@%@",@"【北仑新区时刊】",@""]
#define shareBtnOrder        [NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToSina,UMShareToSms,nil]
#define shareurlStr  @"http://a.app.qq.com/o/simple.jsp?pkgname=com.qitian.massage"

@implementation QTUMShareTool
+ (void)shareWithTitle:(NSString*)title
               contend:(NSString*)content
                urlStr:(NSString*)urlStr
               platArr:(NSArray*)platArr
              delegate:(id)delegate
                 image:(UIImage*)image {
    if(!title) title = shareTitleHasCode;
    if(!image) image = [UIImage imageNamed:@"logo108"];
    if(!platArr) platArr = shareBtnOrder;
    if(!urlStr) urlStr = shareurlStr;
    if (!content) {
        content = @"";
    }
    //  微信好友内容
    [UMSocialData defaultData].extConfig.wechatSessionData.url = urlStr;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
    [UMSocialData defaultData].extConfig.wechatSessionData.shareText = content;
    //图片没有则没有链接
    [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = image;
   
    // 如果是朋友圈，则替换平台参数名即可 朋友圈调换title 和content
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;//shareTitleHasCode;//@"【北仑新区时刊】";
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = image;
    
    //qq
    [UMSocialData defaultData].extConfig.qqData.url = urlStr;
    [UMSocialData defaultData].extConfig.qqData.title = title;
    [UMSocialData defaultData].extConfig.qqData.shareText = content;
    [UMSocialData defaultData].extConfig.qqData.shareImage = image;
    
    //qZone
    [UMSocialData defaultData].extConfig.qzoneData.url = urlStr;
    [UMSocialData defaultData].extConfig.qzoneData.title = title;
    [UMSocialData defaultData].extConfig.qzoneData.shareText = @"";
    [UMSocialData defaultData].extConfig.qzoneData.shareImage = image;
    
    
#pragma mark - 12.8
    [UMSocialControllerService defaultControllerService].socialUIDelegate = delegate;
#pragma mark - -----
    
    
    if([urlStr isEqualToString:shareurlStr]){
        //只要是下载并且分享到微博 就提示在浏览器中打开
        platArr = shareBtnOrder;
        content = [NSString stringWithFormat:@"%@,链接请在浏览器中打开",content];
    }
    [UMSocialSnsService presentSnsIconSheetView:delegate
                                         appKey:UmengAppkey
                                      shareText:[NSString stringWithFormat:@"%@%@%@",title,content,urlStr]
                                     shareImage:image
                                shareToSnsNames:platArr
                                       delegate:delegate];
    
}


+ (void)shareToOnePlatTitle:(NSString*)title
                    contend:(NSString*)content
                     urlStr:(NSString*)urlStr
                   platName:(NSString*)platName
                   delegate:(id)delegate
                      image:(UIImage*)image
                     result:(QTShareResult)result{
    if(!title) title = shareTitleHasCode;
    if(!image) image = [UIImage imageNamed:@"Icon-60"];
    if(!urlStr) urlStr = shareurlStr;
    if(!platName) platName = @"wxtimeline";
    
   //@"wxtimeline" 微信的
    UMSocialUrlResource *urlResourc = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:urlStr];
    // 如果是朋友圈，则替换平台参数名即可 朋友圈调换title 和content
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urlStr;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;//shareTitleHasCode;//@"【北仑新区时刊】";
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareText = content;
    //图片没有则没有链接
    [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = image;
    [UMSocialControllerService defaultControllerService].socialUIDelegate = delegate;
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[platName] content:content image:image location:nil urlResource:urlResourc presentedController:delegate completion:^(UMSocialResponseEntity * response){
        if (result) {
            result(response);
        }
    }];
    
}



@end
