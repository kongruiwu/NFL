//
//  TeamerRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerRankViewController.h"
#import "TeamerRankListCell.h"
#import "SelectTimeView.h"
@interface TeamerRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) SelectTimeView * timeView;
@end

@implementation TeamerRankViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timeView removeFromSuperview];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.timeView = [[SelectTimeView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    [self.tabBarController.view addSubview:self.timeView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI{
    
    self.titles = @[@"传球榜",@"跑球榜",@"传球榜",@"跑球榜",@"传球榜",@"跑球榜"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(130), UI_WIDTH, UI_HEGIHT- Anno750(80) - 49 - 64 - Anno750(130)) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
    UIView * headview = [Factory creatViewWithColor:[UIColor clearColor]];
    headview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(130));
    
    UIButton * weekBtn = [Factory creatButtonWithTitle:@"第三周"
                                       backGroundColor:[UIColor clearColor]
                                             textColor:Color_MainBlue
                                              textSize:font750(26)];
    [weekBtn addTarget:self action:@selector(pushTimeView) forControlEvents:UIControlEventTouchUpInside];
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
    [self.view addSubview:headview];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        return Anno750(20);
    }
    return Anno750(220);
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
    return 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        static NSString * cellid = @"bankCell";
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.backgroundColor = Color_BackGround;
        }
        return cell;
    }
    
    static NSString * cellid = @"TeamerRankListCell";
    TeamerRankListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TeamerRankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
- (void)pushTimeView{
    [self.timeView show];
}

@end
