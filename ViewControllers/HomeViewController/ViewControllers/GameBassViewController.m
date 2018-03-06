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

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(hiddenOutHeadView:)]) {
        [self.delegate hiddenOutHeadView:scrollView.contentOffset.y];
    }
}
- (void)updateTabFooter{
//    if ([[[UIDevice currentDevice] systemVersion] floatValue]>= 10) {
//        if (self.tabview.contentSize.height<UI_HEGIHT) {
//            UIView * view  = [Factory creatViewWithColor:[UIColor clearColor]];
//            view.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - self.tabview.contentSize.height + 49);
//            self.tabview.tableFooterView = view;
//        }
//    }
}

@end
