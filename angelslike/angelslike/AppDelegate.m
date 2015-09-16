//
//  AppDelegate.m
//  angelslike
//
//  Created by angelslike on 15/8/4.
//  Copyright (c) 2015年 angelslike. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#define WXAppID @"wxcb123955cc21a093" //@"wx808df514e9cb4fc0"  公众平台
#define WXAppSecret @"e1f09700641778a0f00cd2f3b56f2862" // @"72113780a6d46096850d1a93ee5addb3" 公众平台


@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)initialSetting{
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    

    [self baiduMobStat];
    
//    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor getHexColor:@"ff6969"]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:17.0], NSFontAttributeName, nil]];
    
    self.window = [[UIWindow alloc]
                   initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainViewController *vc1 = [[MainViewController alloc]init];
    UINavigationController *nvc1 = [[UINavigationController alloc]initWithRootViewController:vc1];

    
    CouViewController *vc2 = [[CouViewController alloc]init];
    UINavigationController *nvc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    UINavigationController *nvc3 = [[UINavigationController alloc]init];//空白页
    
    CategoryViewController *vc4 = [[CategoryViewController alloc]init];
    UINavigationController *nvc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    MineViewController *vc5 = [[MineViewController alloc]init];
    UINavigationController *nvc5 = [[UINavigationController alloc]initWithRootViewController:vc5];
    
    
    TabBarViewController *tbc = [[TabBarViewController alloc]init];
    nvc1.delegate = tbc;
    nvc2.delegate = tbc;
    nvc3.delegate = tbc;
    nvc4.delegate = tbc;
    nvc5.delegate = tbc;
    
    tbc.viewControllers = @[nvc1,nvc2,nvc3,nvc4,nvc5];
    
    self.window.rootViewController = tbc;
    [self.window makeKeyAndVisible];
    
    
}

-(void)initialShareSDK{
    [ShareSDK registerApp:@"a6a1e4896170"];//字符串api20为您的ShareSDK的AppKey
    
//    //添加新浪微博应用 注册网址 http://open.weibo.com
//    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
//                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                             redirectUri:@"http://www.sharesdk.cn"];
//    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
//    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
//                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                              redirectUri:@"http://www.sharesdk.cn"
//                              weiboSDKCls:[WeiboSDK class]];
//    
//    //添加腾讯微博应用 注册网址 http://dev.t.qq.com
//    [ShareSDK connectTencentWeiboWithAppKey:@"801307650"
//                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
//                                redirectUri:@"http://www.sharesdk.cn"];
//    
//    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
//    [ShareSDK connectQZoneWithAppKey:@"100371282"
//                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
//    
//    //添加QQ应用  注册网址   http://mobile.qq.com/api/
//    [ShareSDK connectQQWithQZoneAppKey:@"100371282"
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
//    
    [ShareSDK connectWeChatWithAppId:WXAppID
                           appSecret:WXAppSecret
                           wechatCls:[WXApi class]];
}

-(void)baiduMobStat{
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    // 此处(startWithAppId之前)可以设置初始化的可选参数，具体有哪些参数，可详见BaiduMobStat.h文件，例如：
    statTracker.shortAppVersion  = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [statTracker startWithAppId:@"bb8a33dc91"]; // 设置您在mtj网站上添加的app的appkey,此处AppId即为应用的appKey
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:WXAppID];

    [self initialSetting];
    [self initialShareSDK];
    return YES;
}

#pragma mark -
#pragma mark wx delegate


-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
    }];
    return [WXApi handleOpenURL:url delegate:self];
}

-(void)onReq:(BaseReq *)req{

}

-(void)onResp:(BaseResp *)resp{
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *sendResp = (SendAuthResp *)resp;
        if (!sendResp.code) return;
        NSString *link = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAppID,WXAppSecret,sendResp.code];
        
        [[NetWork shared] query:link info:nil block:^(id Obj) {
            NSDictionary *info = (NSDictionary *)Obj;
            if (info) {
                [[NetWork shared] query:AppLoginUrl info:@{@"unionid":[info strForKey:@"unionid"]} block:^(id Obj) {
                    if ([Obj objForKey:@"data"]) {
                        [UserInfo shared].info = [Obj objectForKey:@"data"];
                        [[[UIAlertView alloc]initWithTitle:@"" message:@"登陆成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                    }else{
                        [[[UIAlertView alloc]initWithTitle:@"" message:@"没有此用户" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                    }
                } lock:YES];
            }
        } lock:YES];
        
        NSLog(@"resp %@",sendResp.code);
    }else if ([resp isKindOfClass:[SendMessageToWXResp class]]){
        SendMessageToWXResp *wxResp = (SendMessageToWXResp *)resp;
        
    }
    


    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
