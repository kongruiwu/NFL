//
//  ScoreRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/31.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "ScoreRankViewController.h"
#import "ScoreRankTopCell.h"
#import "ScoreRankBotomCell.h"
#import "ScoreListModel.h"

@interface ScoreRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabview;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation ScoreRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"积分排行榜"];
    [self drawBackButton];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT-Nav64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? Anno750(20) : 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView * foot = [Factory creatViewWithColor:Color_BackGround];
        foot.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
        return foot;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? Anno750(188) : Anno750(80);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger scetion1 = self.dataArray.count > 4 ? 4 : self.dataArray.count;
    NSInteger section2 = self.dataArray.count > 4 ? self.dataArray.count - 4 : 0;
    return section == 0 ? scetion1 : section2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"ScoreRankTopCell";
        ScoreRankTopCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ScoreRankTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithScoreRankModel:self.dataArray[indexPath.row] indexRow:indexPath.row];
        return cell;
    }else{
        static NSString * cellid = @"ScoreRankBotomCell";
        ScoreRankBotomCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[ScoreRankBotomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        if (self.dataArray.count > 4) {
            [cell updateWithScoreRankModel:self.dataArray[indexPath.row + 4]];
        }
        return cell;
    }
}

- (void)getData{
    [SVProgressHUD show];
    [[NetWorkManger manager] sendRequest:Page_Rank route:Route_ScoreRank withParams:@{} complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            ScoreListModel * model = [[ScoreListModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
        [SVProgressHUD dismiss];
    } error:^(NFError *byerror) {
        [SVProgressHUD dismiss];
    }];
}

@end
