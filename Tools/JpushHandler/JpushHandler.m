//
//  JpushHandler.m
//  ZhongZhengTong
//
//  Created by 吴孔锐 on 2017/6/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "JpushHandler.h"

#import "GameDetailTabViewController.h"
#import "VideoDetailViewController.h"
#import "WKWebViewController.h"

@implementation JpushHandler

+ (instancetype)handler{
    static JpushHandler * handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (handler == nil) {
            handler = [[JpushHandler alloc]init];
        }
    });
    return handler;
}


- (void)handerJpushMessage:(NSDictionary *)message withForground:(BOOL)rec{
    NSDictionary * dic = message[@"aps"];
    NSNumber * type = @0;
    if (message[@"type"]) {
        type = message[@"type"];
    }
    NSNumber * idNum = @0;
    NSNumber * status = @0;
    if (message[@"idnum"]) {
        idNum = message[@"idnum"];
    }
    if (message[@"status"]) {
        status = message[@"status"];
    }
    if (rec) {//前台接收信息
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"推送信息" message:dic[@"alert"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cannce = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * sure = [UIAlertAction actionWithTitle:@"去看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self pushToViewController:type idNum:idNum status:status];
        }];
        [alert addAction:cannce];
        [alert addAction:sure];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }else{
        [self pushToViewController:type idNum:idNum status:status];
    }
    
    
}
/**比赛内页、视频内页、新闻内页*/
- (void)pushToViewController:(NSNumber *)type idNum:(NSNumber *)idnum status:(NSNumber *)status{
    self.currentVC = [self getCurrentVC];
    switch (type.integerValue) {
        case JPUSHTYPEGameDetail:
        {
            GameDetailTabViewController * vc = [[GameDetailTabViewController alloc]initWithGameID:idnum matchStatus:status.integerValue];
            [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
            break;
        case JPUSHTYPEVideo:
        {
            VideoDetailViewController * vc = [[VideoDetailViewController alloc] init];
            vc.videoID = idnum;
            [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
            break;
        case JPUSHTYPENews:
        {
            WKWebViewController * vc = [[WKWebViewController alloc]initWithNewsId:idnum];
            [[self getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
- (UIViewController *)getCurrentVC
{
    UITabBarController *tbc = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UINavigationController  *nvc = tbc.selectedViewController;
    UIViewController *vc = nvc.visibleViewController;
    return vc;
}


@end
