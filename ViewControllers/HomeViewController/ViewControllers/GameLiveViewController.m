//
//  GameLiveViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameLiveViewController.h"
#import "GameLiveListCell.h"


@interface GameLiveViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GameLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
}
- (void)creatUI{
    self.tabview = [[GameTabview alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(30) - Anno750(80)) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabview.dataSource = self;
//    [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(30) - Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    UIView * head = [Factory creatViewWithColor:[UIColor whiteColor]];
    head.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(30));
    self.tabview.tableHeaderView = head;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(140);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(50);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(50);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * head = [Factory creatViewWithColor:[UIColor whiteColor]];
    head.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(40));
    
    UIButton * nameBtn = [Factory creatButtonWithNormalImage:@"content_icon_football_blue" selectImage:@"content_icon_football_red"];
    [nameBtn setTitleColor:Color_MainBlue forState:UIControlStateNormal];
    [nameBtn setTitleColor:Color_MainRed forState:UIControlStateSelected];
    [nameBtn setTitle:@"  爱国者" forState:UIControlStateNormal];
    [nameBtn setTitle:@"  德州人" forState:UIControlStateSelected];
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:Anno750(20)];
    
    UIView * line = [Factory creatLineView];
    [head addSubview:nameBtn];
    [head addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.width.equalTo(@0.5);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(line.mas_left);
        make.top.equalTo(@0);
    }];
    nameBtn.selected = section%2 == 1 ? YES : NO;
    return head;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [Factory creatViewWithColor:[UIColor whiteColor]];
    footer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(50));
    
    UIView * line = [Factory creatLineView];
    UILabel * descLabel = [Factory creatLabelWithText:@"本场比赛在腾讯体育、阿里体育、爱奇艺、新浪直播、聚力体育均有直播"
                                            fontValue:font750(20)
                                            textColor:Color_MainRed
                                        textAlignment:NSTextAlignmentLeft];
    descLabel.numberOfLines = 0;
    [footer addSubview:line];
    [footer addSubview:descLabel];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.width.equalTo(@0.5);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(Anno750(48));
        make.bottom.equalTo(@(-Anno750(10)));
        make.right.equalTo(@(-Anno750(24)));
    }];
    return footer;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"GameLiveListCell";
    GameLiveListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GameLiveListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}
//- (void)scroll
@end
