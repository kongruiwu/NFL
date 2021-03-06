//
//  TeamerRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerRankViewController.h"
#import "TeamerRankListCell.h"
#import "SelectTimeView.h"
#import "PlayerRankModel.h"
#import "TeamerRankHeader.h"
@interface TeamerRankViewController ()<UITableViewDelegate,UITableViewDataSource,SelectTimeViewDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) SelectTimeView * timeView;
@property (nonatomic, strong) SelectTimeView * seasonView;
@property (nonatomic, strong) NSMutableArray<PlayerRankModel *> * dataArray;
@property (nonatomic) NSInteger defaultWeek;
@property (nonatomic) NSInteger defaultSeason;
@property (nonatomic, strong) UIButton * weekBtn;
@property (nonatomic, strong) UIButton * seasonBtn;


@end

@implementation TeamerRankViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.timeView.delegate = nil;
    self.seasonView.delegate = nil;
    [self.timeView removeFromSuperview];
    [self.seasonView removeFromSuperview];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.seasonView = [[SelectTimeView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) isSeason:YES];
    self.seasonView.delegate = self;
    [self.tabBarController.view addSubview:self.seasonView];
    
    self.timeView = [[SelectTimeView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) isTeam:YES defaultWeek:self.defaultWeek];
    self.timeView.delegate = self;
    [self.timeView reloadDataWithSeason:100];
    [self.tabBarController.view addSubview:self.timeView];
    
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultWeek = 0;
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(130), UI_WIDTH, UI_HEGIHT- Anno750(80) - Tab49 - Nav64 - Anno750(130)) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
    UIView * headview = [Factory creatViewWithColor:[UIColor clearColor]];
    headview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(130));
    
    
    UIButton * seasonBtn = [Factory creatButtonWithTitle:@"--赛季"
                                         backGroundColor:[UIColor clearColor]
                                               textColor:Color_MainBlue
                                                textSize:font750(26)];
    self.seasonBtn = seasonBtn;
    seasonBtn.layer.borderColor = Color_MainBlue.CGColor;
    seasonBtn.layer.borderWidth = 1.0f;
    seasonBtn.layer.cornerRadius = Anno750(30);
    [headview addSubview:seasonBtn];
    [seasonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headview.mas_centerX).offset(-Anno750(40));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(220)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.seasonBtn addTarget:self action:@selector(pushSeasonView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * weekBtn = [Factory creatButtonWithTitle:[NSString stringWithFormat:@"第%ld周",self.defaultWeek]
                                       backGroundColor:[UIColor clearColor]
                                             textColor:Color_MainBlue
                                              textSize:font750(26)];
    self.weekBtn = weekBtn;
    [weekBtn addTarget:self action:@selector(pushTimeView) forControlEvents:UIControlEventTouchUpInside];
    weekBtn.layer.borderColor = Color_MainBlue.CGColor;
    weekBtn.layer.borderWidth = 1.0f;
    weekBtn.layer.cornerRadius = Anno750(30);
    [headview addSubview:weekBtn];
    [weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headview.mas_centerX).offset(Anno750(40));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(220)));
        make.height.equalTo(@(Anno750(60)));
    }];
    
    [self.view addSubview:headview];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(120);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(110);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TeamerRankHeader * header = [[TeamerRankHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(110))];
    [header updateWithTitle:self.dataArray[section].title descs:self.dataArray[section].stats];
    return header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataArray.count > 0) {
        return self.dataArray[section].rank.count;
    }else{
        return 0;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"TeamerRankListCell";
    TeamerRankListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TeamerRankListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithRankPlayer:self.dataArray[indexPath.section].rank[indexPath.row]];
    return cell;
}
- (void)pushTimeView{
    [self.timeView show];
}
- (void)pushSeasonView{
    [self.seasonView show];
}
- (void)updateSeasonInfo:(NSDictionary *)dic{
    self.defaultWeek = [dic[@"week"] intValue];
    self.defaultSeason = [dic[@"season"] integerValue];
    if (self.seasonView) {
        [self.seasonView updateSeasonViewWithDefaultSeason:self.defaultSeason SeasonArray:dic[@"season_list"]];
    }
    if (self.defaultSeason > 2000 && self.defaultWeek >0) {
        [self getData];
    }
}
- (void)selectSeasonSection:(NSInteger)season{
    self.defaultSeason = season;
    [self.seasonBtn setTitle:[NSString stringWithFormat:@"%ld赛季",(long)self.defaultSeason] forState:UIControlStateNormal];
    [self.timeView reloadDataWithSeason:self.defaultSeason];
}
- (void)selectTimeSection:(TimeListModel *)model{
    self.defaultWeek = [model.week integerValue];
    [self.weekBtn setTitle:[NSString stringWithFormat:@"第%ld周",self.defaultWeek] forState:UIControlStateNormal];
    
    [self getData];
}
- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{};
    if (self.defaultWeek != 0) {
        params = @{
                   @"week":@(self.defaultWeek)
                   };
        if (self.defaultSeason >200) {
            params =  @{
                        @"week":@(self.defaultWeek),
                        @"season":@(self.defaultSeason)
                        };
        }
    }
    [[NetWorkManger manager] sendRequest:PagePlayerRank route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSDictionary * info = result[@"info"];
        self.defaultWeek = [info[@"week"] intValue];
        [self.dataArray removeAllObjects];
        [self.weekBtn setTitle:[NSString stringWithFormat:@"第%ld周",self.defaultWeek] forState:UIControlStateNormal];
        self.defaultSeason = [info[@"season"] integerValue];
        [self.seasonBtn setTitle:[NSString stringWithFormat:@"%ld赛季",(long)self.defaultSeason] forState:UIControlStateNormal];
        NSArray * list = dic[@"list"];
        for (int i = 0; i<list.count; i++) {
            PlayerRankModel * model = [[PlayerRankModel alloc]initWithDictionary:list[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
        [SVProgressHUD dismiss];
    } error:^(NFError *byerror) {
        [SVProgressHUD dismiss];
    }];
}

@end
