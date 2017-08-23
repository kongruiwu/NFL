//
//  GameNewsViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameNewsViewController.h"
#import "WKWebViewController.h"

@interface GameNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GameNewsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
    
}


- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"SubNewsListCell";
    SubNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithObjectModel:self.dataArray[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"资讯" url:self.dataArray[indexPath.section].app_iframe];
    vc.infoModel = self.dataArray[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

//- (void)getData{
//    [SVProgressHUD show];
//    NSDictionary * params = @{
//                              @"gameId":self.gameID,
//                              @"page":@"news"
//                              };
//    [[NetWorkManger manager] sendRequest:PageGameDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
//        if (self.tabview) {
//            NSDictionary * dic = result[@"data"];
//            NSArray * arr = dic[@"news_list"];
//            for (int i = 0; i<arr.count; i++) {
//                InfoListModel * model = [[InfoListModel alloc] initWithDictionary:arr[i]];
//                [self.dataArray addObject:model];
//            }
//            [self.tabview reloadData];
//        }
//        if (self.tabview.contentSize.height < UI_HEGIHT) {
//            self.tabview.contentSize = CGSizeMake(0, UI_HEGIHT + Anno750(80));
//        }
//    } error:^(NFError *byerror) {
//        
//    }];
//}

- (void)setDataArray:(NSMutableArray<InfoListModel *> *)dataArray{
    _dataArray = dataArray;
    [self.tabview reloadData];
    [self updateTabFooter];
}
@end
