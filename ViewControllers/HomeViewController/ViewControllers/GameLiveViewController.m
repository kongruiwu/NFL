//
//  GameLiveViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/3.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameLiveViewController.h"
#import "GameLiveListCell.h"

//直播
@interface GameLiveViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation GameLiveViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.timer && self.viewModel.match_state.integerValue == 1) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(getData) userInfo:nil repeats:YES];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
}
- (void)creatUI{
    
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.play_by_play[section].list.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.play_by_play.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [Factory getSize:self.viewModel.play_by_play[indexPath.section].list[indexPath.row].content maxSize:CGSizeMake(Anno750(517), 999999) font:[UIFont systemFontOfSize:font750(24)]];
    return Anno750(34 + 24) + size.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * head = [Factory creatViewWithColor:[UIColor whiteColor]];
    head.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
    UIButton * nameBtn = [Factory creatButtonWithNormalImage:@"content_icon_football_blue" selectImage:@"content_icon_football_red"];
    [nameBtn setTitleColor:Color_MainBlue forState:UIControlStateNormal];
    [nameBtn setTitleColor:Color_MainRed forState:UIControlStateSelected];
    NSString * teamName = [NSString stringWithFormat:@"  %@",self.viewModel.play_by_play[section].team_name];
    [nameBtn setTitle:teamName forState:UIControlStateNormal];
    nameBtn.selected = [self.viewModel.play_by_play[section].team containsString:@"home"] ? YES : NO;
    nameBtn.titleLabel.font = [UIFont systemFontOfSize:Anno750(20)];
    UIView * line = [Factory creatLineView];
    [head addSubview:nameBtn];
    [head addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.width.equalTo(@0.5);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(line.mas_left);
        make.top.equalTo(@(Anno750(20)));
    }];
    return head;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (self.isPlaying) {
//        return nil;
//    }
    UIView * footer = [Factory creatViewWithColor:[UIColor whiteColor]];
    footer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(50));
    
    UIView * line = [Factory creatLineView];
    UILabel * descLabel = [Factory creatLabelWithText:@""
                                            fontValue:font750(20)
                                            textColor:Color_MainRed
                                        textAlignment:NSTextAlignmentLeft];
    descLabel.numberOfLines = 0;
    [footer addSubview:line];
    [footer addSubview:descLabel];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(160)));
        make.width.equalTo(@0.5);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line.mas_right).offset(Anno750(48));
        make.bottom.equalTo(@(-Anno750(10)));
        make.right.equalTo(@(-Anno750(24)));
    }];
    return footer;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"GameLiveListCell";
    GameLiveListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GameLiveListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithLiveDetailModel:self.viewModel.play_by_play[indexPath.section].list[indexPath.row]];
    return cell;
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (targetContentOffset->y > (Anno750(480 - 80) - 64)/2 && targetContentOffset->y <= Anno750(480 - 80) - 64) {
        targetContentOffset->y = Anno750(480 - 80) - 64;
    }else if(targetContentOffset->y < (Anno750(480 - 80) - 64)/2){
        targetContentOffset->y = 0;
    }
}



- (void)getData{
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    NSDictionary * params =@{
                             @"game_id":self.viewModel.gameId,
                             };
    NSString * url = @"http://www.nflchina.com/api_nginx/get_match_info_by_gameid.php";
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * resp = (NSDictionary *)responseObject;
        NSDictionary * dic = resp[@"result"];
        NSArray * arr = dic[@"play_by_play"];
        if (arr.count == 0) {
            if (self.timer) {
                [self.timer invalidate];
                self.timer = nil;
            }
        }
        for (int i = 0; i<arr.count; i++) {
            LiveModel * model = [[LiveModel alloc]initWithDictionary:arr[i]];
            if (model.list.lastObject.play_id.integerValue > self.viewModel.play_by_play.lastObject.list.lastObject.play_id.integerValue) {
                [self.viewModel.play_by_play addObject:model];
            }
        }
        [self.tabview reloadData];
        [self scrollToEnd];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)scrollToEnd{
    NSUInteger section = [self.tabview numberOfSections];
    if (section == 0 ) {
        return;
    }
    NSUInteger rowCount = [self.tabview numberOfRowsInSection:section - 1];
    if (rowCount == 0) {
        return;
    }
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowCount-1 inSection:section-1];
    [self.tabview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (void)setViewModel:(LiveViewModel *)viewModel{
    _viewModel = viewModel;
    if (_viewModel.match_state.integerValue == 1) {
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(getData) userInfo:nil repeats:YES];
        }
    }
    [self.tabview reloadData];
    [self updateTabFooter];
}
@end
