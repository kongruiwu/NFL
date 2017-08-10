//
//  PhotoListViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoListViewController.h"
#import "PhotoSubListCell.h"
#import "PhotoListModel.h"
#import "PageDetailViewController.h"
@interface PhotoListViewController ()<UITableViewDelegate,UITableViewDataSource,PhotoSubListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<PhotoListModel *> * dataArray;


@end

@implementation PhotoListViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"专题图集"];
    [self creatUI];
    [self getData];
}

- (void)creatUI{
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(30)) style:UITableViewStyleGrouped delegate:self];
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
    return self.dataArray.count/2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(430);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"PhotoSubListCell";
    PhotoSubListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[PhotoSubListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithLeftModel:self.dataArray[indexPath.section/2] rightModel:self.dataArray[indexPath.section/2 +1]];
    return cell;
}

- (void)checkLeftPhotos:(UIButton *)button{
    UITableViewCell * cell = (UITableViewCell *)[button superview];
    NSIndexPath * index = [self.tabview indexPathForCell:cell];
    PageDetailViewController * vc = [[PageDetailViewController alloc]init];
    vc.photoID = self.dataArray[index.row/2].id;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)checkRightPhotos:(UIButton *)button{
    UITableViewCell * cell = (UITableViewCell *)[button superview];
    NSIndexPath * index = [self.tabview indexPathForCell:cell];
    PageDetailViewController * vc = [[PageDetailViewController alloc]init];
    vc.photoID = self.dataArray[index.row/2 + 1].id;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self getData];
}
- (void)loadMoreData{
    [self getData];
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"type":self.type,
                              @"last_id":self.dataArray.count == 0 ? @"" : self.dataArray.lastObject.id
                              };
    [[NetWorkManger manager] sendRequest:NewWest_albumlist route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * data = result[@"data"];
        NSArray * arr = data[@"list"];
        for (int i = 0; i<arr.count; i++) {
            PhotoListModel * model = [[PhotoListModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        if (arr.count == 0 && self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self.tabview reloadData];
        }
        if (arr.count< 10) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
        [self.refreshHeader endRefreshing];
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}

@end
