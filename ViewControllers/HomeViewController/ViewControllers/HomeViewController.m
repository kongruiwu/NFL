//
//  HomeViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeViewController.h"
#import <HMSegmentedControl.h>
#import "ScheduleViewController.h"
#import "SelectTimeView.h"
#import "AttentionteamViewController.h"


#import "GameDetailsViewController.h"
@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl * hmsgControl;
@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) SelectTimeView * timeView;
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
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    NSArray * titles = @[@"赛程",@"关注球队"];
    self.hmsgControl = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    self.hmsgControl.backgroundColor = [UIColor clearColor];
    [imgView addSubview:self.hmsgControl];
    [self.hmsgControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(70)));
        make.right.equalTo(@0);
    }];
    self.hmsgControl.titleTextAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                             NSForegroundColorAttributeName : UIColorFromRGBA(0xFFFFFF, 0.5)};
    self.hmsgControl.selectedTitleTextAttributes = @{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.hmsgControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.hmsgControl.selectionIndicatorHeight = Anno750(6);
    self.hmsgControl.selectionIndicatorColor = Color_HsmRed;
    
    
    self.mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Anno750(80), UI_WIDTH,  UI_HEGIHT - Anno750(80))];
    self.mainScroll.contentSize = CGSizeMake(titles.count * UI_WIDTH, 0);
    [self.mainScroll autoresizingMask];
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll.showsVerticalScrollIndicator = NO;
    self.mainScroll.showsHorizontalScrollIndicator = NO;
    self.mainScroll.backgroundColor = Color_BackGround;
    self.mainScroll.delegate = self;
    [self.view addSubview:self.mainScroll];
    
    ScheduleViewController * vc = [ScheduleViewController new];
    vc.view.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
    [self.mainScroll addSubview:vc.view];
    [self addChildViewController:vc];
    
    AttentionteamViewController * attVc = [AttentionteamViewController new];
    attVc.view.frame = CGRectMake(UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
    [self.mainScroll addSubview:attVc.view];
    [self addChildViewController:attVc];
    
    __weak HomeViewController * weakself = self;
    [self.hmsgControl setIndexChangeBlock:^(NSInteger index) {
        CGPoint point = weakself.mainScroll.contentOffset;
        [UIView animateWithDuration:0.3f animations:^{
            weakself.mainScroll.contentOffset = CGPointMake(UI_WIDTH * index,point.y);
        }];
    }];
    
    
    self.timeView = [[SelectTimeView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    [self.tabBarController.view addSubview:self.timeView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / UI_WIDTH;
    [self.hmsgControl setSelectedSegmentIndex:index animated:YES];
}


- (void)checkWeeksData{
//    [self.timeView show];
    [self.navigationController pushViewController:[GameDetailsViewController new] animated:YES];
}
@end
