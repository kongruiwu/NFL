//
//  TeamMatchViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamMatchViewController.h"
#import "ScheduleListCell.h"
@interface TeamMatchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TeamMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(220);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0 : Anno750(60);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    UILabel * label = [Factory creatLabelWithText:@"08/05  周六"
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentCenter];
    label.backgroundColor = Color_BackGround;
    label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
    return label;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"ScheduleListCell";
    ScheduleListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ScheduleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
//    [cell updateWithMatchDetailModel:self.dataArray[indexPath.section].list[indexPath.row -1]];
//    cell.line.hidden = indexPath.row == 1 ? YES : NO;
    return cell;
}

@end
