//
//  SubNewsViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubNewsViewController.h"
#import "SubNewsListCell.h"
#import "SubNewsHeadCell.h"
#import "InfoMainModel.h"
@interface SubNewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) InfoMainModel * mainModel;

@end

@implementation SubNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64 - 49 - Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mainModel.list.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Anno750(420);
    }
    return Anno750(160);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"SubNewsHeadCell";
        SubNewsHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubNewsHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithModel:self.mainModel.coverModel];
        return cell;
    }
    static NSString * cellid = @"SubNewsListCell";
    SubNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithObjectModel:self.mainModel.list[indexPath.section - 1]];
    return cell;
}

- (void)getData{
    NSDictionary * params = @{
                              @"last_id":@""
                                  };
    [[NetWorkManger manager] sendRequest:NewWest_Info route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.mainModel = [[InfoMainModel alloc]initWithDictionary:dic];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}



@end
