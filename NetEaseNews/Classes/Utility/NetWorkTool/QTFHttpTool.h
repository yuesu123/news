/**
 *  封装的网络请求 支持ASI 和 最新的AFN
 */

#import <Foundation/Foundation.h>

typedef void (^WBHttpToolSucessIdType)(id json);

typedef void (^WBHttpToolSucess)(NSDictionary * json);
typedef void (^WBHttpToolFailur)(NSError *error);

@interface QTFHttpTool : NSObject


/**
 *  以前的方法不要删除也不要使用
 *
 */
+(void)requestWithMethod:(NSString *)method url:(NSString *)url parameters:(NSDictionary *)parameters sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur __deprecated_msg("Method deprecated. Use `requestPara:`");
/**
 *   ASI可能会有缺陷使用
 *   requestWithPostWithurlNew 推荐使用这个20151001
 */
+(void)requestWithMethodHasSecretNew:(NSString *)method url:(NSString *)url parameters:(NSMutableDictionary *)parameters sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur __deprecated_msg("Method deprecated. Use `requestPara:`");

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
+(void)requestWithPostCanuploadImageWithurl:(NSString *)urlstr parameters:(NSMutableDictionary *)parameters iamgeArr:(NSMutableArray*)imageArr  serverParArr:(NSMutableArray*)serverParArr iamgeNameArr:(NSMutableArray*)imagenameArr compressRate:(float)rate sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur ;

/**  //最新的网络函数
 *  @param urlstr       传入的urlStr
 *  @param parameters   上传的参数
 *  @param sucess       成功
 *  @param failur       失败
 */
+(void)requestWithPostWithurlNew:(NSString *)urlstr parameters:(NSMutableDictionary *)parameters  sucess:(WBHttpToolSucess)sucess failur:(WBHttpToolFailur)failur  __deprecated_msg("Method deprecated. Use `requestPara:`");

/**
 *  请求1218  底层添加 POST 以前的接口在用
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
                  failur:(WBHttpToolFailur)failur;





/**
 *  53BK   GET请求 返回的是id 类型 可能是字典也可能是数组
 *
 *  @param url            url :不包含http://app.53bk.com/
 *  @param parameters     传入的参数
 *  @param needHud        是否需要hud
 *  @param hudView        在那个页面hud
 *  @param loadingHudText hud 的提示   有hud 传nil 使用默认
 *  @param errorHudText   hud 的错误提示 有hud 传nil 使用后台返回
 *  @param sucess         成功回调
 *  @param failur         失败回调
 */
+(void)requestGETURL:(NSString*)url
              params:(NSMutableDictionary *)parameters
         refreshCach:(BOOL)refreshCach
           needHud:(BOOL)needHud
           hudView:(UIView*)hudView
    loadingHudText:(NSString*)loadingHudText
      errorHudText:(NSString*)errorHudText
            sucess:(WBHttpToolSucessIdType)sucess
            failur:(WBHttpToolFailur)failur;
/**
 *  53BK   POST请求 返回的是id 类型 可能是字典也可能是数组
 *
 *  @param url            url :不包含http://app.53bk.com/
 *  @param parameters     传入的参数
 *  @param needHud        是否需要hud
 *  @param hudView        在那个页面hud
 *  @param loadingHudText hud 的提示   有hud 传nil 使用默认
 *  @param errorHudText   hud 的错误提示 有hud 传nil 使用后台返回
 *  @param sucess         成功回调
 *  @param failur         失败回调
 */
+(void)requestPOSTURL:(NSString*)url
                paras:(NSMutableDictionary *)parameters
           needHud:(BOOL)needHud
           hudView:(UIView*)hudView
    loadingHudText:(NSString*)loadingHudText
      errorHudText:(NSString*)errorHudText
            sucess:(WBHttpToolSucessIdType)sucess
            failur:(WBHttpToolFailur)failur;




@end
