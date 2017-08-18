//
//  TeamInfoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamInfoViewController.h"
#import "AddTeamCell.h"
#import "TeamModel.h"
#import "TeamDeatailViewController.h"
@interface TeamInfoViewController ()<UITableViewDelegate,UITableViewDataSource,AddTeamCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<TeamModel *> * dataArray;

@end

@implementation TeamInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80) - 49 - 64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count%4 == 0 ? self.dataArray.count/4 : self.dataArray.count/4 + 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(210);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"AddTeamCell";
    AddTeamCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AddTeamCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSArray * arr = @[self.dataArray[indexPath.row * 4],[self checkTeamModel:(indexPath.row * 4 + 1)],[self checkTeamModel:(indexPath.row * 4  + 2)],[self checkTeamModel:(indexPath.row * 4 + 3)]];
    [cell updateWithArray:arr];
    cell.delegate = self;
    return cell;
}
- (id)checkTeamModel:(NSInteger)index{
    id obj = self.dataArray[index];
    if ([obj isKindOfClass:[TeamModel class]]) {
        return obj;
    }else{
        return @"";
    }
}

- (void)getData{
    NSDictionary * params = @{};
    [[NetWorkManger manager] sendRequest:PageTeamList route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSArray * arr = dic[@"list"];
        for (int i = 0; i<arr.count; i++) {
            TeamModel * model = [[TeamModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
    } error:^(NFError * byerror) {
        
    }];
}
- (void)selectTeamAtIndex:(NSInteger)index Button:(UIButton *)btn{
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    NSInteger path = indexpath.row * 4 + index;
    TeamDeatailViewController * vc = [[TeamDeatailViewController alloc]init];
    vc.teamID = self.dataArray[path].team_id;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
