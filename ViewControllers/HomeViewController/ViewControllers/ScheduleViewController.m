//
//  ScheduleViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ScheduleViewController.h"
#import "ScheduleListCell.h"
#import "MatchListModel.h"
#import "GameDetailTabViewController.h"
#import "HomeInfoModel.h"
#import "VideoPlayViewController.h"

@interface ScheduleViewController ()<UITableViewDelegate,UITableViewDataSource,ScheduleListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray<MatchListModel *> * dataArray;
@property (nonatomic, strong) HomeInfoModel * requestInfo;
//当加载更多上周数据时  上周参数
@property (nonatomic, strong) InfoParams * preInfo;
//当加载更多下周数据时  下周参数
@property (nonatomic, strong) InfoParams * nextInfo;
//滑动到的位置，先获取是否有直播的，没有直播则使用第一个 将要开赛的
@property (nonatomic, strong) NSIndexPath * indexPath;
@end

@implementation ScheduleViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getData];
    
}
- (void)creatUI{
    self.dataArray =[NSMutableArray new];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 49 - 64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadUpWeekData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNextWeekData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray[section].list.count + 2;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [Factory creatViewWithColor:Color_BackGround];
    view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
    UIButton * button = [Factory creatButtonWithTitle:@""
                                      backGroundColor:[UIColor clearColor]
                                            textColor:Color_LightGray
                                             textSize:font750(26)];
    NSString * title = [NSString stringWithFormat:@"  %@  %@",self.dataArray[section].c_date,self.dataArray[section].c_date_w];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"sidebar_icon_calendar_default"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].list.count+1) {
        return Anno750(20);
    }
    return Anno750(220);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].list.count+1) {
        static NSString * cellid = @"grayCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.backgroundColor = Color_BackGround2;
        return cell;
    }
    static NSString * cellid = @"ScheduleListCell";
    ScheduleListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ScheduleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delgate = self;
    [cell updateWithMatchDetailModel:self.dataArray[indexPath.section].list[indexPath.row -1]];
    cell.line.hidden = indexPath.row == 1 ? YES : NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].list.count + 1) {
        return;
    }
    MatchDetailModel * model = self.dataArray[indexPath.section].list[indexPath.row - 1];
    GameDetailTabViewController * vc = [[GameDetailTabViewController alloc]initWithGameID:model.gameId matchStatus:model.match_state.integerValue];
    if (model.live_h5_url.length>0) {
        vc.liveUrl = model.live_h5_url;
    }
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getData{
    [self requestDataWithParmas:@{}];
}
- (void)requestDataWithParmas:(NSDictionary *)params{
    [self.dataArray removeAllObjects];
    [self requestDataWithParmas:params isRefresh:NO isUp:NO];
}

- (void)requestDataWithParmas:(NSDictionary *)params isRefresh:(BOOL)rec isUp:(BOOL)isUp{
    [SVProgressHUD show];
    
    [[NetWorkManger manager] sendRequest:PageSchedules route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        NSDictionary * dic = result[@"info"];
        self.requestInfo = [[HomeInfoModel alloc]initWithDictionary:dic];
        //更新参数
        if (!rec) {
            self.preInfo = self.requestInfo.pre;
            self.nextInfo = self.requestInfo.next;
        }
        
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            MatchListModel * model = [[MatchListModel alloc]initWithDictionary:arr[i]];
            
            if (!self.indexPath) {
                for (int j = 0; j<model.list.count; j++) {
                    if (model.list[j].match_state.integerValue != 2) {
                        self.indexPath = [NSIndexPath indexPathForRow:j+1 inSection:i];
                        break;
                    }
                }
            }
            [muarr addObject:model];
        }
        if (rec && !isUp) {//当在加载更多   且属于 下拉时
            [muarr addObjectsFromArray:self.dataArray];
            self.dataArray = [NSMutableArray arrayWithArray:muarr];
        }else{
            [self.dataArray addObjectsFromArray:muarr];
        }
        
        if (rec) {
            if (isUp) {
                self.nextInfo = self.requestInfo.next;
            }else{
                self.preInfo = self.requestInfo.pre;
            }
        }
        //判断第一次进入时 是否存在indexpath
        if (!self.indexPath) {
            MatchListModel * model = self.dataArray.lastObject;
            self.indexPath = [NSIndexPath indexPathForRow:model.list.count inSection:self.dataArray.count - 1];
        }
        [self.tabview reloadData];
        //证明是的第一次进入  需要移动到最近比赛的地方
        if (params.allKeys.count == 0) {
            [self.tabview scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        
        [self.refreshHeader endRefreshing];
        if (self.requestInfo.next.match_type && self.requestInfo.next.match_type.length>0) {
            [self.refreshFooter endRefreshing];
        }else{
            if (isUp) {
                [self.refreshFooter endRefreshingWithNoMoreData];
            }else{
                [self.refreshFooter endRefreshing];
            }
        }
    } error:^(NFError *byerror) {
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}
#pragma mark - 加载上周比赛内容
- (void)loadUpWeekData{
    if (self.preInfo.match_type && self.preInfo.match_type.length>0) {
        NSDictionary * params = @{
                                  @"type":self.preInfo.match_type,
                                  @"week":self.preInfo.week
                                  };
        [self requestDataWithParmas:params isRefresh:YES isUp:NO];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"已经是最早赛程了" duration:1.0f];
        [self.refreshHeader endRefreshing];
    }
}
#pragma mark - 加载下周比赛内容
- (void)loadNextWeekData{
    NSDictionary * params = @{
                              @"type":self.nextInfo.match_type,
                              @"week":self.nextInfo.week
                              };
    [self requestDataWithParmas:params isRefresh:YES isUp:YES];
}


- (void)checkOverMatchVideo:(UIButton *)btn{
    UITableViewCell * cell = (UITableViewCell *)[[btn superview] superview];
    NSIndexPath * index = [self.tabview indexPathForCell:cell];
    MatchListModel * list = self.dataArray[index.section];
    MatchDetailModel * model = list.list[index.row - 1];
    if (model.video.length>0) {
        VideoPlayViewController * vc = [[VideoPlayViewController alloc]initWithUrl:[NSURL URLWithString:model.video]];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"链接丢失了。。去看看其他的吧" duration:1.0f];
    }
}

@end
