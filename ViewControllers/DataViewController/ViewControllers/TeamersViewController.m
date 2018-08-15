//
//  TeamersViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamersViewController.h"
#import "TeamHeader.h"
#import "TeamerLeftCell.h"
#import "TeamRightCell.h"
#import "PlayerLineUpModel.h"
#import "PlayerListModel.h"
@interface TeamersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic) BOOL isLineUp;
@property (nonatomic) CGFloat contentoffX;

@end

@implementation TeamersViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI{
    self.contentoffX = 0;
    
    self.dataArray = [NSMutableArray new];
    self.isLineUp = YES;
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - Nav64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(180);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TeamHeader * header = [[TeamHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(180))];
    header.segmentbtn.selectedSegmentIndex = self.isLineUp ? 0 : 1;
    header.leftSection.hidden = header.segmentbtn.selectedSegmentIndex == 0 ? NO : YES;
    header.rightSection.hidden = header.segmentbtn.selectedSegmentIndex == 0 ? YES : NO;
    [header.segmentbtn addTarget:self action:@selector(checkindexStatus:) forControlEvents:UIControlEventValueChanged];
    return header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.isLineUp) {
        static NSString * cellid = @"rightCell";
        TeamRightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWitPlayerListModel:self.dataArray[indexPath.row]];
        return cell;
    }else{
        static NSString * cellid = @"leftCell";
        TeamerLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamerLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.scrollview.delegate = self;
//        [cell updateWithPlayerLineUpModel:self.dataArray[indexPath.row] contentoffX:self.contentoffX];
        [cell updateWithPlayerLineUpModel:self.dataArray[indexPath.row]];
        return cell;
    }
}

- (void)checkindexStatus:(UISegmentedControl *)segem{
    self.isLineUp = !self.isLineUp;
    [self getData];
}
- (void)getData{
    [SVProgressHUD show];
    [self.dataArray removeAllObjects];
    NSDictionary * params = @{
                              @"team_id":self.teamID,
                              @"page":@"players",
                              //lineup：阵容、list：名单
                              @"type":self.isLineUp ? @"lineup" : @"list",
                              };
    [[NetWorkManger manager] sendRequest:TeamDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
        if (self.tabview) {
            if (self.isLineUp) {
                NSDictionary * dic = result[@"data"];
                NSArray * arr = dic[@"player_lineup"];
                for (int i = 0; i<arr.count; i++) {
                    PlayerLineUpModel * model = [[PlayerLineUpModel alloc]initWithDictionary:arr[i]];
                    [self.dataArray addObject:model];
                }
            }else{
                NSDictionary * dic = result[@"data"];
                NSArray * arr = dic[@"player_list"];
                for (int i = 0; i<arr.count; i++) {
                    PlayerListModel * model = [[PlayerListModel alloc]initWithDictionary:arr[i]];
                    [self.dataArray addObject:model];
                }
            }
            
            [self.tabview reloadData];
        }
        [self updateTabFooter];
    } error:^(NFError *byerror) {
        
    }];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.tabview) {
        if ([self.delegate respondsToSelector:@selector(hiddenOutHeadView:)]) {
            [self.delegate hiddenOutHeadView:scrollView.contentOffset.y];
        }
    }
    if (scrollView != self.tabview) {
        NSArray * arr = self.tabview.visibleCells;
        self.contentoffX = scrollView.contentOffset.x;
        for (int i = 0; i<arr.count; i++) {
            TeamerLeftCell * cell = arr[i];
            cell.scrollview.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
        }
    }
}
@end
