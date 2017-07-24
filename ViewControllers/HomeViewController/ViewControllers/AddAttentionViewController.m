//
//  AddAttentionViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AddAttentionViewController.h"
#import "AddTeamCell.h"
@interface AddAttentionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UILabel * header;

@end

@implementation AddAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"添加关注"];
    [self drawBackButton];
    [self creatUI];
    
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.header = [Factory creatLabelWithText:@"我的关注(0)"
                                    fontValue:font750(28)
                                    textColor:Color_MainBlack
                                textAlignment:NSTextAlignmentCenter];
    self.header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
    self.tabview.tableHeaderView = self.header;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 0 : 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(210);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? Anno750(120) : Anno750(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return nil;
    }
    UILabel * label = [Factory creatLabelWithText:@"您还未关注球队\n点击球队logo可直接关注，再次点击可以取消"
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentCenter];
    label.numberOfLines = 0;
    label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(120));
    label.backgroundColor = [UIColor whiteColor];
    return label;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"AddTeamCell";
    AddTeamCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AddTeamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}



@end
