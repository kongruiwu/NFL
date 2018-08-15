//
//  AppDelegate.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AppDelegate.h"
#import "ConfigHeader.h"
#import "RootViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LanuchMovieViewController.h"
#import "UMMobClick/MobClick.h"
#import "JpushHandler.h"
#import "RootViewController.h"
#import "LanuchImgViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //延迟加载 推送使用
    self.isLanuch = YES;
    
    [self UmengSetting];
    [self JpushSettingWithDic:launchOptions];
    [self getUserInfo];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc]initWithFrame:UI_BOUNDS];
    [self.window setRootViewController:[LanuchImgViewController new]];
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)UmengSetting{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengKey];
    
    UMConfigInstance.appKey = UmengClick;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WxAppID appSecret:WxAppSecret redirectURL:@"NFL"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAPPID/*设置QQ平台的appID*/  appSecret:QQAPPKEY redirectURL:@"NFL"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SINAAPPKEY  appSecret:SINAAPPSer redirectURL:@"NFL"];
}

- (void)getUserInfo{
    if (![UserManager manager].userID) {
        return;
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              };
    [[NetWorkManger manager] sendRequest:PageUserInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        [[UserManager manager] updateUserInfo:dic];
    } error:^(NFError *byerror) {
        
    }];
}
- (void)JpushSettingWithDic:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JpushKey
                          channel:@"App Store"
                 apsForProduction:isProduct
            advertisingIdentifier:nil];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (result) {
        return  YES;
    }
    return NO;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [[JpushHandler handler] handerJpushMessage:userInfo withForground:YES];
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    if (self.isLanuch) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[JpushHandler handler] handerJpushMessage:userInfo withForground:NO];
        });
    }else{
        [[JpushHandler handler] handerJpushMessage:userInfo withForground:NO];
    }
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    if (application.applicationState == UIApplicationStateActive) {
        [[JpushHandler handler] handerJpushMessage:userInfo withForground:YES];
    }else{
        if (self.isLanuch) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[JpushHandler handler] handerJpushMessage:userInfo withForground:NO];
            });
        }else{
            [[JpushHandler handler] handerJpushMessage:userInfo withForground:NO];
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    if (self.isLanuch) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[JpushHandler handler] handerJpushMessage:userInfo withForground:NO];
        });
    }else{
        [[JpushHandler handler] handerJpushMessage:userInfo withForground:NO];
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    [JPUSHService setBadge:0];
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    UIWindow * window = [[UIWindow alloc]initWithFrame:UI_BOUNDS];
    window.backgroundColor = [UIColor redColor];
    [window makeKeyAndVisible];
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
