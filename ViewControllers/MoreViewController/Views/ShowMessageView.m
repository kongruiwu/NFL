//
//  ShowMessageView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ShowMessageView.h"

@implementation ShowMessageView

- (instancetype)initWithFrame:(CGRect)frame MessageType:(MessageType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.messageType = type;
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    self.showView = [Factory creatViewWithColor:[UIColor whiteColor]];
    float heigh ;
    switch (self.messageType) {
        case MessageTypeSex:
            heigh = Anno750(184 * 2);
            break;
        case MessageTypeTeam:
            heigh = Anno750(138 * 2);
            break;
        case MessageTypeBrithday:
            heigh = Anno750(234 * 2);
        default:
            break;
    }
    self.showView.frame = CGRectMake(Anno750(50), UI_HEGIHT, UI_WIDTH - Anno750(100), heigh);
    [self addSubview:self.showView];
    
    self.topBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    self.bottomBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    
    [self addSubview:self.topBtn];
    [self addSubview:self.bottomBtn];
    self.topBtn.frame = CGRectMake(0, 0, UI_WIDTH, (UI_HEGIHT - heigh)/2 - Anno750(200));
    self.bottomBtn.frame = CGRectMake(0, self.topBtn.frame.size.height + heigh, UI_WIDTH, (UI_HEGIHT - heigh)/2);
    [self.topBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (self.messageType != MessageTypeTeam) {
        NSString * title = self.messageType == MessageTypeBrithday ? @"选择您的生日" : @"选择性别" ;
        self.titleLabel = [Factory creatLabelWithText:title
                                            fontValue:font750(34)
                                            textColor:[UIColor whiteColor]
                                        textAlignment:NSTextAlignmentCenter];
        self.titleLabel.backgroundColor = Color_MainBlue;
        
        [self.showView addSubview:self.titleLabel];
        
        if (self.messageType == MessageTypeSex) {
            self.menButton = [Factory creatButtonWithTitle:@"男"
                                           backGroundColor:[UIColor whiteColor]
                                                 textColor:Color_MainBlack
                                                  textSize:font750(28)];
            self.womButton = [Factory creatButtonWithTitle:@"女"
                                           backGroundColor:[UIColor whiteColor]
                                                 textColor:Color_MainBlack
                                                  textSize:font750(28)];
            [self.menButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.womButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            self.topLine = [Factory creatLineView];
            
            [self.showView addSubview:self.menButton];
            [self.showView addSubview:self.womButton];
            [self.showView addSubview:self.topLine];
        }else{
            self.datePicker = [[UIDatePicker alloc]init];
            self.datePicker.datePickerMode = UIDatePickerModeDate;
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中
            self.datePicker.locale = locale;
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDate *currentDate = [NSDate date];
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setYear:0];//设置最大时间为：当前时间推后十年
            NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [comps setYear:-100];//设置最小时间为：当前时间前推十年
            NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
            [self.datePicker setMaximumDate:maxDate];
            [self.datePicker setMinimumDate:minDate];
            [self.showView addSubview:self.datePicker];
        }
        
    }else{
        self.setTeam = [Factory creatButtonWithTitle:@"是否设置“卡罗莱纳黑豹”成为你的主队"
                                     backGroundColor:[UIColor whiteColor]
                                           textColor:Color_MainBlack
                                            textSize:font750(28)];
        
        [self.setTeam addTarget:self action:@selector(checkWeiBoDetail) forControlEvents:UIControlEventTouchUpInside];
        self.teamDesc = [Factory creatLabelWithText:@"(点击蓝字可跳转到该球队官方微博)"
                                          fontValue:font750(28)
                                          textColor:Color_LightGray
                                      textAlignment:NSTextAlignmentCenter];
        [self.showView addSubview:self.setTeam];
        [self.showView addSubview:self.teamDesc];
    
    }
    
    self.bottomLine = [Factory creatLineView];
    self.sureButton = [Factory creatButtonWithTitle:@"确认"
                                    backGroundColor:[UIColor whiteColor]
                                          textColor:UIColorFromRGB(0xE31837)
                                           textSize:font750(28)];
    self.centerLine = [Factory creatLineView];
    self.cannceBtn  = [Factory creatButtonWithTitle:@"取消"
                                    backGroundColor:[UIColor whiteColor]
                                          textColor:Color_LightGray
                                           textSize:font750(28)];
    [self.cannceBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [self.sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.showView addSubview:self.sureButton];
    [self.showView addSubview:self.cannceBtn];
    [self.showView addSubview:self.bottomLine];
    [self.showView addSubview:self.centerLine];
    
    self.showView.layer.cornerRadius = Anno750(10);
    self.showView.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(Anno750(326)));
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.height.equalTo(@(Anno750(44 * 2)));
    }];
    [self.cannceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(Anno750(326)));
        make.bottom.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(Anno750(44 * 2)));
    }];
    [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.height.equalTo(@(Anno750(44 * 2)));
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.centerLine.mas_top);
    }];
    
    if (self.messageType != MessageTypeTeam) {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.height.equalTo(@(Anno750(40 * 2)));
            make.right.equalTo(@0);
            make.top.equalTo(@0);
        }];
    }
    
    if (self.messageType == MessageTypeSex) {
        [self.menButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.height.equalTo(@(Anno750(50 * 2)));
            make.right.equalTo(@0);
        }];
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.menButton.mas_bottom);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
        [self.womButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(self.bottomLine.mas_top);
            make.top.equalTo(self.topLine.mas_bottom);
        }];
    }else if(self.messageType == MessageTypeBrithday){
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom);
            make.bottom.equalTo(self.bottomLine.mas_top);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
        }];
    }else if(self.messageType == MessageTypeTeam){
        [self.setTeam mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@(Anno750(50)));
        }];
        [self.teamDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(self.setTeam.mas_bottom).offset(Anno750(10));
        }];
    }
    
}
- (void)show{
    float heigh ;
    switch (self.messageType) {
        case MessageTypeSex:
            heigh = Anno750(184 * 2);
            break;
        case MessageTypeTeam:
            heigh = Anno750(138 * 2);
            break;
        case MessageTypeBrithday:
            heigh = Anno750(234 * 2);
        default:
            break;
    }
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.showView.frame = CGRectMake(Anno750(50), (UI_HEGIHT - heigh)/2 - Anno750(200), UI_WIDTH - Anno750(100), heigh);
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.8);
    }];
}
- (void)dismiss{
    float heigh ;
    switch (self.messageType) {
        case MessageTypeSex:
            heigh = Anno750(184 * 2);
            break;
        case MessageTypeTeam:
            heigh = Anno750(138 * 2);
            break;
        case MessageTypeBrithday:
            heigh = Anno750(234 * 2);
        default:
            break;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.showView.frame = CGRectMake(Anno750(50), UI_HEGIHT + Anno750(200), UI_WIDTH - Anno750(100), heigh);
        self.backgroundColor = [UIColor clearColor];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}

//- (void)sureButtonClick:(UIButton *)button{
//    if ([self.delegate respondsToSelector:@selector(UserClickSureButtonWithType:)]) {
//        [self.delegate UserClickSureButtonWithType:self.messageType];
//    }
//    [self dismiss];
//}

- (void)checkWeiBoDetail{
    
}

- (void)setHomeTeam:(HomeTeam *)homeTeam{
    _homeTeam = homeTeam;
    [self updateWithTeamName:homeTeam.team_name];
}

- (void)updateWithTeamName:(NSString *)teamName{
    NSString * string = [NSString stringWithFormat:@"是否设置“%@”成为你的主队",teamName];
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:string];
    [attstr addAttribute:NSForegroundColorAttributeName value:Color_MainBlue range:NSMakeRange(4, teamName.length + 2)];
    [self.setTeam setAttributedTitle:attstr forState:UIControlStateNormal];
}
- (void)sexButtonClick:(UIButton *)btn{
    self.gender = btn.titleLabel.text;
    btn.backgroundColor = Color_BackGround;
    UIButton * btn1 = btn == self.menButton ? self.womButton : self.menButton;
    btn1.backgroundColor = [UIColor clearColor];
}

@end
