//
//  ChangeAddresViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ChangeAddresViewController.h"

#import "TextFieldCell.h"
@interface ChangeAddresViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UIButton * overButton;

@end

@implementation ChangeAddresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"所在城市"];
    [self creatUI];
    
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    
    [self.view addSubview:self.tabview];
    UIView * footer = [Factory creatViewWithColor:[UIColor clearColor]];
    footer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(108));
    
    self.overButton = [Factory creatButtonWithTitle:@"保存"
                                    backGroundColor:Color_MainBlue
                                          textColor:[UIColor whiteColor]
                                           textSize:font750(34)];
    self.overButton.layer.cornerRadius = Anno750(8);
    [self.overButton addTarget:self action:@selector(changeUserCityRequest) forControlEvents:UIControlEventTouchUpInside];
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
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"TextFieldCell";
    TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSString * city = [UserManager manager].info.city ? [UserManager manager].info.city : @"上海";
    [cell updateTitle:@"地    址" placeHolder:city];
    return cell;
}

- (void)changeUserCityRequest{
    
    TextFieldCell * cell = [self.tabview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell.textField.text.length == 0) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"请输入您的城市" duration:1.0f];
        return;
    }
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"city":cell.textField.text
                              };
    [[NetWorkManger manager] sendRequest:PageUpdateUserInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"修改成功" duration:1.0f];
        [UserManager manager].info.city = cell.textField.text;
        [self doBack];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

@end
