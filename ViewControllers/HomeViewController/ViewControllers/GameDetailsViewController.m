//
//  GameDetailsViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameDetailsViewController.h"
#import "GameHeaderView.h"
#import "GameSegmentView.h"
@interface GameDetailsViewController ()<UIScrollViewDelegate>
//<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) GameHeaderView * header;
@property (nonatomic, strong) GameSegmentView * segmentView;
@property (nonatomic, strong) UIScrollView * mainScrol;
@end

@implementation GameDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"比赛详情"];
    [self NavSetting];
    [self creatUI];
}
- (void)NavSetting{
    [self setNavAlpha];
//    [self setEdgesForExtendedLayout:UIRectEdgeTop];
//    self.navigationController.navigationBar.translucent = NO;
//    self.extendedLayoutIncludesOpaqueBars = YES;
}
- (void)creatUI{
    
    self.mainScrol = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    self.mainScrol.backgroundColor = [UIColor redColor];
    self.mainScrol.contentSize = CGSizeMake(UI_WIDTH, UI_HEGIHT + Anno750(490) - 64);
    self.mainScrol.delegate = self;
    [self.view addSubview:self.mainScrol];
//    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
//    [self.view addSubview:self.tabview];
    self.header = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(560))];
    self.segmentView = [[GameSegmentView alloc]initWithFrame:CGRectMake(0, Anno750(490), UI_WIDTH, Anno750(70))];
    [self.header addSubview:self.segmentView];
    
    [self.mainScrol addSubview:self.header];
//    self.tabview.tableHeaderView = self.header;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return Anno750(560);
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    self.header = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(560))];
//    
//    return self.header;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = @"celllllll......";
    return cell;
}
//设置头部拉伸效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    scrollView.bounces = (scrollView.contentOffset.y >= 180) ? NO : YES;

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
        
        self.header.groundImg.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
//
    self.header.groundImg.alpha = 1 - (imageOffsetY/(CGFloat)(Anno750(560) - 64 - Anno750(70)))/2;
    self.header.blueImg.alpha = imageOffsetY/(CGFloat)(Anno750(560) - 64 - Anno750(70));
//
//    NSLog(@"%f",imageOffsetY);
//    
//    if ((int)self.header.blueImg.alpha == 1) {
//        self.segmentView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(70));
//        self.segmentView.groundImg.alpha = 1;
//        [self.segmentView removeFromSuperview];
//        [self.view addSubview:self.segmentView];
//        [self setNavUnAlpha];
//        [self setNavLineHidden];
//        self.tabview.tableHeaderView = nil;
//        self.tabview.frame = CGRectMake(0, Anno750(70), UI_WIDTH, UI_HEGIHT - Anno750(70));
//    }
}




@end
