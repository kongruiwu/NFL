//
//  DataViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "DataViewController.h"
#import "TeamDataView.h"
@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TeamDataView * view = [[TeamDataView alloc]initWithFrame:CGRectMake(0, Anno750(300), UI_WIDTH, Anno750(800))];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
