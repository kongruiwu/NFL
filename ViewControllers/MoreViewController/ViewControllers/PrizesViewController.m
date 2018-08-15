//
//  PrizesViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/20.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "PrizesViewController.h"
#import "PrizeListCell.h"
#import "PrizeHeader.h"
#import "PrizeDetailViewController.h"
#import "PrizeListModel.h"
@interface PrizesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) PrizeHeader * header;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) BOOL isLanuch;
@end

@implementation PrizesViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isLanuch) {
        [self setNavAlpha];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavUnAlpha];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setNavAlpha];
    self.isLanuch = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self creatUI];
    [self getData];
}

- (void)creatUI{
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, - Nav64, UI_WIDTH, UI_HEGIHT+Nav64) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(400);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * head = [Factory creatViewWithColor:Color_BackGround];
    head.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(400));
    
    self.header = [[PrizeHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(320))];
    [self.header updateScore];
    [head addSubview:self.header];
    UILabel * label = [Factory creatLabelWithText:@"兑换奖品"
                                        fontValue:font750(30)
                                        textColor:Color_MainBlack
                                    textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont boldSystemFontOfSize:font750(30)];
    [head addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@(Anno750(80)));
    }];
    return head;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(220);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"PrizeListCell";
    PrizeListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[PrizeListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
    }
    [cell updateWithPrizeListModel:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PrizeDetailViewController * vc =  [PrizeDetailViewController new] ;
    vc.prize = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].info.uid
                              };
    [[NetWorkManger manager] sendRequest:Page_PrizeList route:Route_ScoreRank withParams:params complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            PrizeListModel * model = [[PrizeListModel alloc]initWithDictionary:arr[i]];
            [self.dataArray addObject:model];
        }
        [self.tabview reloadData];
        [SVProgressHUD dismiss];
    } error:^(NFError *byerror) {
        [SVProgressHUD dismiss];
    }];
    
}


//设置头部拉伸效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //图片高度
    CGFloat imageHeight = self.header.frame.size.height;
    //图片宽度
    CGFloat imageWidth = UI_WIDTH;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.header.backImg.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}
@end
