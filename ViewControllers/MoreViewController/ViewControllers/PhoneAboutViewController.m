//
//  PhoneAboutViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhoneAboutViewController.h"
#import "TextFieldCell.h"
#import "ErrorMessageCell.h"
@interface PhoneAboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;

@property (nonatomic, strong) UITextField * phoneNumber;
@property (nonatomic, strong) UITextField * codeTextF;
@property (nonatomic, strong) UITextField * nameTextF;
@property (nonatomic, strong) UITextField * oldPwd;
@property (nonatomic, strong) UITextField * pwdTextF;
@property (nonatomic, strong) UITextField * checkPwd;

@property (nonatomic, strong) NSString * errorMessage;
@property (nonatomic, strong) UIButton * overButton;
@property (nonatomic, strong) UIButton * getCode;

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * placeHolders;

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic) int time;

@end


@implementation PhoneAboutViewController

- (instancetype)initWithType:(ChangeType)changeType{
    self = [super init];
    if (self) {
        self.vcType = changeType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * title;
    switch (self.vcType) {
        case ChangeTypeBindPhone:
            title = @"绑定手机";
            break;
        case ChangeTypeChangePhone:
            title = @"修改手机";
            break;
        case ChangeTypeChangePwd:
        case ChangeTypeFindToChangePwd:
            title = @"修改密码";
            break;
        case ChangeTypeOverInfo:
        case ChangeTypeOverThirdInfo:
            title = @"完善资料";
            break;
        case ChangeTypeRegister:
            title = @"注册";
            break;
        case ChangeTypeFindPwd:
            title = @"找回密码";
            break;
        default:
            break;
    }
    [self setNavTitle:title];
    [self drawBackButton];
    [self creatUI];
}


- (void)creatUI{
    self.errorMessage = @"";
    self.time = 60;
    self.getCode = [Factory creatButtonWithTitle:@"获取验证码"
                                 backGroundColor:[UIColor clearColor]
                                       textColor:Color_MainBlue
                                        textSize:font750(24)];
    self.getCode.layer.borderColor = Color_MainBlue.CGColor;
    self.getCode.layer.borderWidth = Anno750(1);
    self.getCode.layer.cornerRadius = Anno750(8);
    [self.getCode setTitleColor:Color_LightGray forState:UIControlStateDisabled];
    [self.getCode addTarget:self action:@selector(getCodeRequest) forControlEvents:UIControlEventTouchUpInside];
    
    self.titles = @[@"手机号",@"验证码",@"用户名",@"原密码",@"新密码",@"确认密码"];
    self.placeHolders = @[@"请输入手机号",@"请输入验证码",@"设置后不可修改，仅能用汉字和数字",@"请设置登录密码",@"请输入新密码",@"请重复输入新密码"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    
    [self.view addSubview:self.tabview];
    
    UIView * footer = [Factory creatViewWithColor:[UIColor clearColor]];
    footer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(108));
    NSString * title;
    switch (self.vcType) {
        case ChangeTypeBindPhone:
            title = @"确定";
            break;
        case ChangeTypeChangePhone:
        case ChangeTypeChangePwd:
        case ChangeTypeFindToChangePwd:
            title = @"确认修改";
            break;
        case ChangeTypeOverInfo:
        case ChangeTypeOverThirdInfo:
            title = @"完成";
            break;
        case ChangeTypeRegister:
            title = @"注册";
            break;
        case ChangeTypeFindPwd:
            title = @"确认";
            break;
        default:
            break;
    }
    self.overButton = [Factory creatButtonWithTitle:title
                                    backGroundColor:Color_alphaBlue
                                          textColor:[UIColor whiteColor]
                                           textSize:font750(34)];
    self.overButton.layer.cornerRadius = Anno750(8);
    self.overButton.enabled = NO;
    [self.overButton addTarget:self action:@selector(SureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:self.overButton];
    [self.overButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(88)));
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
    }];
    self.tabview.tableFooterView = footer;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        return self.errorMessage.length > 0 ? Anno750(40) : Anno750(0);
    }
    
    //规则设置
    switch (self.vcType) {
        case ChangeTypeBindPhone:
        case ChangeTypeChangePhone:
        case ChangeTypeRegister:
        case ChangeTypeFindPwd:
        {   //只显示 手机号与验证码
            if (indexPath.row == 0 || indexPath.row == 1) {
                return Anno750(100);
            }else{
                return 0;
            }
        }
        case ChangeTypeChangePwd:
        {
            if (indexPath.row == 3|| indexPath.row == 4 ||indexPath.row == 5) {
                return Anno750(100);
            }else{
                return 0;
            }
        }
        case ChangeTypeOverInfo:
        {
            if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
                return Anno750(100);
            }else{
                return 0;
            }
        }
        case ChangeTypeOverThirdInfo:
        {
            return indexPath.row == 3 ? 0 : Anno750(100);
        }
        case ChangeTypeFindToChangePwd:
        {
            if (indexPath.row == 4 || indexPath.row == 5) {
                return Anno750(100);
            }else{
                return 0;
            }
        }
        default:
            return 0;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        static NSString * cellid = @"ErrorMessageCell";
        ErrorMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ErrorMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.descLabel.text = self.errorMessage;
        return cell;
    }
    
    static NSString * cellid = @"TextFieldCell";
    TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSString * title = @"";
    NSString * placeHolder = @"";
    switch (indexPath.row) {
        case 0:
        {
            title = @"手机号";
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeFindPwd) {
                placeHolder = @"请输入手机号";
            }else if(self.vcType == ChangeTypeChangePhone ){
                placeHolder = @"173****8962";
            }else if(self.vcType == ChangeTypeChangePwd || self.vcType == ChangeTypeFindToChangePwd){
                cell.hidden =YES;
            }else if(self.vcType == ChangeTypeOverThirdInfo){
                placeHolder = @"可用于找回密码";
            }else if(self.vcType == ChangeTypeOverInfo){
                cell.textField.text = [Factory changePhoneString:self.phoneNumerstr];
                cell.textField.enabled = NO;
            }
            
            //添加获取验证码按钮
            if (self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeOverThirdInfo || self.vcType == ChangeTypeFindPwd) {
                [cell addSubview:self.getCode];
                [self.getCode mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(@(-Anno750(24)));
                    make.width.equalTo(@(Anno750(160)));
                    make.height.equalTo(@(Anno750(52)));
                    make.centerY.equalTo(@0);
                }];
            }
            self.phoneNumber = cell.textField;
        }
            
            break;
        case 1:
        {
            title = @"验证码";
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeChangePhone || self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeOverThirdInfo || self.vcType == ChangeTypeFindPwd) {
                placeHolder = @"请输入验证码";
            }else if(self.vcType == ChangeTypeChangePwd || self.vcType == ChangeTypeOverInfo || self.vcType == ChangeTypeFindToChangePwd){
                cell.hidden =YES;
            }
            self.codeTextF = cell.textField;
        }
            break;
        case 2:
        {
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeChangePhone || self.vcType == ChangeTypeChangePwd || self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeFindPwd || self.vcType == ChangeTypeFindToChangePwd) {
                cell.hidden = YES;
            }else if(self.vcType == ChangeTypeOverInfo || self.vcType == ChangeTypeOverThirdInfo){
                title = @"用户名";
                placeHolder = @"设置后不可修改，仅能用汉字和数字";
            }
            self.nameTextF = cell.textField;
        }
            break;
        case 3:
        {
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeChangePhone || self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeOverInfo ||self.vcType == ChangeTypeOverThirdInfo || self.vcType == ChangeTypeFindPwd|| self.vcType == ChangeTypeFindToChangePwd) {
                cell.hidden = YES;
            }else if(self.vcType == ChangeTypeChangePwd){
                title = @"原密码";
                placeHolder = @"请输入原始密码";
            }
            cell.textField.secureTextEntry = YES;
            self.oldPwd = cell.textField;
        }
            break;
        case 4:
        {
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeChangePhone || self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeFindPwd) {
                cell.hidden = YES;
            }else if(self.vcType == ChangeTypeChangePwd || self.vcType == ChangeTypeFindToChangePwd){
                title = @"新密码";
                placeHolder = @"请输入新密码";
            }else if(self.vcType == ChangeTypeOverInfo || self.vcType == ChangeTypeOverThirdInfo){
                title = @"密码";
                placeHolder = @"请设置登录密码";
            }
            cell.textField.secureTextEntry = YES;
            self.pwdTextF = cell.textField;
        }
            break;
        case 5:
        {
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeChangePhone || self.vcType == ChangeTypeRegister || self.vcType == ChangeTypeFindPwd) {
                cell.hidden = YES;
            }else if(self.vcType == ChangeTypeChangePwd){
                title = @"确认密码";
                placeHolder = @"请重复输入新密码";
            }else if(self.vcType == ChangeTypeOverInfo || self.vcType == ChangeTypeOverThirdInfo || self.vcType == ChangeTypeFindToChangePwd){
                title = @"确认密码";
                placeHolder = @"请再次输入新密码";
            }
            cell.textField.secureTextEntry = YES;
            self.checkPwd = cell.textField;
        }
            break;
        default:
            break;
    }
    title = title.length>0 ? title : self.titles[indexPath.row];
    placeHolder = placeHolder.length > 0? placeHolder : self.placeHolders[indexPath.row];
    [cell updateTitle:title placeHolder:placeHolder];
    [cell.textField addTarget:self action:@selector(textFieldchanged) forControlEvents:UIControlEventEditingChanged];
    return cell;
}
- (void)textFieldchanged{
    if (self.vcType == ChangeTypeOverThirdInfo) {
        if (self.phoneNumber.text.length >= 4 && self.codeTextF.text.length >= 4 && self.pwdTextF.text.length >= 6 && self.checkPwd.text.length >= 6) {
            self.overButton.enabled = YES;
            self.overButton.backgroundColor = Color_MainBlue;
        }else{
            self.overButton.enabled = NO;
            self.overButton.backgroundColor = Color_alphaBlue;
        }
    }else if(self.vcType == ChangeTypeRegister){
        if (self.phoneNumber.text.length >= 4 && self.codeTextF.text.length >= 4) {
            self.overButton.enabled = YES;
            self.overButton.backgroundColor = Color_MainBlue;
        }else{
            self.overButton.enabled = NO;
            self.overButton.backgroundColor = Color_alphaBlue;
        }
    }else if(self.vcType == ChangeTypeOverInfo){
        if (self.nameTextF.text.length> 2 && self.pwdTextF.text.length >= 6 && self.checkPwd.text.length >= 6) {
            self.overButton.enabled = YES;
            self.overButton.backgroundColor = Color_MainBlue;
        }else{
            self.overButton.enabled = NO;
            self.overButton.backgroundColor = Color_alphaBlue;
        }
    }else if(self.vcType == ChangeTypeFindPwd){
        if (self.phoneNumber.text.length >= 11 && self.codeTextF.text.length >= 4) {
            self.overButton.enabled = YES;
            self.overButton.backgroundColor = Color_MainBlue;
        }else{
            self.overButton.enabled = NO;
            self.overButton.backgroundColor = Color_alphaBlue;
        }
    }else if(self.vcType == ChangeTypeFindToChangePwd){
        if (self.pwdTextF.text.length >= 6 && self.checkPwd.text.length >= 6) {
            self.overButton.enabled = YES;
            self.overButton.backgroundColor = Color_MainBlue;
        }else{
            self.overButton.enabled = NO;
            self.overButton.backgroundColor = Color_alphaBlue;
        }
    }
}

#pragma mark - 获取验证码
- (void)getCodeRequest{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"mobile":self.phoneNumber.text,
                              };
    [[NetWorkManger manager] sendRequest:PageSendSms route:Route_Set withParams:params complete:^(NSDictionary *result) {
        self.errorMessage = @"";
        self.getCode.layer.borderColor = Color_LightGray.CGColor;
        self.getCode.enabled = NO;
        [self.tabview reloadData];
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeButttonTime) userInfo:nil repeats:YES];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"验证码已发送至您的手机" duration:1.0f];
    } error:^(NFError *byerror) {
        self.errorMessage = byerror.errorMessage;
        [self.tabview reloadData];
    }];
}
- (void)changeButttonTime{
    self.time -= 1;
    if (self.time == 0) {
        [self.getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCode.enabled = YES;
        self.getCode.layer.borderColor = Color_MainBlue.CGColor;
        [self.timer invalidate];
        self.timer = nil;
        self.time = 60;
    }else{
        [self.getCode setTitle:[NSString stringWithFormat:@"%ds",self.time] forState:UIControlStateNormal];
    }
}
#pragma mark - 确认
- (void)SureButtonClick{
    if (self.vcType == ChangeTypeOverThirdInfo) {
        [self ThirdLoginRegister];
    }else if(self.vcType == ChangeTypeRegister){
        [self userRegister];
    }else if(self.vcType == ChangeTypeOverInfo){
        [self userOverMobileInfo];
    }else if(self.vcType == ChangeTypeFindPwd){
        [self forgotPwdRequest];
    }else if(self.vcType == ChangeTypeFindToChangePwd){
        [self getPwdRequest];
    }
}

#pragma mark - 注册
- (void)userRegister{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"mobile":self.phoneNumber.text,
                              @"authcode":self.codeTextF.text,
                              };
    [[NetWorkManger manager] sendRequest:Page_MobRegister route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        [[UserManager manager] updateInfoByEditstatus:dic];
        PhoneAboutViewController * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeOverInfo];
        vc.phoneNumerstr = self.phoneNumber.text;
        [self.navigationController pushViewController:vc animated:YES];
    } error:^(NFError *byerror) {
        self.errorMessage = byerror.errorMessage;
        [self.tabview reloadData];
    }];
}
#pragma mark - 手机用户注册信息完善
- (void)userOverMobileInfo{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"username":self.nameTextF.text,
                              @"password":self.pwdTextF.text,
                              @"re_password":self.checkPwd.text,
                              @"uid":[UserManager manager].userID,
                              @"callback_verify":[UserManager manager].info.callback_verify,
                              };
    [[NetWorkManger manager] sendRequest:Page_MobOverInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        //清空userid
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"注册成功" duration:2.0f];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } error:^(NFError *byerror) {
        self.errorMessage = byerror.errorMessage;
        [self.tabview reloadData];
    }];
}
#pragma mark - 忘记密码
- (void)forgotPwdRequest{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"mobile":self.phoneNumber.text,
                              @"authcode":self.codeTextF.text,
                              };
    [[NetWorkManger manager] sendRequest:Pagerepwd route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        [[UserManager manager] updateInfoByEditstatus:dic];
        PhoneAboutViewController * vc = [[PhoneAboutViewController alloc]initWithType:ChangeTypeFindToChangePwd];
        [self.navigationController pushViewController:vc animated:YES];
    } error:^(NFError *byerror) {
        self.errorMessage = byerror.errorMessage;
        [self.tabview reloadData];
    }];
}
#pragma mark - 忘记密码 找回密码
- (void)getPwdRequest{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"callback_verify":[UserManager manager].info.callback_verify,
                              @"password":self.pwdTextF.text,
                              @"re_password":self.checkPwd.text
                              };
    [[NetWorkManger manager] sendRequest:PageNewPwd route:Route_User withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"修改成功，请重新登录" duration:2.0f];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } error:^(NFError *byerror) {
        self.errorMessage = byerror.errorMessage;
        [self.tabview reloadData];
    }];
}

#pragma mark - 第三方登录注册
- (void)ThirdLoginRegister{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"type":self.thirdType,
                              @"openid":self.thirdResp.openid,
                              @"mobile":self.phoneNumber.text,
                              @"authcode":self.codeTextF.text,
                              @"username":self.thirdResp.name,
                              @"password":self.pwdTextF.text,
                              @"re_password":self.checkPwd.text
                              };
    [[NetWorkManger manager] sendRequest:Page_Oauth route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        [[UserManager manager] updateInfoByEditstatus:dic];
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:^(NFError *byerror) {
        self.errorMessage = byerror.errorMessage;
        [self.tabview reloadData];
    }];
}



@end
