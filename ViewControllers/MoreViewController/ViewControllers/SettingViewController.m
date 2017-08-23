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
    self.titles = @[@[@"推送通知",@"无图模式",@"清除缓存"],@[@"给我们打分"]];
    
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
        if (indexPath.row == 1) {
            rec = NO;
            cell.switchView.on = ![UserManager manager].hasPic;
            [cell.switchView addTarget:self action:@selector(changeHasPicStatus:) forControlEvents:UIControlEventValueChanged];
        }
    }
    NSString * desc = @"";
    if (indexPath.section == 0 ) {
        if (indexPath.row == 2) {
            CGFloat folderSize =[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
            desc = [NSString stringWithFormat:@"%.2fM",folderSize];
        }else if(indexPath.row == 0){
            desc = [self isAllowedNotification];
        }
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
        }else if(indexPath.row == 0){
            if ([[self isAllowedNotification] isEqualToString:@"未开启"]) {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"推送提示" message:@"请在手机“设置”-“通知”中修改" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:sure];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", APPID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        }
    }
}

#pragma mark - 检测是否开启推送服务
-(NSString *)isAllowedNotification
{
    UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return @"已开启";
    }else{
        return @"未开启";
    }
}
- (void)changeHasPicStatus:(UISwitch *)switchView{
    switchView.on = !switchView.on;
    if (switchView.on) {
        [[NSUserDefaults standardUserDefaults] setObject:@0 forKey:@"hasPic"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"hasPic"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UserManager manager].hasPic = !switchView.on;
}


@end
