//
//  PrizeDetailViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/8.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "PrizeDetailViewController.h"
#import "PrizeBodyCell.h"
#import "PrizeHeaderCell.h"
@interface PrizeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * placeHoldes;
@end

@implementation PrizeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"兑换奖品"];
    [self drawBackButton];
    [self creatUI];
    [self drawRightBarButton];
}
- (void)drawRightBarButton{
    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(exchangePrizeRequest)];
    self.navigationItem.rightBarButtonItem = rightBar;
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:font750(32)],NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)creatUI{
    self.titles = @[@"兑换时间:",@"兑换人姓名:",@"联系方式:",@"收货地址:"];
    self.placeHoldes = @[@"请选择兑换时间",@"请输入姓名",@"请输入联系方式",@"请输入收货地址"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? Anno750(260) : Anno750(90);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"PrizeHeaderCell";
        PrizeHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[PrizeHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithPrizeListModel:self.prize];
        return cell;
    }else{
        static NSString * cellid = @"PrizeBodyCell";
        PrizeBodyCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[PrizeBodyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithTitle:self.titles[indexPath.row] placeHold:self.placeHoldes[indexPath.row]];
        return cell;
    }
}
- (void)exchangePrizeRequest{
    
    PrizeBodyCell * namecell = [self.tabview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    PrizeBodyCell * phonecell = [self.tabview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    PrizeBodyCell * addressCell = [self.tabview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    NSString * name = namecell.valueTextf.text;
    NSString * phone = phonecell.valueTextf.text;
    NSString * address = addressCell.valueTextf.text;
    NSString * errStr = @"";
    if (name.length == 0) {
        errStr = @"兑换人名称不能为空";
    }else if(phone.length == 0){
        errStr = @"兑换人联系方式不能为空";
    }else if(address.length == 0){
        errStr = @"兑换人收货地址不能为空";
    }
    if (errStr.length > 0) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:errStr duration:2.0f];
        return;
    }
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"aid":self.prize.id,
                              @"name":name,
                              @"mobile":phone,
                              @"address":address
                              };
    [[NetWorkManger manager] sendRequest:Page_ExchangePrize route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"兑换成功" duration:2.0f];
        [SVProgressHUD dismiss];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        });
        
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:2.0f];
        [SVProgressHUD dismiss];
    }];
    
}

@end
