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
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "UMMobClick/MobClick.h"
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

#define UmengClick  @"599bf78f07fe6566dd00173b"
#define UmengKey    @"599bf2c34544cb5580000c1d"
#define WxAppID     @"wx39c19501fef6c3cb"
#define WxAppSecret @"db2885af44da504ec809a454015b6687"
//@"40e72dd216b234ff249be91fe7538d4f"
#define QQAPPID     @"1106241047"
#define QQAPPKEY    @"opDdDWSqNTQkV6k1"
#define SINAAPPKEY  @"871709740"
#define SINAAPPSer  @"1bf93e753967fdb33ad8dca25acc0e11"
#define APPID       @"950589192"
#define JpushKey    @"99b8ab040a1e348f937c9afb"



//赛程首页
#define Mob_Schedules           @"schedules"
//赛程 关注球队
#define Mob_Schedules_favor     @"schedules_favorites"
//资讯首页
#define Mob_News                @"news"
//资讯-关注
#define Mob_Favor               @"news_favorites"
//资讯-图集
#define Mob_Albums              @"news_albums"
//资讯-专栏
#define Mob_Columns             @"news_columns"
//视频首页
#define Mob_Videos              @"videos"
//视频-球星
#define Mob_Stars              @"videos_stars"
//视频-赛事
#define Mob_Matches             @"videos_matches"
//视频-花絮
#define Mob_Stories             @"videos_stories"
//视频-101
#define Mob_101                 @"videos_101"
//视频-关注
#define Mob_VideoFav            @"video_favorites"
//数据首页
//数据-球员排名
#define Mob_Player              @"stats_players"
//数据-球队信息
#define Mob_Team                @"stats_teams"
//数据-球队排名
#define Mob_Standing            @"stats_standing"
//更多页面
#define Mob_More                @"more"
//我的收藏
#define Mob_Like                @"my_likes"
//在线问答
#define Mob_Question            @"QnA"
//101课堂
#define Mob_Ball101             @"football_101"
//天天NFL
#define Mob_TTnfl               @"tt_NFL"
//意见反馈
#define Mob_Feedback            @"feedback"
//关于我们
#define Mob_AboutUs             @"about_us"
//设置
#define Mob_Setting             @"setting"
//统计新手页面打开次数
#define Mob_101H5               @"101H5"
//跳出页面
#define Mob_Exit                @"exit_page"
//打开页面时间
#define Mob_Open                @"opening_time"
//打开页面时长
#define Mob_Duration            @"opening_duration"
//主队选择情况
#define Mob_PickTeam            @"pick_team"
//我的关注
#define Mob_MyFavorties         @"more_favorites"




//750状态下字体适配
#define font750(x) ((x)/ 750.0f) * UI_WIDTH
//750状态下像素适配宏
#define Anno750(x) ((x)/ 750.0f) * UI_WIDTH

#ifdef DEBUG
#define isProduct YES
#else
#define isProduct NO
#endif


#define UI_BOUNDS   [UIScreen mainScreen].bounds
#define UI_HEGIHT   [UIScreen mainScreen].bounds.size.height
#define UI_WIDTH    [UIScreen mainScreen].bounds.size.width
#define IsPhone6P   [UIScreen mainScreen].bounds.size.width == 414
#define IsPhoneX    [UIScreen mainScreen].bounds.size.height == 812
#define Nav64       ([UIScreen mainScreen].bounds.size.height == 812.0f ? 88 : 64)
#define Tab49       ([UIScreen mainScreen].bounds.size.height == 812.0f ? 83 : 49)
//规避空值
#define INCASE_EMPTY(str, replace) \
( ([(str) length]==0)?(replace):(str) )




#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,sec) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:sec]


#define Color_LightBlue         UIColorFromRGB(0x1FACFF)
#define Color_DarkBlue          UIColorFromRGB(0x027AFF)
#define Color_MainBlue          UIColorFromRGB(0x1D5E95)
//#define Color_alphaBlue         UIColorFromRGBA(0x003D79,0.8)
#define Color_alphaBlue         UIColorFromRGBA(0x1D5E95,0.8)
#define Color_LightGray         UIColorFromRGB(0x999999)
#define Color_MainRed           UIColorFromRGB(0xE31837)
#define Color_DarkGray          UIColorFromRGB(0x666666)
#define Color_MainBlack         UIColorFromRGB(0x333333)
#define Color_Line              UIColorFromRGBA(0x000000,0.2)
//#define Color_NavColor          UIColorFromRGB(0x4F2683)
#define Color_BackGround        [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00]
#define Color_BackGround2       [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]
#define Color_SectionGround     [UIColor colorWithRed:0.96 green:0.96 blue:0.97 alpha:1.00]
#define Color_HsmRed            UIColorFromRGB(0xE31837)
#define Color_TagGray           [UIColor colorWithRed:0.70 green:0.70 blue:0.70 alpha:1.00]
#define Color_White_5           UIColorFromRGBA(0xFFFFFF, 0.5)
#define Color_White_3           UIColorFromRGBA(0xFFFFFF, 0.3)
#define Color_TagBlue           UIColorFromRGB(0x007CC2)

#endif /* ConfigHeader_h */
