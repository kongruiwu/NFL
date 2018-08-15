//
//  SignInHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "SignInHeader.h"

@implementation SignInHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    self.centerView = [Factory creatViewWithColor:Color_MainBlue];
    self.centerView.layer.cornerRadius = Anno750(280/2);
    self.centerView.layer.masksToBounds = YES;
    NSArray * colors = @[(__bridge id)UIColorFromRGB(0x1FACFF).CGColor , (__bridge id)UIColorFromRGB(0x027AFF).CGColor];
    CAGradientLayer * centerLayer = [CAGradientLayer layer];
    centerLayer.frame = CGRectMake(0, 0, Anno750(280), Anno750(280));
    centerLayer.colors = colors;
    centerLayer.startPoint = CGPointMake(0, 0);
    centerLayer.endPoint =CGPointMake(0, 1);
    [self.centerView.layer addSublayer:centerLayer];
    

    CAShapeLayer * circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0,0, Anno750(310), Anno750(310));
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = Color_MainBlue.CGColor;
    circleLayer.lineWidth = Anno750(2);
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(Anno750(1), Anno750(1), Anno750(308), Anno750(308))];
    circleLayer.path= path.CGPath;
    path.lineWidth = Anno750(2);
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    CAGradientLayer * circleGraid = [CAGradientLayer layer];
    circleGraid.colors = colors;
    circleGraid.startPoint = CGPointMake(0, 0);
    circleGraid.endPoint =CGPointMake(0, 1);
    circleGraid.frame =  CGRectMake(self.frame.size.width/2 - Anno750(310/2) , self.frame.size.height/2 - Anno750(310/2) , Anno750(310), Anno750(310));
    [self.layer addSublayer:circleGraid];
    circleGraid.mask = circleLayer;
    
    self.titleLabel = [Factory creatLabelWithText:@"当前积分"
                                        fontValue:font750(34)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.scoreLabel = [Factory creatLabelWithText:@"209"
                                        fontValue:font750(64)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    
    self.signIBtn = [Factory creatButtonWithTitle:@"签到领积分"
                                  backGroundColor:[UIColor clearColor]
                                        textColor:Color_LightBlue
                                         textSize:font750(30)];
    [self.signIBtn setTitleColor:Color_LightGray forState:UIControlStateDisabled];
    [self.signIBtn setTitle:@"已签到" forState:UIControlStateDisabled];
    self.signIBtn.layer.cornerRadius = Anno750(30);
    self.signIBtn.layer.borderColor = Color_LightBlue.CGColor;
    self.signIBtn.layer.borderWidth = 1.0f;
    
    
    [self addSubview:self.centerView];
    [self.centerView addSubview:self.titleLabel];
    [self.centerView addSubview:self.scoreLabel];
    [self addSubview:self.signIBtn];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(280)));
        make.height.equalTo(@(Anno750(280)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(75)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(25));
    }];
    [self.signIBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.centerView.mas_bottom).offset(Anno750(50));
        make.width.equalTo(@(Anno750(220)));
        make.height.equalTo(@(Anno750(60)));
    }];
    
}

- (void)updateScore{
    self.scoreLabel.text = [NSString stringWithFormat:@"%@",[UserManager manager].score.score_season];
    if ([UserManager manager].score.signInTask.completed) {
        self.signIBtn.layer.borderColor = Color_LightGray.CGColor;
        self.signIBtn.enabled = NO;
    }else{
        self.signIBtn.enabled = YES;
        self.signIBtn.layer.borderColor = Color_LightBlue.CGColor;
    }
}

@end
