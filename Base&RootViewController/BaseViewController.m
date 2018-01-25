//
//  BaseViewController.m
//  KeTing
//
//  Created by 吴孔锐 on 2017/6/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color_BackGround;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_default"] forBarMetrics:UIBarMetricsDefault];
    [self creatNullView];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)showNullViewByType:(NullType)type{
    [self.view bringSubviewToFront:self.nullView];
    self.nullView.hidden =NO;
    self.nullView.nullType = type;
}
- (void)hiddenNullView{
    if (!self.nullView.hidden) {
        self.nullView.hidden = YES;
    }
}
- (void)creatNullView{
    self.nullView = [[NullView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) andNullType:NullTypeNoneData];
    [self.view addSubview:self.nullView];
    [self.nullView.clearBtn addTarget:self action:@selector(nullViewClick) forControlEvents:UIControlEventTouchUpInside];
    self.nullView.hidden = YES;
}
- (void)nullViewClick{
    if (self.nullView.nullType == NullTypeNetError) {
        [self getData];
    }
}
- (void)getData{
    
}
- (void)doBack{
    switch (self.backType) {
        case SelectorBackTypeDismiss:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case SelectorBackTypePopBack:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case SelectorBackTypePoptoRoot:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

- (void)setNavAlpha{
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.translucent = YES;
    UIView * clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, 20)];
    [self.view addSubview:clearView];
    //    导航栏变为透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}
- (void)setNavLineHidden{
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
}

- (void)setNavUnAlpha{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_default"] forBarMetrics:0];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)setNavTitle:(NSString *)title{
    UILabel * titleLabel = [Factory creatLabelWithText:title
                                               fontValue:font750(34)
                                               textColor:[UIColor whiteColor]
                                           textAlignment:NSTextAlignmentCenter];
    titleLabel.frame = CGRectMake(0, 0, 100, 40);
    self.navigationItem.titleView = titleLabel;
}
- (void)drawNavLogo{
    UIImageView * logo = [Factory creatImageViewWithImage:@"nav_logo_nfl"];
    logo.frame = CGRectMake(0, 0, Anno750(48), Anno750(68));
    self.navigationItem.titleView = logo;
}
- (void)drawBackButton{
    UIImage * image = [[UIImage imageNamed:@"nav_icon_back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)drawShareButton{
    UIImage * shareImg = [[UIImage imageNamed:@"nav_icon_share_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * share = [[UIBarButtonItem alloc]initWithImage:shareImg style:UIBarButtonItemStylePlain target:self action:@selector(doShare)];
    self.navigationItem.rightBarButtonItem = share;
}
- (void)doShare{
    
}

@end
