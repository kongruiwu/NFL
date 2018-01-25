//
//  MyCollectionViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "SubNewsListCell.h"
#import "InfoListModel.h"
#import "VideoListModel.h"
#import "VideoDetailViewController.h"
#import "WKWebViewController.h"
#import "PageDetailViewController.h"
@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource,SubNewsListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation MyCollectionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick event:Mob_Like];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"我的收藏"];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    
    self.dataArray = [NSMutableArray new];
    
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
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(160);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"SubNewsListCell";
    SubNewsListCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithObjectModel:self.dataArray[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id  idModel = self.dataArray[indexPath.section];
    if ([idModel isKindOfClass:[VideoListModel class]]) {
        VideoListModel * model = self.dataArray[indexPath.section];
        VideoDetailViewController * vc = [[VideoDetailViewController alloc]init];
        vc.videoID = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([idModel isKindOfClass:[InfoListModel class]]){
        InfoListModel * model = self.dataArray[indexPath.section];
        if ([model.cont_type isEqualToString:@"news"]) {
            WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"资讯" url:model.app_iframe];
            vc.infoModel = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            PageDetailViewController * vc = [[PageDetailViewController alloc]init];
            vc.photoID = model.id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self getData];
}
-(void)loadMoreData{
    [self getData];
}

- (void)getData{
    NSNumber * cid;
    if ([self.dataArray.lastObject isKindOfClass:[VideoListModel class]]) {
        VideoListModel * model = self.dataArray.lastObject;
        cid = model.cid;
    }else{
        InfoListModel * model = self.dataArray.lastObject;
        cid = model.cid;
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"last_cid":cid ? cid : @""
                              };
    [[NetWorkManger manager] sendRequest:PageMyCollect route:Route_User withParams:params complete:^(NSDictionary *result) {
        if (self.nullView.hidden == NO) {
            self.nullView.hidden = YES;
        }
        NSDictionary * dic = result[@"data"];
        NSArray * arr = dic[@"list"];
        for (int i = 0; i<arr.count; i++) {
            NSDictionary * resp = arr[i];
            if ([resp[@"cont_type"] isEqualToString:@"video"]) {
                VideoListModel * model = [[VideoListModel alloc]initWithDictionary:resp];
                [self.dataArray addObject:model];
            }else{
                InfoListModel * model = [[InfoListModel alloc]initWithDictionary:resp];
                [self.dataArray addObject:model];
            }
        }
        [self.tabview reloadData];
        if (arr.count < 10) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
        [self.refreshHeader endRefreshing];
        if (arr.count == 0 && self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneCollect];
        }
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNoneData];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}
- (void)collectThisCellItem:(UIButton *)btn{
    [SVProgressHUD show];
    UITableViewCell * cell = (UITableViewCell *)[btn superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    NSString * type ;
    NSNumber * itemID;
    BaseModel * item;
    if ([self.dataArray[indexpath.section] isKindOfClass:[VideoListModel class]]) {
        VideoListModel * model = self.dataArray[indexpath.section];
        type = model.cont_type;
        itemID = model.id;
        item = model;
    }else{
        InfoListModel * model = self.dataArray[indexpath.section];
        type = model.cont_type;
        itemID = model.id;
        item = model;
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":type,
                              @"id":itemID
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text: @"取消收藏成功" duration:1.0f];
        [self.dataArray removeObject:item];
        [self.tabview reloadData];
        if (self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneCollect];
        }
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}


@end
