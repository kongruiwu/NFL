//
//  AttionThirdView.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "AttionThirdView.h"

@implementation AttionThirdView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.hidden = YES;
    self.backgroundColor =UIColorFromRGBA(0x000000, 0);
    
    self.descLabels = [NSMutableArray new];
    self.showView = [Factory creatViewWithColor:[UIColor whiteColor]];
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = Anno750(12);
    
    self.blueImg = [Factory creatImageViewWithImage:@"bind-lanse"];
    self.nflIcon = [Factory creatImageViewWithImage:@"bind-logo"];
    self.thirdIcon = [Factory creatImageViewWithImage:@"bind-weibo"];
    self.thirdName = [Factory creatLabelWithText:@"关注微博"
                                       fontValue:font750(30)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    self.thirdName.font = [UIFont boldSystemFontOfSize:font750(30)];
    
    NSArray * descs = @[@"1.打开新浪微博，搜索并关注帐号“NFL橄榄球”;",@"2.打开私信，输入“APP微博验证”并发送，获取相应验证码;",@"3.重新在APP中打开本页面，输出获取到的验证码;",@"4.点击确认，即可完成任务。"];
    for (int i = 0; i<descs.count; i++) {
        UILabel * label = [Factory creatLabelWithText:descs[i]
                                            fontValue:font750(24)
                                            textColor:Color_LightGray
                                        textAlignment:NSTextAlignmentLeft];
        label.numberOfLines = 0;
        [self.showView addSubview:label];
        [self.descLabels addObject:label];
    }
    
    self.writeCode = [Factory creatLabelWithText:@"输入验证码"
                                       fontValue:font750(30)
                                       textColor:Color_DarkGray
                                   textAlignment:NSTextAlignmentLeft];
    
    self.codeView = [[KRCodeTextFeildView alloc]initWithFrame:CGRectMake(Anno750(50), Anno750(520), UI_WIDTH - Anno750(190), Anno750(70))];
    
    self.sureBtn = [Factory creatButtonWithTitle:@"确认"
                                 backGroundColor:Color_LightBlue
                                       textColor:[UIColor whiteColor]
                                        textSize:font750(32)];
    self.sureBtn.layer.cornerRadius = Anno750(44);
        
    self.canncleBtn = [Factory creatButtonWithNormalImage:@"bind_close" selectImage:@""];
    [self.canncleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.showView.frame = CGRectMake(Anno750(45), UI_HEGIHT, UI_WIDTH - Anno750(90), Anno750(760));
    
    [self addSubview:self.showView];
    [self.showView addSubview:self.blueImg];
    [self.showView addSubview:self.nflIcon];
    [self.showView addSubview:self.thirdName];
    [self.showView addSubview:self.thirdIcon];
    [self.showView addSubview:self.writeCode];
    [self.showView addSubview:self.codeView];
    [self.showView addSubview:self.sureBtn];
    [self addSubview:self.canncleBtn];
    
    [self.blueImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
    }];
    [self.nflIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(100)));
        make.top.equalTo(@(Anno750(70)));
    }];
    [self.thirdName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(50)));
        make.top.equalTo(@(Anno750(150)));
    }];
    [self.thirdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdName.mas_right).offset(Anno750(10));
        make.centerY.equalTo(self.thirdName.mas_centerY);
    }];
    for (int i = 0; i<self.descLabels.count; i++) {
        [self.descLabels[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.thirdName.mas_left);
            make.right.equalTo(@(-Anno750(50)));
            if (i == 0) {
                make.top.equalTo(self.nflIcon.mas_bottom).offset(Anno750(10));
            }else{
                make.top.equalTo(self.descLabels[i-1].mas_bottom).offset(Anno750(12));
            }
        }];
    }
    [self.writeCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.descLabels.lastObject.mas_bottom).offset(Anno750(35));
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-Anno750(30)));
        make.centerX.equalTo(@0);
        make.height.equalTo(@(Anno750(88)));
        make.width.equalTo(@(Anno750(260)));
    }];
    [self.canncleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.showView.mas_bottom).offset(Anno750(70));
    }];
}
- (void)show{
    self.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
       self.showView.frame = CGRectMake(Anno750(45), Anno750(190), UI_WIDTH - Anno750(90), Anno750(760));
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.4);
    }];
}
- (void)dismiss{
    [UIView animateWithDuration:0.4 animations:^{
        self.showView.frame = CGRectMake(Anno750(45), UI_HEGIHT, UI_WIDTH - Anno750(90), Anno750(760));
        self.backgroundColor = UIColorFromRGBA(0x000000, 0);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}
- (void)setThirdType:(ThirdType)thirdType{
    _thirdType = thirdType;
    
    NSString * imgName = _thirdType == ThirdTypeSina ? @"bind-weibo" : @"bind-weixin";
    self.thirdIcon.image = [UIImage imageNamed:imgName];
    self.thirdName.text = _thirdType == ThirdTypeSina ? @"关注微博" :@"关注微信";
    NSArray * descs ;
    if (_thirdType == ThirdTypeSina) {
       descs = @[@"1.打开新浪微博，搜索并关注帐号“NFL橄榄球”;",@"2.打开私信，输入“APP微博验证”并发送，获取相应验证码;",@"3.重新在APP中打开本页面，输出获取到的验证码;",@"4.点击确认，即可完成任务。"];
    }else{
        descs = @[@"1.打开微信，搜索并关注公众号“NFL橄榄球”;",@"2.打开私信，输入“APP微信验证”并发送，获取相应验证码;",@"3.重新在APP中打开本页面，输出获取到的验证码;",@"4.点击确认，即可完成任务。"];
    }
    for (int i = 0; i<self.descLabels.count; i++) {
        self.descLabels[i].text = descs[i];
    }
    [self.codeView clearText];
}


@end
