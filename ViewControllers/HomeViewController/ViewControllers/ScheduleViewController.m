//
//  ScheduleViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleListCell.h"

@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];

}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [Factory creatViewWithColor:Color_BackGround];
    view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UIButton * button = [Factory creatButtonWithTitle:@"  08/05  周六"
                                      backGroundColor:[UIColor clearColor]
                                            textColor:Color_LightGray
                                             textSize:font750(26)];
    [button setImage:[UIImage imageNamed:@"sidebar_icon_calendar_default"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(220);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"ScheduleListCell";
    ScheduleListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ScheduleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
@end
