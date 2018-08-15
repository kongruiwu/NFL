//
//  FristViewController.m
//  ZhongZhengTong
//
//  Created by 吴孔锐 on 2017/6/21.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "FristViewController.h"
#import "ConfigHeader.h"
#import "RootViewController.h"
@interface FristViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) NSArray * images;

@end

@implementation FristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI{
    
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"Frist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSArray * images = @[@"lan1.jpg",@"lan2.jpg",@"lan3.jpg",@"lan4.jpg",@"lan5.jpg"];
    self.images = images;
    self.mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.contentSize = CGSizeMake(UI_WIDTH * images.count, UI_HEGIHT);
    self.mainScroll.showsVerticalScrollIndicator =NO;
    self.mainScroll.showsHorizontalScrollIndicator =NO;
    [self.view addSubview:self.mainScroll];
    for (int i = 0; i<images.count; i++) {
        UIImageView * imgView = [Factory creatImageViewWithImage:images[i]];
        imgView.frame = CGRectMake(UI_WIDTH * i, 0, UI_WIDTH, UI_HEGIHT);
        
        if (i == images.count - 1) {
            UIButton * buton = [Factory creatButtonWithTitle:@"进入NFL的世界"
                                             backGroundColor:Color_MainBlue
                                                   textColor:[UIColor whiteColor]
                                                    textSize:font750(30)];
            buton.frame = CGRectMake(Anno750(750 - 325)/2, Anno750(1200), Anno750(325), Anno750(80));
            buton.layer.cornerRadius = Anno750(40);
            [imgView addSubview:buton];
            imgView.userInteractionEnabled = YES;
            [buton addTarget:self action:@selector(pushToHome) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.mainScroll addSubview:imgView];
    }
    self.mainScroll.delegate = self;
}
- (void)pushToHome{
    
    [[UIApplication sharedApplication].keyWindow setRootViewController:[RootViewController new]];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x > UI_WIDTH * (self.images.count - 1) + 20) {
        [[UIApplication sharedApplication].keyWindow setRootViewController:[RootViewController new]];
    }
}


@end
