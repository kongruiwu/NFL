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

@interface HomeViewController ()<UIScrollViewDelegate,SelectTimeViewDelegate>

@property (nonatomic, strong) SelectTimeView * timeView;
@property (nonatomic, strong) HMSegmentedControl * hmsgControl;
@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) NSMutableArray * viewControllers;
@property (nonatomic) NSInteger defaultWeek;
@property (nonatomic, strong) UIBarButtonItem  * leftItem;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavLineHidden];
    self.tabBarController.tabBar.hidden = NO;
    
    self.timeView = [[SelectTimeView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) isTeam:NO defaultWeek:self.defaultWeek];
    self.timeView.delegate = self;
    [self.tabBarController.view addSubview:self.timeView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.timeView.delegate = nil;
    [self.timeView removeFromSuperview];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultWeek = -1;
    [self drawNavLogo];
    [self setNavLineHidden];
    [self drawLeftNavButton];
    [self creatUI];
    [self getData];
    
}
- (void)drawLeftNavButton{
    UIImage * image = [[UIImage imageNamed:@"nav_icon_calendar_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(checkWeeksData)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.leftItem = leftBtn;
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
                                             NSForegroundColorAttributeName : Color_White_5};
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
    self.viewControllers = [NSMutableArray arrayWithObjects:vc,@"viewController", nil];
    
    __weak HomeViewController * weakself = self;
    [self.hmsgControl setIndexChangeBlock:^(NSInteger index) {
        CGPoint point = weakself.mainScroll.contentOffset;
        if ([weakself.viewControllers[index] isKindOfClass:[NSString class]]) {
            if (index == 1) {
                AttentionteamViewController * attVc = [AttentionteamViewController new];
                attVc.view.frame = CGRectMake(UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
                [weakself.mainScroll addSubview:attVc.view];
                [weakself addChildViewController:attVc];
                [weakself.viewControllers replaceObjectAtIndex:index withObject:attVc];
            }
        }
        if (index == 0) {
            weakself.navigationItem.leftBarButtonItem = weakself.leftItem;
        }else{
            weakself.navigationItem.leftBarButtonItem = nil;
        }
        [UIView animateWithDuration:0.3f animations:^{
            weakself.mainScroll.contentOffset = CGPointMake(UI_WIDTH * index,point.y);
        }];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / UI_WIDTH;
    if (index == 0) {
        self.navigationItem.leftBarButtonItem = self.leftItem;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
    }
    if ([self.viewControllers[index] isKindOfClass:[NSString class]]) {
        if (index == 1) {
            AttentionteamViewController * attVc = [AttentionteamViewController new];
            attVc.view.frame = CGRectMake(UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
            [self.mainScroll addSubview:attVc.view];
            [self addChildViewController:attVc];
            [self.viewControllers replaceObjectAtIndex:index withObject:attVc];
        }
    }
    [self.hmsgControl setSelectedSegmentIndex:index animated:YES];
}

- (void)checkWeeksData{
    [self.timeView show];
}

- (void)selectTimeSection:(TimeListModel *)model{
    self.defaultWeek = [model.week integerValue];
    NSDictionary * params = @{
                              @"type":model.match_type,
                              @"week":model.week
                              };
    ScheduleViewController * vc = self.viewControllers[0];
    [vc requestDataWithParmas:params];
}



@end
