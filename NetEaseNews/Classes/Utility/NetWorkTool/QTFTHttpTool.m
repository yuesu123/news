
#import "QTFHttpTool.h"
#import "Reachability.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "VMacros.h"


@implementation QTFHttpTool

//ASI-post 请求

/**
 *  以前的方法不要删除也不要使用
 *
 */
+(void)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary *)parameters sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur
{
    NSMutableDictionary *para = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [self requestWithPostWithurlNewPrivate:url parameters:para sucess:^(NSDictionary *json) {
        if (sucess) {
            sucess(json);
        }
    } failur:^(NSError *error) {
        if (failur) {
            failur(error);
        }
        
    }];
}


/**  最新使用的
 *  @param urlstr       传入的urlStr
 *  @param parameters   上传的参数
 *  @param sucess       成功
 *  @param failur       失败
 */
+(void)requestWithPostWithurlNew:(NSString *)urlstr parameters:(NSMutableDictionary *)parameters  sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur
{
    [self requestWithPostWithurlNewPrivate:urlstr parameters:parameters sucess:^(NSDictionary *json) {
        if (sucess) {
            sucess(json);
        }
    } failur:^(NSError *error) {
        if (failur) {
            failur(error);
        }
    }];
}




/**
 *  请求1218  底层添加hud
 *
 *  @param parameters 请求的参数字典
 *  @param hudView        添加hud 的view    不需要hud的时候hudView和hudText一个传nil即可
 *  @param loadingHudText 添加hud的 文字     不需要hud的时候hudView和hudText一个传nil即可
 *  @param errorHudText   失败提示文字  一般都传nil
 *  @param sucess         成功
 *  @param failur         失败
 */
+(void)requestPara:(NSMutableDictionary *)parameters
           needHud:(BOOL)needHud
           hudView:(UIView*)hudView
    loadingHudText:(NSString*)loadingHudText
      errorHudText:(NSString*)errorHudText
            sucess:(WBHttpToolSucess)sucess
            failur:(WBHttpToolFailur)failur
{
    //是否显示hud
//    BOOL showHud = hudView&&strNotNil(loadingHudText);
    if(needHud){
        if(strNotNil(loadingHudText)){ //有就是用自己写的 没有就是用请稍候
            [MBProgressHUD showMessage:loadingHudText toView:hudView];
        }else{
            [MBProgressHUD showMessage:loadingNetWorkStr toView:hudView];
        }
    }
    [self requestWithPostWithurlNewPrivate:REQUEST_URL parameters:parameters sucess:^(NSDictionary *json) {
        if(needHud){
            [MBProgressHUD hideHUDForView:hudView];
        }
        if (sucess){  //成功
            sucess(json); //回调
            
            //不成功提示处理 
            BOOL success = (BOOL)[json[@"success"] boolValue];
            if (!success) {//如果响应出错，则返回
                NSString *errorAppendStr ;
                NSString *returnErrorStr = (NSString*)json[@"msg"];
                if(strNotNil(errorHudText)&&strNotNil(returnErrorStr)){//都存在 都显示
                    errorAppendStr = [NSString stringWithFormat:@"%@:%@",errorHudText,returnErrorStr];
                }else if(strNotNil(errorHudText)&&(!strNotNil(returnErrorStr))){//那个存在 显示那个
                    errorAppendStr = [NSString stringWithFormat:@"%@",errorHudText];
                }else if((!strNotNil(errorHudText))&&strNotNil(returnErrorStr)){//那个存在 显示那个
                    errorAppendStr = [NSString stringWithFormat:@"%@",returnErrorStr];
                }else{
                    errorAppendStr = nil;
                }
                if(errorAppendStr){
                    [MBProgressHUD showError:errorAppendStr]; //直接加在keywindown 上
                }
            }
            
            
        }
    } failur:^(NSError *error) { //失败
        if (failur) {
            if(needHud){
                [MBProgressHUD hideHUDForView:hudView];
            }
            [MBProgressHUD  showError:@"网络连接失败"]; //不管是否显示 都显示连接失败
            failur(error);
        }
    }];
}


/**
 *  上传图像
 *  @param urlstr       传入的urlStr
 *  @param parameters   图像之外的其他参数
 *  @param imageArr     图像数组,image
 *  @param serverParArr 服务器端的字段数组
 *  @param imagenameArr 图像的名字数组
 *  @param rate         压缩比例
 *  @param sucess       成功
 *  @param failur       失败
 */
+(void)requestWithPostCanuploadImageWithurl:(NSString *)urlstr parameters:(NSMutableDictionary *)parameters iamgeArr:(NSMutableArray*)imageArr  serverParArr:(NSMutableArray*)serverParArr iamgeNameArr:(NSMutableArray*)imagenameArr compressRate:(float)rate sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur
{

    //添加token操作
    NSDate* date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSString *intervalStr = [NSString stringWithFormat:@"%.0f",interval];
    NSString *paramStr = [NSString stringWithFormat:@"%@?e=%@",urlstr,intervalStr];
    [parameters setObject:intervalStr forKey:@"e"];
    
    //只是为来做标示用
    for(id key in parameters)
    {
        NSString *appendStr = [NSString stringWithFormat:@"&%@=%@",key,[parameters objectForKey:key]];
        paramStr = [paramStr stringByAppendingString:appendStr];
    }
    
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
     mgr.responseSerializer.acceptableContentTypes = [mgr.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];  //添加ContentType识别text/plain，
    
 AFHTTPRequestOperation *operation =   [mgr POST:urlstr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 上传的文件全部拼接到formData
        /**
         *  FileData:要上传的文件的二进制数据
         *  name:上传参数名称
         *  fileName：上传到服务器的文件名称
         *  mimeType：文件类型
         */
     for(int i = 0 ;i <imageArr.count;i++){
         UIImage *image = [imageArr objectAtIndex:i];
         [formData appendPartWithFileData:UIImageJPEGRepresentation(image, rate) name:[serverParArr objectAtIndex:i] fileName:[imagenameArr objectAtIndex:i] mimeType:@"image/jpeg"];
     }
     
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failur) {
            failur(error);
        }
    }];
    BOOL isHuitie =  ([paramStr rangeOfString:@"replies-add"].location !=NSNotFound);
    if(isHuitie){
    }else{
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            CGFloat percent = totalBytesWritten/(float)totalBytesExpectedToWrite;
            HYLog(@"上传进度...%f",percent);
            [SVProgressHUD showProgress:percent status:VString(@"正在上传...")];
        }];
        [operation start];
    }
}

/**
 *
 *  ASI
 *  @param method     GET 还是Post
 *  @param url        传入的urlStr
 *  @param parameters 参数 不需要时间
 *  @param sucess     成功
 *  @param failur     失败
 */
+(void)requestWithMethodHasSecretNew:(NSString *)method url:(NSString *)url parameters:(NSMutableDictionary *)parameters sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur
{
    [self requestWithPostWithurlNewPrivate:url parameters:parameters sucess:^(NSDictionary *json) {
        if (sucess) {
            sucess(json);
        }
    } failur:^(NSError *error) {
        if (failur) {
            failur(error);
        }
        
    }];

}




/**
 *  这个函数是请求的最底层函数
 *
 *  @param urlstr     请求的url
 *  @param parameters 请求的字典
 *  @param sucess     成功  返回字典
 *  @param failur     失败  error
 */
+ (void)requestWithPostWithurlNewPrivate:(NSString *)urlstr parameters:(NSMutableDictionary *)parameters  sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur{
    //添加token操作
    NSDate* date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSString *intervalStr = [NSString stringWithFormat:@"%.0f",interval];
    [parameters setObject:intervalStr forKey:@"e"];

    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failur) {
            failur(error);
        }
    }];
}


+(void)requestGETURL:(NSString*)url
              params:(NSMutableDictionary *)parameters
         refreshCach:(BOOL)refreshCach
             needHud:(BOOL)needHud
             hudView:(UIView*)hudView
      loadingHudText:(NSString*)loadingHudText
        errorHudText:(NSString*)errorHudText
              sucess:(WBHttpToolSucessIdType)sucess
              failur:(WBHttpToolFailur)failur;{
    if(needHud){
        if(strNotNil(loadingHudText)){ //有就是用自己写的 没有就是用请稍候
            [MBProgressHUD showMessage:loadingHudText toView:hudView];
        }else{
            [MBProgressHUD showMessage:loadingNetWorkStr toView:hudView];
        }
    }
    BOOL shouldrefresh = YES;
    if ([url containsString:@"newsshoucang"]) {
        shouldrefresh = YES;
    }
    
    [HYBNetworking getWithUrl:url refreshCache:refreshCach params:parameters success:^(id response) {
        if(needHud){
            [MBProgressHUD hideHUDForView:hudView];
        }
        if (sucess){  //成功
            sucess(response); //回调
            
            //不成功提示处理
            if (![response isKindOfClass:[NSDictionary class]]) {
                return ;
            }
            NSDictionary *json = (NSDictionary*)response;
            BOOL success = (BOOL)[json[@"Success"] boolValue];
            if (!success) {//如果响应出错，则返回
                NSString *errorAppendStr ;
                NSString *returnErrorStr = (NSString*)json[@"Msg"];
                if(strNotNil(errorHudText)&&strNotNil(returnErrorStr)){//都存在 都显示
                    errorAppendStr = [NSString stringWithFormat:@"%@:%@",errorHudText,returnErrorStr];
                }else if(strNotNil(errorHudText)&&(!strNotNil(returnErrorStr))){//那个存在 显示那个
                    errorAppendStr = [NSString stringWithFormat:@"%@",errorHudText];
                }else if((!strNotNil(errorHudText))&&strNotNil(returnErrorStr)){//那个存在 显示那个
                    errorAppendStr = [NSString stringWithFormat:@"%@",returnErrorStr];
                }else{
                    errorAppendStr = nil;
                }
                if(errorAppendStr){
                    [MBProgressHUD showError:errorAppendStr]; //直接加在keywindown 上
                }
            }
            
            
        }
    }fail:^(NSError *error) { //失败
        if (failur) {
            if(needHud){
                [MBProgressHUD hideHUDForView:hudView];
            }
            [MBProgressHUD  showError:@"网络连接失败"]; //不管是否显示 都显示连接失败
            failur(error);
        }
    }];
}

+(void)requestPOSTURL:(NSString*)url
                paras:(NSMutableDictionary *)parameters
              needHud:(BOOL)needHud
              hudView:(UIView*)hudView
       loadingHudText:(NSString*)loadingHudText
         errorHudText:(NSString*)errorHudText
               sucess:(WBHttpToolSucessIdType)sucess
               failur:(WBHttpToolFailur)failur{
    if(needHud){
        if(strNotNil(loadingHudText)){ //有就是用自己写的 没有就是用请稍候
            [MBProgressHUD showMessage:loadingHudText toView:hudView];
        }else{
            [MBProgressHUD showMessage:loadingNetWorkStr toView:hudView];
        }
    }
    
    [HYBNetworking postWithUrl:url refreshCache:YES params:parameters success:^(id response) {
        if(needHud){
            [MBProgressHUD hideHUDForView:hudView];
        }
        if (sucess){  //成功
            sucess(response); //回调  不是数组就不处理
            if(![response isKindOfClass:[NSDictionary class]]){
                return ;
            }
            NSDictionary *json = (NSDictionary*)response;
            //不成功提示处理
            BOOL success = (BOOL)[json[@"Success"] boolValue];
            if (!success) {//如果响应出错，则返回
                NSString *errorAppendStr ;
                NSString *returnErrorStr = (NSString*)json[@"Msg"];
                if(strNotNil(errorHudText)&&strNotNil(returnErrorStr)){//都存在 都显示
                    errorAppendStr = [NSString stringWithFormat:@"%@:%@",errorHudText,returnErrorStr];
                }else if(strNotNil(errorHudText)&&(!strNotNil(returnErrorStr))){//那个存在 显示那个
                    errorAppendStr = [NSString stringWithFormat:@"%@",errorHudText];
                }else if((!strNotNil(errorHudText))&&strNotNil(returnErrorStr)){//那个存在 显示那个
                    errorAppendStr = [NSString stringWithFormat:@"%@",returnErrorStr];
                }else{
                    errorAppendStr = nil;
                }
                if(errorAppendStr){
                    [MBProgressHUD showError:errorAppendStr]; //直接加在keywindown 上
                }
            }
            
            
        }
    } fail:^(NSError *error)  { //失败
        if (failur) {
            if(needHud){
                [MBProgressHUD hideHUDForView:hudView];
            }
            [MBProgressHUD  showError:@"网络不好,请检查网络!"]; //不管是否显示 都显示连接失败
            failur(error);
        }}];
    
}

@end
