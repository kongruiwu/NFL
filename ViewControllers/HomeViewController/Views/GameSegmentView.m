//
//  GameSegmentView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameSegmentView.h"

@implementation GameSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.groundImg.alpha = 0;
    NSArray * titles = @[@"直播",@"数据",@"视频"];
    self.segmentView = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    self.segmentView.backgroundColor = [UIColor clearColor];
    
    self.segmentView.titleTextAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                             NSForegroundColorAttributeName : UIColorFromRGBA(0xFFFFFF, 0.5)};
    self.segmentView.selectedTitleTextAttributes = @{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView.selectionIndicatorHeight = Anno750(6);
    self.segmentView.selectionIndicatorColor = Color_HsmRed;
    
    self.groundImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.segmentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self addSubview:self.groundImg];
    [self addSubview:self.segmentView];
}

@end
