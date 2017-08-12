//
//  SubVideoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubVideoViewController.h"
#import "VideoPlayCell.h"
#import "VideoDetailViewController.h"
#import "VideoListModel.h"
#import "VideoPlayViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface SubVideoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<VideoListModel *> * dataArray;
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic) NSInteger index;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playLayer;

@end

@implementation SubVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64- Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(275 * 2);
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
    VideoPlayViewController * video = [[VideoPlayViewController alloc]initWithUrl:[NSURL URLWithString:self.dataArray[indexPath.section].src]];
    [self presentViewController:video animated:YES completion:nil];
//    VideoDetailViewController * vc = [VideoDetailViewController new];
//    vc.videoID = self.dataArray[indexPath.section].id;
//    [self.navigationController pushViewController:vc animated:YES];
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
    NSString * action;
    switch (self.videoType) {
        case VideoTypeBallStar:
            action = @"star";
            break;
        case VideoTypeMatch:
            action = @"match";
            break;
        case VideoTypeTidbits:
            action = @"tidbits";
            break;
        case VideoTypeTeach:
            action = @"teach";
            break;
        case VideoTypeInFollow:
            action = @"follow_list";
            break;
        default:
            break;
    }
    
    NSDictionary * params =@{
                             @"last_id":self.dataArray.count == 0 ? @"" : self.dataArray.lastObject.id,
                             @"type":action,
                             };
    [[NetWorkManger manager] sendRequest:Video_List route:Route_Viedeo withParams:params complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * dic = result[@"data"];
        NSArray * list = dic[@"list"];
        for (int i = 0; i<list.count; i++) {
            VideoListModel * model = [[VideoListModel alloc]initWithDictionary:list[i]];
            [self.dataArray addObject:model];
        }
        if (list.count == 0 && self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self.tabview reloadData];
        }
        [self.refreshHeader endRefreshing];
        if (list.count < 10) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}


@end
