//
//  GameHeaderView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameHeaderView.h"

@implementation GameHeaderView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUIwithTitle:titles];
    }
    return self;
}
- (void)creatUIwithTitle:(NSArray *)titles{

    self.blueImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.blueImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_big"];
    self.groundImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.blueImg];
    [self addSubview:self.groundImg];
    
    self.segmentView = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    self.segmentView.backgroundColor = [UIColor clearColor];
    self.segmentView.frame = CGRectMake(0, self.frame.size.height - Anno750(80), UI_WIDTH, Anno750(80));
    self.segmentView.titleTextAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                             NSForegroundColorAttributeName : Color_White_5};
    self.segmentView.selectedTitleTextAttributes = @{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView.selectionIndicatorHeight = Anno750(6);
    self.segmentView.selectionIndicatorColor = Color_HsmRed;
    [self addSubview:self.segmentView];
    
    self.videoButton = [Factory creatButtonWithTitle:@"  点击观看视频直播"
                                     backGroundColor:[UIColor clearColor]
                                           textColor:[UIColor whiteColor]
                                            textSize:font750(22)];
    [self.videoButton setImage:[UIImage imageNamed:@"content_icon_video_normal"] forState:UIControlStateNormal];
    self.videoButton.hidden = YES;
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.rightImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.leftName = [Factory creatLabelWithText:@""
                                      fontValue:font750(24)
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentCenter];
    self.rightName = [Factory creatLabelWithText:@""
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.leftScore = [Factory creatLabelWithText:@""
                                       fontValue:font750(48)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.rightScore = [Factory creatLabelWithText:@""
                                        fontValue:font750(48)
                                        textColor:UIColorFromRGB(0xFFFFFF)
                                    textAlignment:NSTextAlignmentCenter];
    self.vsLabel = [Factory creatLabelWithText:@"VS"
                                     fontValue:font750(24)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentCenter];
    self.gameStatus = [Factory creatLabelWithText:@""
                                        fontValue:Anno750(22)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.gameStatus.layer.cornerRadius = Anno750(20);
    self.gameStatus.layer.borderColor = Color_White_5.CGColor;
    self.gameStatus.layer.borderWidth = 0.5;
    self.gameStatus.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    self.gameStatus.layer.masksToBounds = YES;
    self.timeLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(52)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
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
    [self addSubview:self.videoButton];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.leftImg.mas_top);
    }];
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
- (void)updateWithMatchLiveViewModel:(LiveViewModel *)model{
    self.leftName.text = model.visitor_name;
    self.rightName.text = model.home_name;
    self.leftImg.image =[Factory getImageWithNumer:model.visitor_teamId white:NO];
    self.rightImg.image =[Factory getImageWithNumer:model.home_teamId white:NO];
    switch ([model.match_state intValue]) {
        case 0://未开始
        {
            self.gameStatus.backgroundColor = Color_TagBlue;
            self.gameStatus.layer.borderColor = [UIColor clearColor].CGColor;
            self.gameStatus.text = @"比赛前瞻";
            self.leftScore.text = @"";
            self.rightScore.text = @"";
            self.timeLabel.text = [Factory timestampSwitchWithHourStyleTime:[model.time integerValue]];
            self.videoButton.hidden = YES;
            self.vsLabel.hidden = YES;
        }
            break;
        case 1://正在进行
        {
            self.gameStatus.backgroundColor = Color_MainRed;
            self.gameStatus.layer.borderColor = [UIColor clearColor].CGColor;
            self.gameStatus.text = @"进行中";
            self.leftScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
            self.rightScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
            self.timeLabel.text = @"";
            self.videoButton.hidden = NO;
            self.vsLabel.hidden = NO;
            if ([model.home_scores intValue] > [model.visitor_scores intValue]) {
                self.leftScore.textColor = Color_White_5;
            }else if([model.home_scores intValue] < [model.visitor_scores intValue]){
                self.rightScore.textColor = Color_White_5;
            }
        }
            break;
        case 2://已结束
        {
            self.gameStatus.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
            self.gameStatus.text = @"已结束";
            self.gameStatus.layer.borderColor = Color_White_3.CGColor;
            self.leftScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
            self.rightScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
            if ([model.home_scores intValue] > [model.visitor_scores intValue]) {
                self.leftScore.textColor = Color_White_5;
            }else if([model.home_scores intValue] < [model.visitor_scores intValue]){
                self.rightScore.textColor = Color_White_5;
            }
            self.timeLabel.text = @"";
            self.videoButton.hidden = YES;
            self.vsLabel.hidden = NO;
            
        }
            break;
        default:
            break;
    }
    if (model.page_list.count>= 3) {
        self.segmentView.sectionTitles = @[model.page_list[0].title,model.page_list[1].title,model.page_list[2].title];
    }
    
}

@end
