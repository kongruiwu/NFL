//
//  TeamersViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamersViewController.h"
#import "TeamHeader.h"
#import "TeamerLeftCell.h"
#import "TeamRightCell.h"
@interface TeamersViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) BOOL isRight;

@end

@implementation TeamersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI{
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(60);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(180);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TeamHeader * header = [[TeamHeader alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(180))];
    [header.segmentbtn addTarget:self action:@selector(checkindexStatus:) forControlEvents:UIControlEventValueChanged];
    return header;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isRight) {
        static NSString * cellid = @"rightCell";
        TeamRightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }else{
        static NSString * cellid = @"leftCell";
        TeamerLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamerLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        return cell;
    }
}

- (void)checkindexStatus:(UISegmentedControl *)segem{
    self.isRight = !self.isRight;
    [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(self.isRight ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight)];
}

@end
