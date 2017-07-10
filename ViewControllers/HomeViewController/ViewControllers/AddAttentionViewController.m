//
//  AddAttentionViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AddAttentionViewController.h"

@interface AddAttentionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tabview;


@end

@implementation AddAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"添加关注"];
    
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
