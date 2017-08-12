//
//  ConfigHeader.h
//  KeTing
//
//  Created by 吴孔锐 on 2017/6/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#ifndef ConfigHeader_h
#define ConfigHeader_h

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "ToastView.h"
#import "Factory.h"
#import "NetWorkManger.h"
#import "UserManager.h"

//全局返回通用配置选项
typedef NS_ENUM(NSInteger, SelectorBackType){
    SelectorBackTypePopBack = 0,
    SelectorBackTypeDismiss,
    SelectorBackTypePoptoRoot
};
//比赛状态
typedef NS_ENUM(NSInteger,ScheduleStatus){
    ScheduleStatusReady = 0,    //比赛暂未开始
    ScheduleStatusPlaying  ,    //比赛中
    ScheduleStatusOvered        //比赛结束
};


#define UmengKey    @"54816a19fd98c5af9b001088"
#define WxAppID     @"wx39c19501fef6c3cb"
#define WxAppSecret @"40e72dd216b234ff249be91fe7538d4f"
#define QQAPPID     @"1106241047"
#define QQAPPKEY    @"opDdDWSqNTQkV6k1"
#define SINAAPPKEY  @"871709740"
#define SINAAPPSer  @"1bf93e753967fdb33ad8dca25acc0e11"
#define APPID       @"32323112312"

//750状态下字体适配
#define font750(x) ((x)/ 1334.0f) * UI_HEGIHT
//750状态下像素适配宏
#define Anno750(x) ((x)/ 1334.0f) * UI_HEGIHT


#define UI_BOUNDS   [UIScreen mainScreen].bounds
#define UI_HEGIHT   [UIScreen mainScreen].bounds.size.height
#define UI_WIDTH    [UIScreen mainScreen].bounds.size.width
#define IsPhone6P   [UIScreen mainScreen].bounds.size.width == 414

//规避空值
#define INCASE_EMPTY(str, replace) \
( ([(str) length]==0)?(replace):(str) )



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,sec) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:sec]


#define Color_MainBlue          UIColorFromRGB(0x003D79)
#define Color_alphaBlue         UIColorFromRGBA(0x003D79,0.8)
#define Color_LightGray         UIColorFromRGB(0x999999)
#define Color_MainRed           UIColorFromRGB(0xE31837)
#define Color_DarkGray          UIColorFromRGB(0x666666)
#define Color_MainBlack         UIColorFromRGB(0x333333)
#define Color_Line              UIColorFromRGBA(0x000000,0.2)
#define Color_BackGround        [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define Color_BackGround2       [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]
#define Color_SectionGround     [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.00]
#define Color_HsmRed            UIColorFromRGB(0xE31837)
#define Color_TagGray           [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]

#endif /* ConfigHeader_h */
