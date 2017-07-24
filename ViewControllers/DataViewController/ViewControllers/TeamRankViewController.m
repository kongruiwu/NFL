//
//  TeamRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamRankViewController.h"
#import "UnionTeamRankCell.h"
@interface TeamRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl * segmentbtn;
@property (nonatomic, strong) UITableView * tabview;


@end

@implementation TeamRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];

}
- (void)creatUI{
    UIView * clearview = [Factory creatViewWithColor:[UIColor clearColor]];
    clearview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(125));
    [self.view addSubview:clearview];
    
    self.segmentbtn = [[UISegmentedControl alloc]initWithItems:@[@"联盟",@"分区"]];
    self.segmentbtn.backgroundColor = [UIColor whiteColor];
    self.segmentbtn.layer.borderColor = Color_MainBlue.CGColor;
    self.segmentbtn.tintColor = Color_MainBlue;
    [self.segmentbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segmentbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainBlue} forState:UIControlStateNormal];
    self.segmentbtn.selectedSegmentIndex = 0;
    [self.segmentbtn addTarget:self action:@selector(segmentbtnSelect:) forControlEvents:UIControlEventValueChanged];
    [clearview addSubview:self.segmentbtn];
    [self.segmentbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(450)));
        make.height.equalTo(@(Anno750(60)));
    }];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(125), UI_WIDTH, UI_HEGIHT - Anno750(125)- Anno750(80) - 49 - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"UnionTeamRankCell";
    UnionTeamRankCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UnionTeamRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}



- (void)segmentbtnSelect:(UISegmentedControl *)segmentbtn{


}
@end
