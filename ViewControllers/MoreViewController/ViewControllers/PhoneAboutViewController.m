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

@property (nonatomic, strong) UILabel * errorMessage;
@property (nonatomic, strong) UIButton * overButton;
@property (nonatomic, strong) UIButton * getCode;

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * placeHolders;

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
            title = @"修改密码";
            break;
        default:
            break;
    }
    [self setNavTitle:title];
    [self drawBackButton];
    [self creatUI];
}


- (void)creatUI{
    
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
                                    backGroundColor:Color_MainBlue
                                          textColor:[UIColor whiteColor]
                                           textSize:font750(34)];
    self.overButton.layer.cornerRadius = Anno750(8);
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
        return Anno750(40);
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
            if (self.vcType == ChangeTypeBindPhone || self.vcType == ChangeTypeRegister) {
                placeHolder = @"请输入手机号";
            }else if(self.vcType == ChangeTypeChangePhone || self.vcType == ChangeTypeOverInfo || self.vcType == ChangeTypeFindPwd){
                placeHolder = @"173****8962";
            }else if(self.vcType == ChangeTypeChangePwd || self.vcType == ChangeTypeFindToChangePwd){
                cell.hidden =YES;
            }else if(self.vcType == ChangeTypeOverThirdInfo){
                placeHolder = @"可用于找回密码";
            }
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
        }
            break;
        default:
            break;
    }
    
    [cell updateTitle:self.titles[indexPath.row] placeHolder:self.placeHolders[indexPath.row]];
    return cell;
}


@end
