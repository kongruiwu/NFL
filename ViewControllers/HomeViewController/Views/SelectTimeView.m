//
//  SelectTimeView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SelectTimeView.h"
#import "SelectTimeCell.h"
@implementation SelectTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
        [self getData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame isTeam:(BOOL)rec defaultWeek:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        self.isTeam = rec;
        self.defaultWeek = index;
        [self creatUI];
        [self getData];
    }
    return self;
}


- (void)getData{
    self.dateArray = [NSMutableArray new];
    
    [[NetWorkManger manager] sendRequest: self.isTeam ? PageRankTime: PageCalendar route:Route_Match withParams:@{} complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSArray * arr = dic[@"list"];
        for (int i = 0; i<arr.count; i++) {
            TimeListModel * model = [[TimeListModel alloc]initWithDictionary:arr[i]];
            model.isSelect = NO;
            if ([model.week integerValue] == self.defaultWeek) {
                model.isSelect = YES;
            }
            [self.dateArray addObject:model];
        }
        [SVProgressHUD dismiss];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}

- (void)creatUI{
    self.hidden = YES;
    self.backgroundColor = UIColorFromRGBA(0x000000, 0.3);
    
    self.cannceBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    self.cannceBtn.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(240));
    [self.cannceBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.showView = [Factory creatViewWithColor:[UIColor clearColor]];
    self.showView.frame = CGRectMake(0, UI_HEGIHT, UI_WIDTH, UI_HEGIHT - Anno750(240));
    
    self.grayView = [Factory creatViewWithColor:Color_BackGround];
    
    self.cannceImg = [Factory creatButtonWithNormalImage:@"list_icon_close_normal" selectImage:nil];
    [self.cannceImg addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, Anno750(90), UI_WIDTH, UI_HEGIHT - Anno750(330)) style:UITableViewStylePlain delegate:self];
    self.tabview.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:self.showView];
    [self.showView addSubview:self.grayView];
    [self.grayView addSubview:self.cannceImg];
    [self.showView addSubview:self.tabview];
    [self addSubview:self.cannceBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(90)));
    }];
    [self.cannceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(90)));
    }];
    [self.tabview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.grayView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"SelectTimeCell";
    SelectTimeCell * cell = [tableView dequeueReusableCellWithIdentifier: cellid];
    if (!cell) {
        cell = [[SelectTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithTimeListModel:self.dateArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i<self.dateArray.count; i++) {
        TimeListModel * model = self.dateArray[i];
        model.isSelect = i == indexPath.row ? YES : NO;
    }
    [self.tabview reloadData];
    [self disMiss];
    if ([self.delegate respondsToSelector:@selector(selectTimeSection:)]) {
        [self.delegate selectTimeSection:self.dateArray[indexPath.row]];
    }
}
- (void)show{
    self.hidden = NO;
    if (self.dateArray && self.dateArray.count>0) {
        [SVProgressHUD dismiss];
    }else{
        [SVProgressHUD show];
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        self.showView.frame = CGRectMake(0, Anno750(240), UI_WIDTH, UI_HEGIHT - Anno750(240));
    }];
}
- (void)disMiss{
    [SVProgressHUD dismiss];
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.showView.frame = CGRectMake(0, UI_HEGIHT, UI_WIDTH,UI_HEGIHT - Anno750(240));
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}


@end
