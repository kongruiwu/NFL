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
    self.segmentView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64);
    
    [self addSubview:self.groundImg];
    [self addSubview:self.segmentView];
    
    /**
     @property (nonatomic, strong) UIImageView * leftImg;
     @property (nonatomic, strong) UIImageView * rightImg;
     @property (nonatomic, strong) UILabel * leftScore;
     @property (nonatomic, strong) UILabel * rightScore;
     @property (nonatomic, strong) UIView * lineView;
     */
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.rightImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.leftScore = [Factory creatLabelWithText:@"13"
                                     fontValue:font750(52)
                                     textColor:UIColorFromRGBA(0xFFFFFF, 0.5)
                                 textAlignment:NSTextAlignmentCenter];
    self.rightScore = [Factory creatLabelWithText:@"21"
                                        fontValue:font750(52)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    
    self.lineView = [Factory creatLineView];
    
    self.leftImg.frame = CGRectMake(Anno750(85 *2), 20 + Anno750(4), Anno750(80), Anno750(80));
    self.rightImg.frame = CGRectMake(UI_WIDTH - Anno750(80) - Anno750(85 *2), 20+ Anno750(4), Anno750(80), Anno750(80));
    self.leftScore.frame = CGRectMake(Anno750(85 * 2)+ Anno750(80) + Anno750(40), 20 + Anno750(12), Anno750(60), Anno750(60));
    self.rightScore.frame = CGRectMake(UI_WIDTH - Anno750(60) -Anno750(85 * 2)- Anno750(80) - Anno750(40) , 20 + Anno750(12), Anno750(60), Anno750(60));
    
    [self addSubview:self.leftImg];
    [self addSubview:self.rightImg];
    [self addSubview:self.leftScore];
    [self addSubview:self.rightScore];
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@((20 + Anno750(88 - 6)/2)));
        make.height.equalTo(@(Anno750(6)));
        make.width.equalTo(@(Anno750(18)));
    }];
    
}

@end
