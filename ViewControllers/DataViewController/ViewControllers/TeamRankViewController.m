//
//  TeamRankViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamRankViewController.h"
#import "UnionTeamRankCell.h"
#import "TeamHeadView.h"
#import "TeamUnionHeadView.h"
#import "SubTeamRankCell.h"
#import "TeamRankModel.h"
#import "TeamDeatailViewController.h"
#import "SubTeamRankModel.h"
@interface TeamRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISegmentedControl * segmentbtn;
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, assign) BOOL isSub;
@property (nonatomic, strong) NSMutableArray * dataArrays;
@property (nonatomic, strong) NSArray * sectionNames;

@end

@implementation TeamRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getData];

}
- (void)creatUI{
    /*@[@"AFC_N",@"AFC_E",@"AFC_S",@"AFC_W",@"NFC_N",@"NFC_E",@"NFC_S",@"NFC_W"];*/
    self.sectionNames = @[@"美联北部分区球队",@"美联东部分区球队",@"美联南部分区球队",@"美联西部分区球队",@"国联北部分区球队",@"国联东部分区球队",@"国联南部分区球队",@"国联西部分区球队"];
    self.dataArrays = [NSMutableArray new];
    
    UIView * clearview = [Factory creatViewWithColor:[UIColor clearColor]];
    clearview.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(125));
    [self.view addSubview:clearview];
    
    self.segmentbtn = [[UISegmentedControl alloc]initWithItems:@[@"联盟",@"分区"]];
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
    [clearview addSubview:self.segmentbtn];
    [self.segmentbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(450)));
        make.height.equalTo(@(Anno750(60)));
    }];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(125), UI_WIDTH, UI_HEGIHT - Anno750(125)- Anno750(80) - Tab49 - Nav64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.isSub) {
        TeamHeadView * headview = [[TeamHeadView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(80))];
        headview.nameLabel.text = self.sectionNames[section];
        return headview;
    }else{
        TeamUnionHeadView * headview = [[TeamUnionHeadView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(80))];
        headview.nameLabel.text = section == 0 ? @"美联球队" : @"国联球队";
        return headview;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(80);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arr = self.dataArrays[indexPath.section];
    if (indexPath.row == arr.count) {
        return Anno750(20);
    }
    return Anno750(80);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArrays.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = self.dataArrays[section];
    return arr.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arr = self.dataArrays[indexPath.section];
    //这里最后一个   添加一个 空白 背景色的 cell
    if (indexPath.row == arr.count) {
        static NSString * cellid = @"bankCell";
        UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            cell.backgroundColor = Color_BackGround;
        }
        return cell;
    }
    
    if (self.isSub) {
        static NSString * cellid = @"SubTeamRankCell";
        SubTeamRankCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubTeamRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithSubTeamRankModel:arr[indexPath.row]];
        return cell;
    }
    static NSString * cellid = @"UnionTeamRankCell";
    UnionTeamRankCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UnionTeamRankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithTeamRankModel:arr[indexPath.row]];
    return cell;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.navigationController pushViewController:[TeamDeatailViewController new] animated:YES];
//}

- (void)segmentbtnSelect:(UISegmentedControl *)segmentbtn{
    self.isSub = !self.isSub;
    [self getData];
}

- (void)getData{
    [self.dataArrays removeAllObjects];
    //【选填】排名方式。conference：联盟（默认）、division：分区
    NSDictionary * params = @{
                              @"type": self.isSub ? @"division" : @"conference",
                              };
    [[NetWorkManger manager] sendRequest:PageTeamRank route:Route_Match withParams:params complete:^(NSDictionary *result) {
        if (self.isSub) {
            NSArray * arr = @[@"AFC_N",@"AFC_E",@"AFC_S",@"AFC_W",@"NFC_N",@"NFC_E",@"NFC_S",@"NFC_W"];
            NSDictionary * dic = result[@"data"];
            for (int i = 0; i<arr.count; i++) {
                NSArray * datas = dic[arr[i]];
                NSMutableArray * muarr = [NSMutableArray new];
                for (int j = 0; j<datas.count; j++) {
                    SubTeamRankModel * model = [[SubTeamRankModel alloc]initWithDictionary:datas[j]];
                    [muarr addObject:model];
                }
                [self.dataArrays addObject:muarr];
            }
        }else{
            NSDictionary * dic = result[@"data"];
            NSArray * afcDatas = dic[@"AFC"];
            NSArray * nfcDatas = dic[@"NFC"];
            NSMutableArray * afcs = [NSMutableArray new];
            NSMutableArray * nfcs = [NSMutableArray new];
            for (int i = 0; i<afcDatas.count; i++) {
                NSDictionary * dic = afcDatas[i];
                TeamRankModel * model = [[TeamRankModel alloc]initWithDictionary:dic];
                [afcs addObject:model];
            }
            for (int i = 0; i<nfcDatas.count; i++) {
                NSDictionary * dic = nfcDatas[i];
                TeamRankModel * model = [[TeamRankModel alloc]initWithDictionary:dic];
                [nfcs addObject:model];
            }
            [self.dataArrays addObject:afcs];
            [self.dataArrays addObject:nfcs];
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}
@end
