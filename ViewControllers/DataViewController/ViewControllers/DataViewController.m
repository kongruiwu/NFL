//
//  DataViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "DataViewController.h"
#import "TeamDataView.h"
#import <HMSegmentedControl.h>
#import "TeamInfoViewController.h"
#import "TeamRankViewController.h"
#import "TeamerRankViewController.h"
@interface DataViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl * hmsgControl;
@property (nonatomic, strong) UIScrollView * mainScroll;

@end

@implementation DataViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawNavLogo];
    [self setNavLineHidden];
    [self creatUI];
    
}

- (void)creatUI{
    
    UIImageView * imgView = [Factory creatImageViewWithImage:@"nav_bg_default"];
    imgView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    NSArray * titles = @[@"球队信息",@"球队排名",@"球员排名"];
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
    
    TeamInfoViewController * teaminfo = [TeamInfoViewController new];
    teaminfo.view.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
    [self.mainScroll addSubview:teaminfo.view];
    [self addChildViewController:teaminfo];
    
    TeamRankViewController * teamRank = [TeamRankViewController new];
    teamRank.view.frame = CGRectMake(UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
    [self.mainScroll addSubview:teamRank.view];
    [self addChildViewController:teamRank];
    
    TeamerRankViewController * TeamerRank = [TeamerRankViewController new];
    TeamerRank.view.frame = CGRectMake(UI_WIDTH * 2, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
    [self.mainScroll addSubview:TeamerRank.view];
    [self addChildViewController:TeamerRank];
    
    __weak DataViewController * weakself = self;
    [self.hmsgControl setIndexChangeBlock:^(NSInteger index) {
        CGPoint point = weakself.mainScroll.contentOffset;
        [UIView animateWithDuration:0.3f animations:^{
            weakself.mainScroll.contentOffset = CGPointMake(UI_WIDTH * index,point.y);
        }];
    }];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / UI_WIDTH;
    [self.hmsgControl setSelectedSegmentIndex:index animated:YES];
}



@end
