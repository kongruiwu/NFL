//
//  GameBassViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"

@interface GameBassViewController ()<UIScrollViewDelegate>

@end

@implementation GameBassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tabview.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(hiddenOutHeadView:)]) {
        [self.delegate hiddenOutHeadView:scrollView.contentOffset.y];
    }
}
@end
