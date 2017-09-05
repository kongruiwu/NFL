//
//  GameDataViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameDataViewController.h"
#import "GameScoreTitleCell.h"
#import "GameScoreDescCell.h"
#import "TeamDataProgressCell.h"
#import "DataTeamTitleCell.h"
//数据
@interface GameDataViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) UISegmentedControl * segmentbtn;
@property (nonatomic, strong) NSArray * scoreSections;
/**是否是客场球队*/
@property (nonatomic) BOOL isVisitor;

@end

@implementation GameDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self setNavAlpha];
    [self getData];
   
}
- (void)creatUI{
    self.sectionTitles = @[@"得分",@"球队数据",@"球员"];
    self.scoreSections = @[@"传球码数",@"跑球码数",@"控球时间",@"攻防转换",@"3档转换成功率"];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80) - 64) style:UITableViewStylePlain delegate:self];
    self.tabview.tag = 1000;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return self.scoreSections.count + 1;
    }else if(section == 2){
        return !self.isVisitor ? self.viewModel.player_state.visitor.count : self.viewModel.player_state.home.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel ? self.sectionTitles.count : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return Anno750(60);
        }else if(indexPath.row == 3){
            return Anno750(20);
        }else{
            return Anno750(80);
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 5) {
            return Anno750(40);
        }else{
            return Anno750(80);
        }
    }else{
        return Anno750(60);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return Anno750(180);
    }
    return Anno750(60);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView * header = [Factory creatViewWithColor:Color_BackGround];
        header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(180));
        UILabel * label = [Factory creatLabelWithText:self.sectionTitles[section]
                                            fontValue:font750(24)
                                            textColor:Color_MainBlue
                                        textAlignment:NSTextAlignmentCenter];
        label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
        label.backgroundColor = Color_BackGround2;
        [header addSubview:label];
        
        self.segmentbtn = [[UISegmentedControl alloc]initWithItems:@[self.viewModel.visitor_name,self.viewModel.home_name]];
        self.segmentbtn.backgroundColor = [UIColor whiteColor];
        self.segmentbtn.layer.borderColor = Color_MainBlue.CGColor;
        self.segmentbtn.tintColor = Color_MainBlue;
        self.segmentbtn.layer.borderWidth = 1.0f;
        self.segmentbtn.layer.cornerRadius = Anno750(30);
        self.segmentbtn.layer.masksToBounds = YES;
        
        [self.segmentbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
        [self.segmentbtn setTitleTextAttributes:@{NSForegroundColorAttributeName:Color_MainBlue} forState:UIControlStateNormal];
        self.segmentbtn.selectedSegmentIndex = 0;
        [self.segmentbtn addTarget:self action:@selector(segmentbtnSelect:) forControlEvents:UIControlEventValueChanged];
        self.segmentbtn.selectedSegmentIndex = self.isVisitor ? 1 : 0;
        [header addSubview:self.segmentbtn];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.top.equalTo(@0);
            make.height.equalTo(@(Anno750(60)));
        }];
        [self.segmentbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(label.mas_bottom).offset(Anno750(30));
            make.width.equalTo(@(Anno750(137 * 2 * 2)));
            make.height.equalTo(@(Anno750(60)));
        }];
        
        return header;
    }else{
        UILabel * label = [Factory creatLabelWithText:self.sectionTitles[section]
                                            fontValue:font750(24)
                                            textColor:Color_MainBlue
                                        textAlignment:NSTextAlignmentCenter];
        label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
        label.backgroundColor = Color_BackGround2;
        return label;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [self getFristSectionCell:indexPath];
    }else if(indexPath.section == 1){
        return [self getSecodSectionCell:indexPath];
    }else{
        return [self getThirdSectionCell:indexPath];
    }
}
- (UITableViewCell *)getFristSectionCell:(NSIndexPath *)index{
    if (index.row == 0) {
        static NSString * cellid  =@"GameScoreTitleCell";
        GameScoreTitleCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GameScoreTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }else if(index.row == 3){
        static NSString * cellid = @"bankCell";
        UITableViewCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.backgroundColor = Color_BackGround;
        return cell;
    }else{
        static NSString * cellid  =@"GameScoreDescCell";
        GameScoreDescCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GameScoreDescCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        ScoreModel * model ;
        NSNumber * teamid;
        if (index.row == 2) {
            teamid = self.viewModel.home_teamId;
            model = self.viewModel.detail_point.home;
        }else{
            teamid = self.viewModel.visitor_teamId;
            model = self.viewModel.detail_point.visitor;
        }
        NSArray * arr = @[model.Q1,model.Q2,model.Q3,model.Q4,model.OT,model.total];
        [cell updateWithTitles:arr TeamId:teamid];
        return cell;
    }
}
- (UITableViewCell *)getSecodSectionCell:(NSIndexPath *)index{
    
    if (index.row == 5) {
        static NSString * cellid = @"bankCell";
        UITableViewCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    static NSString * cellid = @"TeamDataProgressCell";
    TeamDataProgressCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TeamDataProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    TeamScoreModel * model ;
    switch (index.row) {
        case 0:
            model = self.viewModel.team_state.pass_yards;
            break;
        case 1:
            model = self.viewModel.team_state.rush_yards;
            break;
        case 2:
            model = self.viewModel.team_state.hold_time;
            break;
        case 3:
            model = self.viewModel.team_state.turn_over;
            break;
        case 4:
            model = self.viewModel.team_state.thirddown_rate;
            break;
        default:
            break;
    }
    if (index.row == 4) {
        [cell updateThirdWithTitles:self.scoreSections[index.row] leftScore:model.home
                    rightScore:model.visitor];
    }else{
        [cell updateWithTitles:self.scoreSections[index.row] leftScore:model.home
                    rightScore:model.visitor isTime:index.row == 2 ? YES : NO];
    }
    
    return cell;
}
- (UITableViewCell *)getThirdSectionCell:(NSIndexPath *)index{
    static NSString * cellid = @"DataTeamTitleCell";
    DataTeamTitleCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DataTeamTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSArray * arr ;
    if (!self.isVisitor) {
        arr = self.viewModel.player_state.visitor;
    }else{
        arr = self.viewModel.player_state.home;
    }
    id values = arr[index.row];
    if ([values isKindOfClass:[NSArray class]]) {
        [cell updateWithtitles:arr[index.row]];
    }
    return cell;
}



- (void)segmentbtnSelect:(UISegmentedControl *)segement{
    self.isVisitor = !self.isVisitor;
    [self.tabview reloadData];
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
    [self.tabview reloadData];
    [self updateTabFooter];
}
@end
