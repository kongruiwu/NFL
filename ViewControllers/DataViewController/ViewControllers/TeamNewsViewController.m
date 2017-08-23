//
//  TeamNewsViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamNewsViewController.h"
#import "SubNewsListCell.h"
#import "InfoListModel.h"
#import "VideoListModel.h"
#import "WKWebViewController.h"
#import "VideoDetailViewController.h"
@interface TeamNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation TeamNewsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    
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
    id obj = self.dataArray[indexPath.section];
    if ([obj isKindOfClass:[InfoListModel class]]) {
        InfoListModel * model = self.dataArray[indexPath.section];
        WKWebViewController * web = [[WKWebViewController alloc]initWithTitle:@"资讯" url:model.app_iframe];
        web.infoModel = model;
        [self.navigationController pushViewController:web animated:YES];
    }else{
        VideoListModel * model = self.dataArray[indexPath.section];
        VideoDetailViewController * vc = [[VideoDetailViewController alloc]init];
        vc.videoID = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"team_id":self.teamID,
                              @"page":@"newset"
                              };
    [[NetWorkManger manager] sendRequest:TeamDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
        if (self.tabview) {
            NSDictionary * dic = result[@"data"];
            NSArray * arr = dic[@"newset_list"];
            for (int i = 0; i<arr.count; i++) {
                NSDictionary * dict = arr[i];
                if ([dict[@"cont_type"] isEqualToString:@"news"]) {
                    InfoListModel * model = [[InfoListModel alloc] initWithDictionary:dict];
                    [self.dataArray addObject:model];
                }else if([dict[@"cont_type"] isEqualToString:@"video"]){
                    VideoListModel * model = [[VideoListModel alloc] initWithDictionary:dict];
                    [self.dataArray addObject:model];
                }
            }
            [self.tabview reloadData];
        }
        [self updateTabFooter];
    } error:^(NFError *byerror) {
        
    }];
}
@end
