//
//  JpushHandler.h
//  ZhongZhengTong
//
//  Created by 吴孔锐 on 2017/6/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JPUSHTYPE){
    JPUSHTYPENULL = 0 ,     //默认无 直接打开app
    JPUSHTYPEGameDetail,    //比赛详情
    JPUSHTYPEVideo,         //视频详情
    JPUSHTYPENews,          //新闻详情
};


@interface JpushHandler : NSObject


@property (nonatomic, strong) UIViewController * currentVC;

+ (instancetype)handler;
//注册代理
- (void)handerJpushMessage:(NSDictionary *)message withForground:(BOOL)rec;
@end
