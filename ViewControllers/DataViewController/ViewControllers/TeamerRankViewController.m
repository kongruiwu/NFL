//
//  TeamerRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerRankViewController.h"
#import "TeamerRankListCell.h"
@interface TeamerRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;

@end

@implementation TeamerRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI{
    
    self.titles = @[@"传球榜",@"跑球榜",@"传球榜",@"跑球榜",@"传球榜",@"跑球榜"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 49 - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    UIView * headview = [Factory creatViewWithColor:[UIColor clearColor]];
    headview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(150));
    
    UIButton * weekBtn = [Factory creatButtonWithTitle:@"第三周"
                                       backGroundColor:[UIColor clearColor]
                                             textColor:Color_MainBlue
                                              textSize:font750(26)];
    weekBtn.layer.borderColor = Color_MainBlue.CGColor;
    weekBtn.layer.borderWidth = 1.0f;
    weekBtn.layer.cornerRadius = Anno750(30);
    [headview addSubview:weekBtn];
    [weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(450)));
        make.height.equalTo(@(Anno750(60)));
    }];
    self.tabview.tableHeaderView = headview;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(220);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(60);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headview = [Factory creatViewWithColor:Color_SectionGround];
    headview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
    UILabel * label = [Factory creatLabelWithText:self.titles[section]
                                        fontValue:font750(24)
                                        textColor:Color_MainBlue
                                    textAlignment:NSTextAlignmentCenter];
    [headview addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    return headview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"TeamerRankListCell";
    TeamerRankListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TeamerRankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}


@end
