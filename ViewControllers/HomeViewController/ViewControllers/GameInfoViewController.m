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

@interface GameInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GameInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT- Anno750(80) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
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
    return section == 1 ? Anno750(60) : 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"headCell";
        GameInfoHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GameInfoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }else{
        static NSString * cellid = @"historyCell";
        GameInfoHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[GameInfoHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }
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
