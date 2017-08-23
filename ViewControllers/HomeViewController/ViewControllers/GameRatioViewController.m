//
//  GameRatioViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameRatioViewController.h"
#import "TeamDataProgressCell.h"
#import "GameStarsCell.h"
@interface GameRatioViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * leftScores;
@property (nonatomic, strong) NSArray * rightScores;


@end

@implementation GameRatioViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
}
- (void)creatUI{
    self.titles = @[@"场均得分",@"场均码数",@"场均对手得分",@"场均对手码数"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? Anno750(80) : Anno750(400);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? Anno750(20) : 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? Anno750(20) : Anno750(60);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [Factory creatViewWithColor:[UIColor whiteColor]];
        view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
        return view;
    }else{
        UILabel * label = [Factory creatLabelWithText:@"当家球星"
                                            fontValue:font750(24)
                                            textColor:Color_LightGray
                                        textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = Color_BackGround;
        label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
        return label;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [Factory creatViewWithColor:[UIColor whiteColor]];
        view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
        return view;
    }else{
        return nil;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.leftScores.count : 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"TeamDataProgressCell";
        TeamDataProgressCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamDataProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithTitles:self.titles[indexPath.row] leftScore:self.leftScores[indexPath.row] rightScore:self.rightScores[indexPath.row] isTime:NO];
        return cell;
    }
    static NSString * cellid = @"GameStarsCell";
    GameStarsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GameStarsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithArray:self.viewModel.stars];
    return cell;
}
//- (void)getData{
//    [SVProgressHUD show];
//    NSDictionary * params = @{
//                              @"gameId":self.gameID,
//                              @"page":@"compare"
//                              };
//    [[NetWorkManger manager] sendRequest:PageGameDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
//        if (self.tabview) {
//            NSDictionary * dic = result[@"data"];
//            self.viewModel = [[LiveViewModel alloc]initWithDictionary:dic];
//        }
//    } error:^(NFError *byerror) {
//        
//    }];
//}

- (void)setViewModel:(LiveViewModel *)viewModel{
    _viewModel = viewModel;
    self.leftScores = @[_viewModel.offensive_points.home,_viewModel.offensive_yards.home,_viewModel.defense_points.home,_viewModel.defense_yards.home];
    self.rightScores = @[_viewModel.offensive_points.visitor,_viewModel.offensive_yards.visitor,_viewModel.defense_points.visitor,_viewModel.defense_yards.visitor];
    [self.tabview reloadData];
    [self updateTabFooter];
}

@end
