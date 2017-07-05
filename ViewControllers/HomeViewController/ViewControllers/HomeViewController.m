//
//  HomeViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNavLogo];
    [self setNavLineHidden];
    [self drawLeftNavButton];
    [self creatUI];
}
- (void)drawLeftNavButton{
    UIImage * image = [[UIImage imageNamed:@"nav_icon_calendar_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(checkWeeksData)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)creatUI{
    
    UIImageView * imgView = [Factory creatImageViewWithImage:@"nav_bg_default"];
    imgView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    [self.view addSubview:imgView];
    
    
}


- (void)checkWeeksData{
    
}
@end
