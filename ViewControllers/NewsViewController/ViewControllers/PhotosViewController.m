//
//  PhotosViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoListCell.h"
#import "PhotoListViewController.h"
#import "PhotoSetModel.h"
@interface PhotosViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<PhotoSetModel *> * dataArray;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64 - 49 - Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    
    [self.view addSubview:self.tabview];
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    
    self.tabview.mj_header = self.refreshHeader;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(340);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"PhotoListCell";
    PhotoListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[PhotoListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithPhotoSetModel:self.dataArray[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhotoListViewController * vc = [PhotoListViewController new];
    vc.type = self.dataArray[indexPath.section].type;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getData{
    self.dataArray =[NSMutableArray new];
    [SVProgressHUD show];
    [[NetWorkManger manager] sendRequest:NewWest_album route:Route_NewWest withParams:@{} complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * dic = (NSDictionary *)result;
        NSDictionary * dic2 = dic[@"data"];
        NSArray * arr = dic2[@"list"];
        for (int i = 0; i<arr.count; i++) {
            PhotoSetModel * model = [[PhotoSetModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        if (self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self.tabview reloadData];
        }
        [self.refreshHeader endRefreshing];
    } error:^(NFError *byerror) {
        [self.refreshHeader endRefreshing];
        [self showNullViewByType:NullTypeNetError];
    }];
}

@end
