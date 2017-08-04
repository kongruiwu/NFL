//
//  SettingViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;

@end

@implementation SettingViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"设置"];
    [self creatUI];
    
}
- (void)creatUI{
    self.titles = @[@[@"推送通知",@"无图模式",@"清除缓存"],@[@"检测新版本",@"给我们打分"]];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = self.titles[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"SettingTableViewCell";
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    BOOL rec = YES;
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            rec = NO;
        }
    }
    NSString * desc = @"";
    if (indexPath.section == 0 && indexPath.row == 2) {
        CGFloat folderSize =[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        desc = [NSString stringWithFormat:@"%.2fM",folderSize];
    }
    [cell updateWithTitle:self.titles[indexPath.section][indexPath.row] desc:desc switch:rec];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定清除缓存" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                SettingTableViewCell * cell = [self.tabview cellForRowAtIndexPath:indexPath];
                cell.descLabel.text = @"0.00M";
                [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"已清除缓存" duration:1.0f];
            }];
            [alert addAction:action];
            [alert addAction:sure];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 1) {
            NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", APPID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
    }
}

@end
