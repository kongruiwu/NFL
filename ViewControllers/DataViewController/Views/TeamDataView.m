//
//  TeamDataView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamDataView.h"

@implementation TeamDataView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.scoreLabel = [self creatDescLabel:@"进攻得分" textAlignment:NSTextAlignmentRight];
    self.scoreValue = [self creatValueLabel:@"26.1" textAlignment:NSTextAlignmentRight];
    
    self.passLabel = [self creatDescLabel:@"传球码数" textAlignment:NSTextAlignmentLeft];
    self.passValue = [self creatValueLabel:@"238" textAlignment:NSTextAlignmentLeft];
    
    self.runLabel = [self creatDescLabel:@"跑球码数" textAlignment:NSTextAlignmentRight];
    self.runValue = [self creatValueLabel:@"112" textAlignment:NSTextAlignmentRight];
    
    self.defenPassLabel = [self creatDescLabel:@"防传码数" textAlignment:NSTextAlignmentRight];
    self.defenPassValue = [self creatValueLabel:@"202" textAlignment:NSTextAlignmentRight];
    
    self.defenseLabel = [self creatDescLabel:@"防守失分" textAlignment:NSTextAlignmentLeft];
    self.defenseValue = [self creatValueLabel:@"18.7" textAlignment:NSTextAlignmentLeft];
    
    self.defenRunLabel = [self creatDescLabel:@"防跑码数" textAlignment:NSTextAlignmentLeft];
    self.defenRunValue = [self creatValueLabel:@"154" textAlignment:NSTextAlignmentLeft];
    
    self.redDesc = [self creatDescLabel:@"该参数联盟排名" textAlignment:NSTextAlignmentLeft];
    self.blueDesc = [self creatDescLabel:@"该参数当前数据" textAlignment:NSTextAlignmentLeft];
    self.redView = [Factory creatViewWithColor:[UIColor redColor]];
    self.blueView = [Factory creatViewWithColor:Color_MainBlue];
    
    [self addSubview:self.scoreValue];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.passValue];
    [self addSubview:self.passLabel];
    [self addSubview:self.runValue];
    [self addSubview:self.runLabel];
    [self addSubview:self.defenPassValue];
    [self addSubview:self.defenPassLabel];
    [self addSubview:self.defenseValue];
    [self addSubview:self.defenseLabel];
    [self addSubview:self.defenRunValue];
    [self addSubview:self.defenRunLabel];
    [self addSubview:self.redView];
    [self addSubview:self.blueView];
    [self addSubview:self.redDesc];
    [self addSubview:self.blueDesc];
    
    //中点
    CGPoint centerPoint = CGPointMake(UI_WIDTH/2, Anno750(310));
    //左上
    CGPoint leftUp = CGPointMake(Anno750(275), Anno750(130));
    //右上
    CGPoint righUp = CGPointMake(UI_WIDTH - Anno750(275), Anno750(130));
    //左
    CGPoint leftPoint = CGPointMake(Anno750(170), Anno750(310));
    //右
    CGPoint rightPoint = CGPointMake(UI_WIDTH - Anno750(170), Anno750(310));
    //左下
    CGPoint leftDown = CGPointMake(leftUp.x, centerPoint.y + Anno750(310 - 130));
    //右下
    CGPoint rightDown = CGPointMake(righUp.x, leftDown.y);

    //外部圆
    UIBezierPath * externalPath = [UIBezierPath bezierPath];
    [externalPath moveToPoint:leftUp];
    [externalPath addLineToPoint:righUp];
    [externalPath addLineToPoint:rightPoint];
    [externalPath addLineToPoint:rightDown];
    [externalPath addLineToPoint:leftDown];
    [externalPath addLineToPoint:leftPoint];
    [externalPath closePath];
    
//    externalPath.lineWidth = 1.0f;
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, UI_WIDTH,self.frame.size.height);
    layer.strokeColor = Color_DarkGray.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = externalPath.CGPath;
    layer.lineWidth = 1.0f;
    [self.layer addSublayer:layer];
    
    //内部直线
    UIBezierPath * leftSlashPath = [UIBezierPath bezierPath];
    [leftSlashPath moveToPoint:leftUp];
    [leftSlashPath addLineToPoint:rightDown];
    CAShapeLayer * leftSlashLayer = [CAShapeLayer layer];
    leftSlashLayer.frame = layer.frame;
    leftSlashLayer.strokeColor = Color_LightGray.CGColor;
    leftSlashLayer.fillColor = [UIColor clearColor].CGColor;
    leftSlashLayer.path = leftSlashPath.CGPath;
    leftSlashLayer.lineWidth = 0.5;
    [self.layer addSublayer:leftSlashLayer];
    
    UIBezierPath * rightSlashPath = [UIBezierPath bezierPath];
    [rightSlashPath moveToPoint:righUp];
    [rightSlashPath addLineToPoint:leftDown];
    CAShapeLayer * rightSlashLayer = [CAShapeLayer layer];
    rightSlashLayer.frame = layer.frame;
    rightSlashLayer.strokeColor = Color_LightGray.CGColor;
    rightSlashLayer.fillColor = [UIColor clearColor].CGColor;
    rightSlashLayer.path = rightSlashPath.CGPath;
    rightSlashLayer.lineWidth = 0.5;
    [self.layer addSublayer:rightSlashLayer];
    
    UIBezierPath * centerPath = [UIBezierPath bezierPath];
    [centerPath moveToPoint:leftPoint];
    [centerPath addLineToPoint:rightPoint];
    CAShapeLayer * centerLayer = [CAShapeLayer layer];
    centerLayer.frame = layer.frame;
    centerLayer.strokeColor = Color_LightGray.CGColor;
    centerLayer.fillColor = [UIColor clearColor].CGColor;
    centerLayer.path = centerPath.CGPath;
    centerLayer.lineWidth = 0.5;
    [self.layer addSublayer:centerLayer];
    
    for (int i = 1; i<4; i++) {
        CGPoint left_up = CGPointMake(leftUp.x + (centerPoint.x - leftUp.x)/3 * i, leftUp.y + (centerPoint.y - leftUp.y)/3 * i);
        CGPoint righ_up = CGPointMake(righUp.x - (righUp.x - centerPoint.x)/3 * i, left_up.y);
        CGPoint leftP = CGPointMake(leftPoint.x + (centerPoint.x - leftPoint.x)/3 * i, centerPoint.y);
        CGPoint righP = CGPointMake(rightPoint.x - (rightPoint.x - centerPoint.x)/3 * i , centerPoint.y);
        CGPoint left_down = CGPointMake(left_up.x, leftDown.y - (leftDown.y - centerPoint.y)/3 * i);
        CGPoint righ_down = CGPointMake(righ_up.x, left_down.y);
        
        //内部环线
        UIBezierPath * insidePath = [UIBezierPath bezierPath];
        [insidePath moveToPoint:left_up];
        [insidePath addLineToPoint:righ_up];
        [insidePath addLineToPoint:righP];
        [insidePath addLineToPoint:righ_down];
        [insidePath addLineToPoint:left_down];
        [insidePath addLineToPoint:leftP];
        [insidePath closePath];
        
        CAShapeLayer * insidelayer = [CAShapeLayer layer];
        insidelayer.frame = CGRectMake(0, 0, UI_WIDTH,self.frame.size.height);
        insidelayer.strokeColor = Color_LightGray.CGColor;
        insidelayer.fillColor = [UIColor clearColor].CGColor;
        insidelayer.path = insidePath.CGPath;
        insidelayer.lineWidth = 0.5f;
        [self.layer addSublayer:insidelayer];
        
    }
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.scoreValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(515)));
        make.top.equalTo(@(Anno750(100)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreValue.mas_bottom).offset(Anno750(5));
        make.right.equalTo(self.scoreValue.mas_right);
    }];
    
    [self.runValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-600)));
        make.top.equalTo(@(Anno750(280)));
    }];
    [self.runLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.runValue.mas_right);
        make.top.equalTo(self.runValue.mas_bottom).offset(Anno750(5));
    }];
    
    [self.defenPassValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scoreValue.mas_right);
        make.top.equalTo(@(Anno750(460)));
    }];
    [self.defenPassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scoreValue.mas_right);
        make.top.equalTo(self.defenPassValue.mas_bottom).offset(Anno750(5));
    }];
    
    [self.passValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreValue.mas_top);
        make.left.equalTo(@(Anno750(520)));
    }];
    [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passValue.mas_left);
        make.top.equalTo(self.passValue.mas_bottom).offset(Anno750(5));
    }];
    
    [self.defenseValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(600)));
        make.top.equalTo(self.runValue.mas_top);
    }];
    [self.defenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.defenseValue.mas_left);
        make.top.equalTo(self.defenseValue.mas_bottom).offset(Anno750(5));
    }];
    
    [self.defenRunValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passValue.mas_left);
        make.top.equalTo(self.defenPassValue.mas_top);
    }];
    [self.defenRunLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.defenRunValue.mas_left);
        make.top.equalTo(self.defenRunValue.mas_bottom).offset(Anno750(5));
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(150)));
        make.bottom.equalTo(@(-Anno750(90)));
        make.width.equalTo(@(Anno750(24)));
        make.height.equalTo(@(Anno750(24)));
    }];
    [self.redDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redView.mas_right).offset(Anno750(15));
        make.centerY.equalTo(self.redView.mas_centerY);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.redDesc.mas_right).offset(Anno750(40));
        make.centerY.equalTo(self.redView.mas_centerY);
        make.height.equalTo(@(Anno750(24)));
        make.width.equalTo(@(Anno750(24)));
    }];
    [self.blueDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.blueView.mas_right).offset(Anno750(15));
        make.centerY.equalTo(self.redView.mas_centerY);
    }];
}

- (UILabel *)creatDescLabel:(NSString *)name textAlignment:(NSTextAlignment)alignment{
    UILabel * label = [Factory creatLabelWithText:name
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:alignment];
    return label;
}
- (UILabel *)creatValueLabel:(NSString *)value textAlignment:(NSTextAlignment)alignment{
    UILabel * label = [Factory creatLabelWithText:value
                                        fontValue:font750(26)
                                        textColor:Color_MainBlue
                                    textAlignment:alignment];
    label.font = [UIFont boldSystemFontOfSize:font750(27)];
    return label;
}
@end