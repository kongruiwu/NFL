//
//  AboutUsViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsCell.h"
@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * descs;

@end

@implementation AboutUsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"关于我们"];
    [self drawBackButton];
    [self creatUI];
    
}
- (void)creatUI{
    
    self.titles = @[@"微信公众号",@"微博帐号",@"官方网站",@"联系邮箱",@"当前版本"];
    NSString * version = [NSString stringWithFormat:@"v%@",[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    self.descs = @[@"NFL橄榄球",@"NFL橄榄球",@"nflchina.com",@"AskNFLChina@nfl.com",version];
    self.images = @[@"list_icon_wechat",@"list_icon_weibo",@"list_icon_website",@"list_icon_email",@"list_icon_edition"];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
    
    UIImageView * logo = [Factory creatImageViewWithImage:@"about_logo_nfl"];
    UILabel * name = [Factory creatLabelWithText:@"美国职业橄榄球大联盟"
                                       fontValue:font750(32)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    UILabel * enName = [Factory creatLabelWithText:@"NATIONAL FOOTBALL LEAGUE"
                                         fontValue:font750(20)
                                         textColor:Color_MainBlack
                                     textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:logo];
    [self.view addSubview:name];
    [self.view addSubview:enName];
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(89 * 2)));
        make.bottom.equalTo(@(Anno750(-66)));
        make.width.equalTo(@(Anno750(30 * 2)));
        make.height.equalTo(@(Anno750(77)));
    }];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logo.mas_right).offset(Anno750(18));
        make.top.equalTo(logo.mas_top).offset(Anno750(4));
    }];
    [enName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_left);
        make.top.equalTo(name.mas_bottom).offset(Anno750(5));
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"AboutUsCell";
    AboutUsCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AboutUsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithTitle:self.titles[indexPath.row] desc:self.descs[indexPath.row] image:self.images[indexPath.row]];
    return cell;
}
@end
