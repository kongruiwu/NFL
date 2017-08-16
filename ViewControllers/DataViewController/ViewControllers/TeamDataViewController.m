//
//  TeamDataViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamDataViewController.h"
#import "TeamDataCell.h"
@interface TeamDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TeamDataViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UI_HEGIHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"TeamDataCell";
    TeamDataCell * cell = [tableView dequeueReusableCellWithIdentifier: cellid];
    if (!cell) {
        cell = [[TeamDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"page":@"data"
                              };
    [[NetWorkManger manager] sendRequest:TeamDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSLog(@"%@",result);
    } error:^(NFError *byerror) {
        
    }];
}

@end
