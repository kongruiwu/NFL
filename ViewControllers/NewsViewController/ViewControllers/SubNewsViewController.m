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
#import "LoginViewController.h"

@interface SubNewsViewController ()<UITableViewDelegate, UITableViewDataSource,SubNewsListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) InfoCoverModel * mainModel;
@property (nonatomic, strong) NSMutableArray<InfoListModel *> * dataArray;

@end

@implementation SubNewsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self refreshData];
}
- (void)creatUI{
    //第一次进入时才显示
    [SVProgressHUD show];
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Nav64 - Tab49 - Anno750(80)) style:UITableViewStyleGrouped delegate:self];
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
    return self.dataArray.count+1;
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"SubNewsHeadCell";
        SubNewsHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubNewsHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithObjModel:self.mainModel];
        return cell;
    }
    static NSString * cellid = @"SubNewsListCell";
    SubNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithObjectModel:self.dataArray[indexPath.section - 1]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * url;
    InfoListModel * model;
    if (indexPath.section == 0) {
        url = self.mainModel.app_iframe;
        model = [[InfoListModel alloc]init];
        model.share_link = self.mainModel.share_link;
        model.title = self.mainModel.title;
        model.pic_thumbnail = self.mainModel.pic;
    }else{
        url = self.dataArray[indexPath.section - 1].app_iframe;
        model = self.dataArray[indexPath.section - 1];
    }
    WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"资讯" url:url];
    vc.infoModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)refreshData{
    self.mainModel = nil;
    [self.dataArray removeAllObjects];
    [self getData];
}
- (void)loadMoreData{
    [self getData];
}
- (void)getData{
    NSDictionary * params = @{
                              @"last_id":self.dataArray.count == 0 ? @"" :self.dataArray.lastObject.id,
                              @"uid":[UserManager manager].isLogin ? [UserManager manager].userID : @"",
                              @"last_time":self.dataArray.count == 0 ? @"" :self.dataArray.lastObject.time_stamp
                                  };
    [[NetWorkManger manager] sendRequest:NewWest_Info route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSArray * covers = dic[@"cover"];
        NSArray * arr = dic[@"list"];
        if (!self.mainModel && covers.count >0) {
            self.mainModel = [[InfoCoverModel alloc]initWithDictionary:covers.firstObject];
        }
        for (int i = 0; i<arr.count; i++) {
            InfoListModel * model = [[InfoListModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        [self.refreshHeader endRefreshing];
        [self hiddenNullView];
        if (arr.count < 9) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
        if (!self.mainModel && self.dataArray.count == 0) {
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

- (void)collectThisCellItem:(UIButton *)btn{
    
    if (![UserManager manager].isLogin) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"您还没有登录，请先登录" duration:1.0f];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    UITableViewCell * cell = (UITableViewCell *)[btn superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    InfoListModel * model = self.dataArray[indexpath.section - 1];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":model.cont_type,
                              @"id":model.id
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"收藏成功";
        if (model.collected) {
            title = @"取消收藏";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        model.collected = !model.collected;
        if (model.collected) {
            model.collect_num = @(model.collect_num.intValue + 1);
        }else{
            model.collect_num = @(model.collect_num.intValue - 1);
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}


@end
