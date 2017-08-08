//
//  VideoDetailViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "SubNewsListCell.h"
#import "VideoHeadCell.h"
#import "VideoDetailModel.h"
@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) VideoDetailModel * videoModel;

@end

@implementation VideoDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"视频详情"];
    [self drawBackButton];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(30)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.videoModel.recommend_list.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [Factory getSize:self.videoModel.content maxSize:CGSizeMake(UI_WIDTH - Anno750(48), 99999) font:[UIFont systemFontOfSize:font750(26)]];
    
    return indexPath.section == 0 ? Anno750(570) + size.height : Anno750(160);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 1 ? Anno750(60) : 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 0.01 : Anno750(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel * label = [Factory creatLabelWithText:@"推荐视频"
                                            fontValue:font750(24)
                                            textColor:Color_DarkGray
                                        textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = Color_BackGround;
        label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
        return label;
    }else{
        return nil;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"VideoHeadCell";
        VideoHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[VideoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        [cell updateWithDetailModel:self.videoModel];
        return cell;
    }else{
        static NSString * cellid = @"SubNewsListCell";
        SubNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithObjectModel:self.videoModel.recommend_list[indexPath.section - 1]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else{
        VideoDetailViewController * vc = [[VideoDetailViewController alloc]init];
        vc.videoID = self.videoModel.recommend_list[indexPath.section - 1].id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showNetChangeMessage{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您现在使用的是运营商网络\n继续观看可能产生超额流量费用" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * play = [UIAlertAction actionWithTitle:@"继续播放" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * cannce = [UIAlertAction actionWithTitle:@"取消播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:play];
    [alert addAction:cannce];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)getData{
    NSDictionary * params = @{
                              @"id":self.videoID
                              };
    [[NetWorkManger manager] sendRequest:Video_Detail route:Route_Viedeo withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.videoModel = [[VideoDetailModel alloc]initWithDictionary:dic];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}

@end
