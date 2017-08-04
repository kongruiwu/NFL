//
//  FeedBackViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView * textView;
@property (nonatomic, strong) UILabel * placeLabel;
@property (nonatomic, strong) UITextField * mailTextf;
@property (nonatomic, strong) UIButton * sendBtn;

@end

@implementation FeedBackViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"意见反馈"];
    [self creatUI];
}
- (void)creatUI{
    
    UIView * topView = [Factory creatViewWithColor:[UIColor whiteColor]];
    self.textView = [[UITextView alloc]init];
    self.textView.delegate = self;
    self.textView.font = [UIFont systemFontOfSize:font750(28)];
    self.placeLabel = [Factory creatLabelWithText:@"问题描述／意见反馈"
                                        fontValue:font750(28)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentLeft];
    UIView * lineView = [Factory creatLineView];
    UIView * whiteView = [Factory creatViewWithColor:[UIColor whiteColor]];
    UILabel * emailLabel = [Factory creatLabelWithText:@"邮箱"
                                             fontValue:font750(28)
                                             textColor:Color_MainBlack
                                         textAlignment:NSTextAlignmentLeft];
    self.mailTextf = [Factory creatTextFiledWithPlaceHold:@"请输入您的邮箱地址，方便以后联系"];
    self.sendBtn = [Factory creatButtonWithTitle:@"确认发送"
                                 backGroundColor:Color_MainBlue
                                       textColor:[UIColor whiteColor]
                                        textSize:font750(34)];
    self.sendBtn.layer.cornerRadius = Anno750(8);
    [self.sendBtn addTarget:self action:@selector(sendMessageRequest) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:topView];
    [topView addSubview:self.textView];
    [topView addSubview:self.placeLabel];
    [self.view addSubview:lineView];
    [self.view addSubview:whiteView];
    [whiteView addSubview:emailLabel];
    [whiteView addSubview:self.mailTextf];
    [self.view addSubview:self.sendBtn];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(400)));
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(20)));
        make.right.equalTo(@(Anno750(-24)));
        make.bottom.equalTo(@(-Anno750(20)));
    }];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(33)));
        make.top.equalTo(@(Anno750(35)));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.textView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(lineView.mas_bottom);
        make.height.equalTo(@(Anno750(100)));
    }];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.mailTextf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.centerY.equalTo(@0);
        make.right.equalTo(@(Anno750(-24)));
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteView.mas_bottom).offset(Anno750(40));
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@(Anno750(88)));
    }];
    
    
}
- (void)textViewDidChange:(UITextView *)textView{
    self.placeLabel.hidden = textView.text.length > 0 ? YES : NO;
}
- (void)sendMessageRequest{
    [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"问题反馈成功，请耐心等待回复" duration:1.0f];
}
@end
