//
//  GameInfoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameInfoViewController.h"
#import "GameInfoHeadCell.h"
#import "GameInfoHistoryCell.h"
#import "GameDetailTabViewController.h"
#import "WKWebViewController.h"

@interface GameInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * descs;

@end

@implementation GameInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
}
- (void)creatUI{
    self.titles = @[@"直播平台：",@"比赛时间：",@"比赛地点：",@"范特西游戏："];
    self.descs = @[@"",@"",@"",@""];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? self.titles.count : self.viewModel.vs_log.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 4) {
            return Anno750(80);
        }else{
            return Anno750(60);
        }
    }else{
        return Anno750(180);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 1 ? Anno750(60) : Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? Anno750(20) : 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [Factory creatViewWithColor:[UIColor whiteColor]];
        view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
        return view;
    }else{
        UILabel * label = [Factory creatLabelWithText:@"历史战绩"
                                            fontValue:font750(24)
                                            textColor:Color_LightGray
                                        textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = Color_BackGround;
        label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
        return label;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [Factory creatViewWithColor:[UIColor whiteColor]];
        view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
        return view;
    }else{
        return nil;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"headCell";
        GameInfoHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GameInfoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        
        [cell updateWithTitle:self.titles[indexPath.row] content:self.descs[indexPath.row]];
        return cell;
    }else{
        static NSString * cellid = @"historyCell";
        GameInfoHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GameInfoHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithLiveViewModel:self.viewModel.vs_log[indexPath.row]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        GameDetailTabViewController * vc = [[GameDetailTabViewController alloc]initWithGameID:self.viewModel.vs_log[indexPath.row].gameId matchStatus:MacthStatusOver];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 0){
        if (indexPath.row == 3) {
            WKWebViewController * web = [[WKWebViewController alloc]initWithTitle:@"天天NFL" url:self.viewModel.ttnfl_link];
            [self.navigationController pushViewController:web animated:YES];
        }
    }
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (targetContentOffset->y > (Anno750(480 - 80) - 64)/2 && targetContentOffset->y <= Anno750(480 - 80) - 64) {
        targetContentOffset->y = Anno750(480 - 80) - 64;
    }else if(targetContentOffset->y < (Anno750(480 - 80) - 64)/2){
        targetContentOffset->y = 0;
    }
}


- (void)setViewModel:(LiveViewModel *)viewModel{
    _viewModel = viewModel;
    self.descs = @[_viewModel.relay_platform,_viewModel.game_time_str,_viewModel.game_place,@"天天NFL"];
    [self.tabview reloadData];
    if (self.tabview.contentSize.height < UI_HEGIHT) {
        self.tabview.contentSize = CGSizeMake(0, UI_HEGIHT + Anno750(80));
    }
}

@end
