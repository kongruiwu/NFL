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


@interface GameDataViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray * sectionTitles;
@property (nonatomic, strong) UISegmentedControl * segmentbtn;

@end

@implementation GameDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self setNavAlpha];
   
}
- (void)creatUI{
    self.sectionTitles = @[@"得分",@"球队数据",@"球员"];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(80) - 64) style:UITableViewStylePlain delegate:self];
    self.tabview.tag = 1000;
    [self.view addSubview:self.tabview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if(section == 1){
        return 6;
    }else if(section == 2){
        return 13;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitles.count;
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
        
        self.segmentbtn = [[UISegmentedControl alloc]initWithItems:@[@"新英格兰爱国者",@"休斯顿德州人"]];
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
        [cell updateWithTitles:@[@"1",@"13",@"3",@"13",@"28"]];
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
    return cell;
}
- (UITableViewCell *)getThirdSectionCell:(NSIndexPath *)index{
    static NSString * cellid = @"DataTeamTitleCell";
    DataTeamTitleCell * cell = [self.tabview dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[DataTeamTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (index.row == 0 || index.row == 2 || index.row == 6 || index.row == 9) {
        [cell updateWithtitles:@[@"冲球",@"接球率",@"码数",@"达阵",@"抄截"] isTitle:YES];
    }else{
        [cell updateWithtitles:@[@"汤姆·布雷迪",@"24/38",@"302",@"3",@"1"] isTitle:NO];
    }
    return cell;
}


- (void)segmentbtnSelect:(UISegmentedControl *)segement{
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (targetContentOffset->y > (Anno750(480 - 80) - 64)/2 && targetContentOffset->y <= Anno750(480 - 80) - 64) {
        targetContentOffset->y = Anno750(480 - 80) - 64;
    }else if(targetContentOffset->y < (Anno750(480 - 80) - 64)/2){
        targetContentOffset->y = 0;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(hiddenOutHeadView:)]) {
        [self.delegate hiddenOutHeadView:scrollView.contentOffset.y];
    }
}

@end
