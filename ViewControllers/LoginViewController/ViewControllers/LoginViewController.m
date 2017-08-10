//
//  LoginViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LoginViewController.h"
#import "PhoneAboutViewController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface LoginViewController ()

@property (nonatomic, strong) UITextField * phoneNum;
@property (nonatomic, strong) UITextField * pwdTF;
@property (nonatomic, strong) UIButton * loginBtn;
@property (nonatomic, strong) UIButton * forgotBtn;
@property (nonatomic, strong) UIButton * regisBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"登录"];
    [self creatUI];
}
- (void)creatUI{
    self.backType = SelectorBackTypeDismiss;
    
    UIView * whiteView = [Factory creatViewWithColor:[UIColor whiteColor]];
    UIView * whiteView2 = [Factory creatViewWithColor:[UIColor whiteColor]];
    UILabel * accountLabel = [Factory creatLabelWithText:@"帐号"
                                               fontValue:font750(28)
                                               textColor:Color_MainBlack
                                           textAlignment:NSTextAlignmentLeft];
    UILabel * pwdLabel = [Factory creatLabelWithText:@"密码"
                                           fontValue:font750(28)
                                           textColor:Color_MainBlack
                                       textAlignment:NSTextAlignmentLeft];
    self.phoneNum = [Factory creatTextFiledWithPlaceHold:@"用户名/手机号"];
    self.pwdTF = [Factory creatTextFiledWithPlaceHold:@"请输入登录密码"];
    UIView * line = [Factory creatLineView];
    
    self.loginBtn = [Factory creatButtonWithTitle:@"登录"
                                  backGroundColor:Color_MainBlue
                                        textColor:[UIColor whiteColor]
                                         textSize:font750(34)];
    self.loginBtn.layer.cornerRadius = Anno750(8);
    
    self.regisBtn = [Factory creatButtonWithTitle:@"注册帐号"
                                  backGroundColor:[UIColor clearColor]
                                        textColor:Color_MainBlue
                                         textSize:font750(28)];
    self.forgotBtn = [Factory creatButtonWithTitle:@"忘记密码？"
                                   backGroundColor:[UIColor clearColor]
                                         textColor:Color_LightGray
                                          textSize:font750(28)];
    UIView * centerLine = [Factory creatLineView];
    UILabel * thirdLabel = [Factory creatLabelWithText:@"第三方帐号登录"
                                             fontValue:font750(24)
                                             textColor:Color_LightGray
                                         textAlignment:NSTextAlignmentCenter];
    thirdLabel.backgroundColor = Color_BackGround;
    UIButton * wehcatBtn = [Factory creatButtonWithNormalImage:@"login_icon_wechat" selectImage:@""];
    UIButton * QQbtn = [Factory creatButtonWithNormalImage:@"login_icon_qq" selectImage:@""];
    UIButton * weiBoBtn = [Factory creatButtonWithNormalImage:@"login_icon_weibo" selectImage:@""];
    [wehcatBtn addTarget:self action:@selector(WeChatLoginRequest) forControlEvents:UIControlEventTouchUpInside];
    [QQbtn addTarget:self action:@selector(QQloginRequest) forControlEvents:UIControlEventTouchUpInside];
    [weiBoBtn addTarget:self action:@selector(SinaLoginRequest) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * protocolBtn = [Factory creatButtonWithTitle:@"登录即表示你同意NFL中国《用户使用协议》"
                                           backGroundColor:[UIColor clearColor]
                                                 textColor:Color_LightGray
                                                  textSize:font750(24)];
    NSString * proName = @"《用户使用协议》";
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"登录即表示你同意NFL中国%@",proName]];
    [attstr addAttribute:NSForegroundColorAttributeName value:Color_MainBlue range:NSMakeRange(13, proName.length)];
    [protocolBtn setAttributedTitle:attstr forState:UIControlStateNormal];
    
    [self.view addSubview:whiteView];
    [self.view addSubview:whiteView2];
    [whiteView addSubview:accountLabel];
    [whiteView addSubview:self.phoneNum];
    [self.view addSubview:line];
    [whiteView2 addSubview:pwdLabel];
    [whiteView2 addSubview:self.pwdTF];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.forgotBtn];
    [self.view addSubview:self.regisBtn];
    [self.view addSubview:centerLine];
    [self.view addSubview:thirdLabel];
    [self.view addSubview:wehcatBtn];
    [self.view addSubview:QQbtn];
    [self.view addSubview:weiBoBtn];
    [self.view addSubview:protocolBtn];
    
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(100)));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(whiteView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [whiteView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(line.mas_bottom);
        make.height.equalTo(@(Anno750(100)));
    }];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [pwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(Anno750(-24)));
        make.top.equalTo(whiteView2.mas_bottom).offset(Anno750(40));
        make.height.equalTo(@(Anno750(88)));
    }];
    
    [self.forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(self.loginBtn.mas_bottom).offset(Anno750(20));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(self.loginBtn.mas_bottom).offset(Anno750(20));
        make.height.equalTo(@(Anno750(60)));
    }];
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@1);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(Anno750(86 * 2));
    }];
    [thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(centerLine.mas_centerY);
        make.width.equalTo(@(Anno750(200)));
        make.centerX.equalTo(@0);
    }];
    [wehcatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(58 *2)));
        make.top.equalTo(thirdLabel.mas_bottom).offset(Anno750(48));
        make.height.equalTo(@(Anno750(80)));
        make.width.equalTo(@(Anno750(80)));
    }];
    [QQbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(wehcatBtn.mas_top);
        make.height.equalTo(@(Anno750(80)));
        make.width.equalTo(@(Anno750(80)));
    }];
    [weiBoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(116)));
        make.top.equalTo(wehcatBtn.mas_top);
        make.height.equalTo(@(Anno750(80)));
        make.width.equalTo(@(Anno750(80)));
    }];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(Anno750(-60)));
        make.centerX.equalTo(@0);
    }];
    
    
    [self.forgotBtn addTarget:self action:@selector(userForgotPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.regisBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
}
- (void)userForgotPwd{
    PhoneAboutViewController * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeFindPwd];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)userRegister{
    PhoneAboutViewController * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeRegister];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 三方登录
- (void)QQloginRequest{
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}
- (void)WeChatLoginRequest{
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}
- (void)SinaLoginRequest{
    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
}
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error && error.description.length>0) {
            return ;
        }
        NSLog(@"%@",result);
        NSString * type;
        UMSocialUserInfoResponse * resp = result;
        if (platformType == UMSocialPlatformType_QQ) {
            type = @"qq";
        }else if(platformType == UMSocialPlatformType_WechatSession){
            type = @"weixin";
        }else if(platformType == UMSocialPlatformType_Sina){
            type = @"weibo";
        }
        
        
        NSDictionary * params = @{
                                  @"type":type,
                                  @"openid":resp.openid,
                                  };
        [[NetWorkManger manager] sendRequest:Page_CheckOauth route:Route_User withParams:params complete:^(NSDictionary *result) {
            NSDictionary * dic = result[@"data"];
            [[UserManager manager] updateUserInfo:dic];
            [self doBack];
        } error:^(NFError *byerror) {
            if ([byerror.errorCode isEqualToString:@"-1"] || [byerror.errorCode isEqualToString:@"-2"]) {
                PhoneAboutViewController * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeOverThirdInfo];
                vc.thirdType = type;
                vc.thirdResp = resp;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"网络错误，请重试" duration:1.0f];
            }
        }];
    }];
}
#pragma mark


@end
