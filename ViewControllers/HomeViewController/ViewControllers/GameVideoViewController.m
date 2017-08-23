//
//  GameVideoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameVideoViewController.h"
#import "VideoPlayCell.h"
#import "VideoDetailViewController.h"

@interface GameVideoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GameVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return VideoPlayCellHeigh;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"VideoPlayCell";
    VideoPlayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[VideoPlayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithVideoListModel:self.dataArray[indexPath.section]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoDetailViewController * vc = [VideoDetailViewController new];
    vc.videoID = self.dataArray[indexPath.section].id;
    [self.navigationController pushViewController:vc animated:YES];
}
//- (void)getData
//{
//    [SVProgressHUD show];
//    NSDictionary * params = @{
//                              @"gameId":self.gameID,
//                              @"page":@"videos",
//                              };
//    [[NetWorkManger manager] sendRequest:PageGameDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
//        NSDictionary * dic = result[@"data"];
//        NSArray * arr = dic[@"video_list"];
//        for (int i = 0; i<arr.count; i++) {
//            VideoListModel * model = [[VideoListModel alloc]initWithDictionary:arr[i]];
//            [self.dataArray addObject:model];
//        }
//        [self.tabview reloadData];
//        if (self.tabview.contentSize.height < UI_HEGIHT) {
//            self.tabview.contentSize = CGSizeMake(0, UI_HEGIHT + Anno750(80));
//        }
//    } error:^(NFError *byerror) {
//        
//    }];
//}
- (void)setDataArray:(NSMutableArray<VideoListModel *> *)dataArray{
    _dataArray = dataArray;
    [self.tabview reloadData];
    [self updateTabFooter];
}

@end
