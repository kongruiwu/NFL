//
//  TeamHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamHeader.h"

@implementation TeamLeftSection

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_MainBlue;
    self.addressLabel = [Factory creatLabelWithText:@"位置"
                                          fontValue:font750(24)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentCenter];
    self.fristLabel = [Factory creatLabelWithText:@"首发"
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.otherLabel = [Factory creatLabelWithText:@"替补"
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    
    self.line1 = [Factory creatLineView];
    self.line2 = [Factory creatLineView];
    
    [self addSubview:self.addressLabel];
    [self addSubview:self.line1];
    [self addSubview:self.fristLabel];
    [self addSubview:self.line2];
    [self addSubview:self.otherLabel];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(64 * 2)));
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@0.5);
    }];
    [self.fristLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(180)));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fristLabel.mas_right);
        make.top.equalTo(@0);
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.left.equalTo(self.line2.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
@end

@implementation TeamRightSection

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_MainBlue;
    self.numlabel = [Factory creatLabelWithText:@"号码"
                                          fontValue:font750(24)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentCenter];
    self.nameLabel = [Factory creatLabelWithText:@"姓名"
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.addressLabel = [Factory creatLabelWithText:@"位置"
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    
    self.line1 = [Factory creatLineView];
    self.line2 = [Factory creatLineView];
    
    [self addSubview:self.numlabel];
    [self addSubview:self.line1];
    [self addSubview:self.nameLabel];
    [self addSubview:self.line2];
    [self addSubview:self.addressLabel];
    
    [self.numlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(64 * 2)));
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numlabel.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@0.5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(195 *2)));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right);
        make.top.equalTo(@0);
        make.width.equalTo(@0.5);
        make.bottom.equalTo(@0);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.left.equalTo(self.line2.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

@end


@implementation TeamHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        self.backgroundColor = Color_BackGround;
    }
    return self;
}
- (void)creatUI{
    self.segmentbtn = [[UISegmentedControl alloc]initWithItems:@[@"阵容",@"名单"]];
    self.segmentbtn.backgroundColor = [UIColor whiteColor];
    self.segmentbtn.layer.borderColor = Color_MainBlue.CGColor;
    self.segmentbtn.tintColor = Color_MainBlue;
    self.segmentbtn.layer.borderWidth = 1.0f;
    self.segmentbtn.layer.cornerRadius = Anno750(30);
    self.segmentbtn.layer.masksToBounds = YES;

    [self.segmentbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segmentbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainBlue} forState:UIControlStateNormal];
    self.segmentbtn.selectedSegmentIndex = 0;
//    [self.segmentbtn addTarget:self action:@selector(segmentbtnSelect:) forControlEvents:UIControlEventValueChanged];
    self.segmentbtn.frame = CGRectMake((UI_WIDTH - Anno750(450))/2, Anno750(30), Anno750(450), Anno750(60));
    [self addSubview:self.segmentbtn];

    self.leftSection = [[TeamLeftSection alloc]initWithFrame:CGRectMake(0, Anno750(120), UI_WIDTH, Anno750(60))];
    self.rightSection = [[TeamRightSection alloc]initWithFrame:CGRectMake(0, Anno750(120), UI_WIDTH, Anno750(60))];
    

    [self addSubview:self.leftSection];
    [self addSubview:self.rightSection];
}


@end
