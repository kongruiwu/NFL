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
    NSArray * images = @[@"",@"",@"",@"",@""];
    NSArray * selImg = @[@"",@"",@"",@"",@""];
    
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
    
}


@end
