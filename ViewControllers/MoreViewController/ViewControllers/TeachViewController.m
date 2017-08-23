//
//  TeachViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeachViewController.h"
#import <HMSegmentedControl.h>
#import "SubTeachViewController.h"

@interface TeachViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) HMSegmentedControl * hmsgControl;
@property (nonatomic, strong) UIScrollView * mainScroll;
@property (nonatomic, strong) NSMutableArray * viewControllers;
@end

@implementation TeachViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"101课堂"];
    [self creatUI];
}
- (void)creatUI{
    self.viewControllers = [NSMutableArray new];
    
    UIImageView * imgView = [Factory creatImageViewWithImage:@"nav_bg_default"];
    imgView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    imgView.userInteractionEnabled = YES;
    [self.view addSubview:imgView];
    NSArray * titles = @[@"规则介绍",@"超级球星",@"超级碗"];
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
    
    for (int i = 0; i<titles.count; i++) {
        if (i == 0) {
            SubTeachViewController * vc = [[SubTeachViewController alloc]init];
            vc.teachType = i;
            vc.view.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
            [self.mainScroll addSubview:vc.view];
            [self addChildViewController:vc];
            [self.viewControllers addObject:vc];
        }else{
            [self.viewControllers addObject:@"viewControllers"];
        }
    }
    __weak TeachViewController * weakSelf = self;
    [self.hmsgControl setIndexChangeBlock:^(NSInteger index) {
        CGPoint point = weakSelf.mainScroll.contentOffset;
        if ([weakSelf.viewControllers[index] isKindOfClass:[NSString class]]) {
            SubTeachViewController * vc = [[SubTeachViewController alloc]init];
            vc.teachType = index;
            vc.view.frame = CGRectMake(UI_WIDTH * index, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
            [weakSelf.mainScroll addSubview:vc.view];
            [weakSelf addChildViewController:vc];
            [weakSelf.viewControllers replaceObjectAtIndex:index withObject:vc];
        }
        [UIView animateWithDuration:0.3f animations:^{
            weakSelf.mainScroll.contentOffset = CGPointMake(UI_WIDTH * index,point.y);
        }];
    }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / UI_WIDTH;
    if ([self.viewControllers[index] isKindOfClass:[NSString class]]) {
        SubTeachViewController * vc = [[SubTeachViewController alloc]init];
        vc.teachType = index;
        vc.view.frame = CGRectMake(UI_WIDTH * index, 0, UI_WIDTH, UI_HEGIHT - Anno750(80));
        [self.mainScroll addSubview:vc.view];
        [self addChildViewController:vc];
        [self.viewControllers replaceObjectAtIndex:index withObject:vc];
    }
    [self.hmsgControl setSelectedSegmentIndex:index animated:YES];
}


@end
