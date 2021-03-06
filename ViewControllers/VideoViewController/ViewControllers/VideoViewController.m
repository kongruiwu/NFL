//
//  VideoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoViewController.h"
#import <HMSegmentedControl.h>
#import "SubVideoViewController.h"
#import "VideoAttentionViewController.h"
@interface VideoViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) HMSegmentedControl * hmsgControl;

@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) NSMutableArray * viewControllers;


@end

@implementation VideoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavLineHidden];
    self.tabBarController.tabBar.hidden = NO;
    [MobClick event:Mob_Videos];
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
    NSArray * titles = @[@"球星",@"赛事",@"花絮",@"101",@"关注"];
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
    
    SubVideoViewController * vc = [SubVideoViewController new];
    vc.view.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
    [self addChildViewController:vc];
    [self.mainScroll addSubview:vc.view];
    self.viewControllers = [NSMutableArray arrayWithObjects:vc,@"viewControllers",@"viewControllers",@"viewControllers",@"viewControllers",nil];
    
    __weak VideoViewController * weakSelf = self;
    [self.hmsgControl setIndexChangeBlock:^(NSInteger index) {
        CGPoint point = weakSelf.mainScroll.contentOffset;
        if ([weakSelf.viewControllers[index] isKindOfClass:[NSString class]]) {
            if (index == 4) {
                VideoAttentionViewController * vc = [VideoAttentionViewController new];
                vc.view.frame = CGRectMake(index * UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
                [weakSelf addChildViewController:vc];
                [weakSelf.mainScroll addSubview:vc.view];
                [weakSelf.viewControllers replaceObjectAtIndex:index withObject:vc];
            }else{
                SubVideoViewController * vc = [SubVideoViewController new];
                vc.videoType = index;
                vc.view.frame = CGRectMake(index * UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
                [weakSelf addChildViewController:vc];
                [weakSelf.mainScroll addSubview:vc.view];
                [weakSelf.viewControllers replaceObjectAtIndex:index withObject:vc];
            }
        }
        [weakSelf mobClickEvent:index];
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.mainScroll.contentOffset = CGPointMake(UI_WIDTH * index,point.y);
        }];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / UI_WIDTH;
    if ([self.viewControllers[index] isKindOfClass:[NSString class]]) {
        if (index == 4) {
            VideoAttentionViewController * vc = [VideoAttentionViewController new];
            vc.view.frame = CGRectMake(index * UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
            [self addChildViewController:vc];
            [self.mainScroll addSubview:vc.view];
            [self.viewControllers replaceObjectAtIndex:index withObject:vc];
        }else{
            SubVideoViewController * vc = [SubVideoViewController new];
            vc.videoType = index;
            vc.view.frame = CGRectMake(index * UI_WIDTH, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
            [self addChildViewController:vc];
            [self.mainScroll addSubview:vc.view];
            [self.viewControllers replaceObjectAtIndex:index withObject:vc];
        }
    }
    [self mobClickEvent:index];
    [self.hmsgControl setSelectedSegmentIndex:index animated:YES];
}
- (void)mobClickEvent:(NSInteger)index{
    if (index == 0) {
        [MobClick event:Mob_Stars];
    }else if(index == 1){
        [MobClick event:Mob_Matches];
    }else if(index == 2){
        [MobClick event:Mob_Stories];
    }else if(index == 3){
        [MobClick event:Mob_101];
    }else if(index == 4){
        [MobClick event:Mob_VideoFav];
    }
}


@end
