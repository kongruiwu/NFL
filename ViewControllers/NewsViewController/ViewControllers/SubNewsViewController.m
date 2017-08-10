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

#import "WKWebViewController.h"

@interface SubNewsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) InfoMainModel * mainModel;

@end

@implementation SubNewsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self refreshData];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64 - 49 - Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * url;
    if (indexPath.section == 0) {
        url = self.mainModel.coverModel.app_iframe;
    }else{
        url = self.mainModel.list[indexPath.section - 1].app_iframe;
    }
    WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"" url:url];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)refreshData{
    self.mainModel.coverModel = nil;
    [self.mainModel.list removeAllObjects];
    [self getData];
}
- (void)loadMoreData{
    [self getData];
}
- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"last_id":self.mainModel.list.count == 0 ? @"" :self.mainModel.list.lastObject.id
                                  };
    [[NetWorkManger manager] sendRequest:NewWest_Info route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.mainModel = [[InfoMainModel alloc]initWithDictionary:dic];
        [self.refreshHeader endRefreshing];
        NSArray * arr = dic[@"list"];
        [self hiddenNullView];
        if (arr.count < 9) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
        if (!self.mainModel.coverModel && (!self.mainModel.list || self.mainModel.list.count == 0)) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self.tabview reloadData];
        }
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}



@end
