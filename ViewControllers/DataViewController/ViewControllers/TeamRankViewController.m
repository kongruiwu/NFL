//
//  TeamRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamRankViewController.h"
#import "UnionTeamRankCell.h"
#import "TeamHeadView.h"
#import "TeamUnionHeadView.h"
#import "SubTeamRankCell.h"
@interface TeamRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl * segmentbtn;
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, assign) BOOL isSub;

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
    self.segmentbtn.layer.borderWidth = 1.0f;
    self.segmentbtn.layer.cornerRadius = Anno750(30);
    self.segmentbtn.layer.masksToBounds = YES;
    
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
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(125), UI_WIDTH, UI_HEGIHT - Anno750(125)- Anno750(80) - 49 - 64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headview;
    if (self.isSub) {
        headview = [[TeamHeadView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(80))];
    }else{
        headview = [[TeamUnionHeadView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(80))];
    }
    return headview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 9) {
        return Anno750(20);
    }
    return Anno750(80);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isSub) {
        return 3;
    }else{
        return 1;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //这里最后一个   添加一个 空白 背景色的 cell
    if (indexPath.row == 9) {
        static NSString * cellid = @"bankCell";
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.backgroundColor = Color_BackGround;
        }
        return cell;
    }
    
    if (self.isSub) {
        static NSString * cellid = @"SubTeamRankCell";
        SubTeamRankCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubTeamRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }
    static NSString * cellid = @"UnionTeamRankCell";
    UnionTeamRankCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UnionTeamRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (void)segmentbtnSelect:(UISegmentedControl *)segmentbtn{
    self.isSub = !self.isSub;
    [self.tabview reloadData];
}
@end
