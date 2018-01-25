//
//  RootViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "VideoViewController.h"
#import "DataViewController.h"
#import "MoreViewController.h"
#import "ConfigHeader.h"




@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];

}
- (void)creatUI{
    NSArray * titles = @[@"比赛",@"最新",@"视频",@"数据",@"更多"];
    NSArray * images = @[@"tab_icon_match_default",@"tab_icon_newest_default",@"tab_icon_video_default",@"tab_icon_data_default",@"tab_icon_more_default"];
    NSArray * selImg = @[@"tab_icon_match_hover",@"tab_icon_newest_hover",@"tab_icon_video_hover",@"tab_icon_data_hover",@"tab_icon_more_hover"];
    
    HomeViewController * home = [[HomeViewController alloc]init];
    NewsViewController * news = [[NewsViewController alloc]init];
    VideoViewController * video = [[VideoViewController alloc]init];
    DataViewController * data = [[DataViewController alloc]init];
    MoreViewController * more = [[MoreViewController alloc]init];
    
    UINavigationController * nav_home = [[UINavigationController alloc]initWithRootViewController:home];
    UINavigationController * nav_news = [[UINavigationController alloc]initWithRootViewController:news];
    UINavigationController * nav_vido = [[UINavigationController alloc]initWithRootViewController:video];
    UINavigationController * nav_data = [[UINavigationController alloc]initWithRootViewController:data];
    UINavigationController * nav_more = [[UINavigationController alloc]initWithRootViewController:more];
    self.viewControllers = @[nav_home,nav_news,nav_vido,nav_data,nav_more];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:Color_MainBlue, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    for (int i = 0; i<self.viewControllers.count; i++) {
        UINavigationController * nav = self.viewControllers[i];
        nav.title = titles[i];
        nav.tabBarItem.image = [[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selImg[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [self requestMessageCount];
    self.starType = 0;
    NSString * homepage = [[NSUserDefaults standardUserDefaults] objectForKey:@"HOMEPAGE"];
    if (homepage) {
        if ([homepage isEqualToString:@"match"]) {
            self.starType = 0;
        }else if([homepage isEqualToString:@"newset"]){
            self.starType = 1;
        }else if([homepage isEqualToString:@"video"]){
            self.starType = 2;
        }else if([homepage isEqualToString:@"static"]){
            self.starType = 3;
        }else if([homepage isEqualToString:@"more"]){
            self.starType = 4;
        }
    }
    
    self.selectedIndex = self.starType;
    
}
- (void)requestMessageCount{
    if (![UserManager manager].isLogin) {
        return;
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID
                              };
    [[NetWorkManger manager] sendRequest:PageMessage route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSDictionary * data = result[@"data"];
        NSNumber * num = data[@"online_answer"];
        if (num.intValue >0) {
            CGFloat x = ceilf(0.94 * self.tabBar.frame.size.width);
            CGFloat y = ceilf(0.2 * self.tabBar.frame.size.height);
            UIView * dot = [[UIView alloc]initWithFrame:CGRectMake(x, y, Anno750(12), Anno750(12))];
            dot.backgroundColor = [UIColor redColor];
            dot.layer.cornerRadius = Anno750(6);
            dot.tag = 1000;
            [self.tabBar addSubview:dot];
        }
    } error:^(NFError *byerror) {
        
    }];
}


@end
