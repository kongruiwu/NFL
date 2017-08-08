//
//  GameHeaderView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameHeaderView.h"

@implementation GameHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{

    self.blueImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.blueImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_big"];
    self.groundImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.blueImg];
    [self addSubview:self.groundImg];
    
    NSArray * titles = @[@"直播",@"数据",@"视频"];
    self.segmentView = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    self.segmentView.backgroundColor = [UIColor clearColor];
    self.segmentView.frame = CGRectMake(0, self.frame.size.height - Anno750(80), UI_WIDTH, Anno750(80));
    self.segmentView.titleTextAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                             NSForegroundColorAttributeName : UIColorFromRGBA(0xFFFFFF, 0.5)};
    self.segmentView.selectedTitleTextAttributes = @{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView.selectionIndicatorHeight = Anno750(6);
    self.segmentView.selectionIndicatorColor = Color_HsmRed;
    [self addSubview:self.segmentView];
    
    
    /*
     @property (nonatomic, strong) UIImageView * leftImg;
     @property (nonatomic, strong) UIImageView * rightImg;
     @property (nonatomic, strong) UILabel * leftName;
     @property (nonatomic, strong) UILabel * rightName;
     @property (nonatomic, strong) UILabel * leftScore;
     @property (nonatomic, strong) UILabel * rightScore;
     @property (nonatomic, strong) UILabel * gameStatus;
     @property (nonatomic, strong) UILabel * vsLabel;
     @property (nonatomic, strong) UILabel * timeLabel;
     */
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.rightImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.leftName = [Factory creatLabelWithText:@"新英格兰爱国者"
                                      fontValue:font750(24)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    self.rightName = [Factory creatLabelWithText:@"休斯顿德州人"
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.leftScore = [Factory creatLabelWithText:@"13"
                                       fontValue:font750(52)
                                       textColor:UIColorFromRGBA(0xFFFFFF, 0.5)
                                   textAlignment:NSTextAlignmentCenter];
//    self.leftScore.font = [UIFont boldSystemFontOfSize:font750(52)];
    self.rightScore = [Factory creatLabelWithText:@"21"
                                        fontValue:font750(52)
                                        textColor:UIColorFromRGB(0xFFFFFF)
                                    textAlignment:NSTextAlignmentCenter];
//    self.rightScore.font = [UIFont boldSystemFontOfSize:font750(52)];
    self.vsLabel = [Factory creatLabelWithText:@"VS"
                                     fontValue:font750(24)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentCenter];
    self.gameStatus = [Factory creatLabelWithText:@"已结束"
                                        fontValue:Anno750(22)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.gameStatus.layer.cornerRadius = Anno750(20);
    self.gameStatus.layer.borderColor = UIColorFromRGBA(0xFFFFFF, 0.3).CGColor;
    self.gameStatus.layer.borderWidth = 0.5;
    self.gameStatus.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    self.gameStatus.layer.masksToBounds = YES;
    self.timeLabel = [Factory creatLabelWithText:@"13:00"
                                       fontValue:font750(52)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.timeLabel.hidden = YES;
//    self.timeLabel.font = [UIFont boldSystemFontOfSize:font750(52)];
    self.leftImg.frame = CGRectMake(Anno750(60), Anno750(160), Anno750(120), Anno750(120));
    self.rightImg.frame = CGRectMake(UI_WIDTH - Anno750(120) - Anno750(60), Anno750(160), Anno750(120), Anno750(120));
    self.leftScore.frame = CGRectMake(Anno750(240), Anno750(210), Anno750(60), Anno750(60));
    self.rightScore.frame = CGRectMake(UI_WIDTH - Anno750(300), Anno750(210), Anno750(60), Anno750(60));
    [self addSubview:self.leftImg];
    [self addSubview:self.rightImg];
    [self addSubview:self.leftScore];
    [self addSubview:self.leftName];
    [self addSubview:self.rightScore];
    [self addSubview:self.rightName];
    [self addSubview:self.vsLabel];
    [self addSubview:self.gameStatus];
    [self addSubview:self.timeLabel];
    [self.leftName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftImg.mas_centerX);
        make.top.equalTo(self.leftImg.mas_bottom).offset(Anno750(6));
    }];
    [self.rightName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightImg.mas_centerX);
        make.top.equalTo(self.leftName.mas_top);
    }];
    [self.vsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.leftScore.mas_centerY);
    }];
    [self.gameStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.leftName.mas_centerY);
        make.height.equalTo(@(Anno750(40)));
        make.width.equalTo(@(Anno750(120)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.leftScore.mas_centerY);
    }];
    
}


@end
