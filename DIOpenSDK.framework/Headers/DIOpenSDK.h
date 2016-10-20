//
//  DIOpenSDK.h
//  DIOpenSDK
//
//  Created by gr4yk3r on 15/10/13.
//  Copyright © 2015年 com.xiaojukeji.didiOpenSdk. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <DIOpenSDK/DIOpenSDKRegisterOptions.h>
#import <DIOpenSDK/DITopNavigationTheme.h>
#import <DIOpenSDK/DIBaseModel.h>

@protocol DIOpenSDKDelegate <NSObject>

@optional
// 打车页面关闭回调
- (void)pageClose __deprecated_msg("旧回调接口，请用diopensdkMainPageClose接口替代");

- (void)diopensdkMainPageClose;

- (DITopNavigationTheme *)diopensdkTopNavigationTheme;

@end

@interface DIOpenSDK : NSObject

/**
 *  注册app
 *
 *  @param appId  开发者网站申请的appid
 *  @param secret 开发者网站申请的secret
 */
+ (void)registerApp:(NSString *)appId
             secret:(NSString *)secret;

/**
 *  通过该方法调起滴滴页面
 *
 *  @param parentController 展现滴滴页面的ViewController
 *  @param animated         展现滴滴页面时是否需要动画
 *  @param optionParams     可选参数
 *  @param delegate         代理
 */
+ (void)showDDPage:(UIViewController *)parentController
          animated:(BOOL)animated
          params:(DIOpenSDKRegisterOptions *)optionParams
          delegate:(id<DIOpenSDKDelegate>)delegate;

/**
 *  拨打手机号码
 *
 *  @param phone  手机号码加密字符串
 *  @param prompt 拨打电话是否弹出提示
 *  @param error  错误信息
 */
+ (void)callPhone:(NSString *)phone
           prompt:(BOOL)prompt
            error:(NSError *__autoreleasing *)error;

/**
 *  异步获取ticket
 *
 *  @param ticketType  ticketType分为single和long两种，single类型每次请求完就失效，long类型有一定失效周期。
 *  @param resultBlock 结果回调
 */
+ (void)asyncGetTicket:(NSString *)ticketType
           resultBlock:(void (^)(NSError *error,DIBaseModel *model))resultBlock;

/**
 *  同步获取ticket
 *
 *  @param ticketType  ticketType分为single和long两种，single类型每次请求完就失效，long类型有一定失效周期。
 *  @param resultError 错误信息
 *
 *  @return 返回结果数据
 */
+ (DIBaseModel *)syncGetTicket:(NSString *)ticketType
                         error:(NSError *__autoreleasing *)resultError;

/**
 *  打开制定页面
 *
 *  @param pageName    页面名称
 *  @param params      所需参数信息
 *  @param navTheme    页面导航栏定制
 *  @param resultBlock 结果回调,回调中返回页面的viewController
 */
+ (void)openPage:(NSString *)pageName
          params:(NSDictionary *)params
        navTheme:(DITopNavigationTheme *)navTheme
     resultBlock:(void (^)(NSError *error,UIViewController *viewController))resultBlock;

/**
 *  异步请求开放API接口
 *
 *  @param apiName     API名称
 *  @param dict        API所需参数
 *  @param resultBlock 结果回调
 */
+ (void)asyncCallOpenAPI:(NSString *)apiName
                     params:(NSDictionary *)dict
                resultBlock:(void (^)(NSError *error,DIBaseModel *model))resultBlock;

/**
 *  同步请求开放API接口
 *
 *  @param apiName     API名称
 *  @param dict        API所需参数
 *  @param resultError 错误信息
 *
 *  @return 返回结果数据
 */
+ (DIBaseModel *)syncCallOpenAPI:(NSString *)apiName
                             params:(NSDictionary *)dict
                              error:(NSError *__autoreleasing *)resultError;

/**
 *  检查打车主页是否登陆
 *
 *  @return 已登录返回YES,未登录返回NO
 */
- (BOOL)checkLogin;

@end
