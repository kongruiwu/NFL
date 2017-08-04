//
//  OnlineQuestionViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "OnlineQuestionViewController.h"
#import "LeftTalkCell.h"
#import "RightTalkCell.h"
#import "TalkeInputView.h"
#import <IQKeyboardManager.h>
@interface OnlineQuestionViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView * tabview;

@property (nonatomic, strong) NSMutableArray * titles;

@property (nonatomic, strong) TalkeInputView * talkView;

@end

@implementation OnlineQuestionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotify:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"在线问答"];
    [self drawBackButton];
    [self creatUI];
}
- (void)creatUI{
    
    self.titles = [NSMutableArray arrayWithObjects:@"#方式一：需要在包含 name.xcodeproj 的目录下执行 xcodebuild命令，且如果该目录下有多个 projects，那么需要使用 -project 指定需要 build 的项目。xcodebuild -project $appName.xcodeproj -scheme ${targetName} -configuration $conf -derivedDataPath build -sdk iphoneos ${Profile_UUID} ${args} ",@"#方式一：需要在包含 name.xcodeproj 的目录下执行 xcodebuild命令，且如果该目录下有多个 projects，那么需要使用 -project 指定需要 build 的项目。xcodebuild -project",@" $conf -derivedDataPath build -sdk iphoneos ${Profile_UUID} ${args} || exit", nil];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Anno750(30) - Anno750(98)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    UIView * header = [Factory creatViewWithColor:[UIColor clearColor]];
    header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
    self.tabview.tableHeaderView = header;
    
    self.talkView = [[TalkeInputView alloc]initWithFrame:CGRectMake(0, UI_HEGIHT - Anno750(98) - 64 , UI_WIDTH, Anno750(98))];
    [self.talkView.sendBtn addTarget:self action:@selector(SendMessage) forControlEvents:UIControlEventTouchUpInside];
    self.talkView.textField.delegate = self;
    [self.view addSubview:self.talkView];
    
}
-(void)keyboardWillChangeFrameNotify:(NSNotification*)notify {
    
    // 0.取出键盘动画的时间
    CGFloat duration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 1.取得键盘最后的frame
    CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 2.计算控制器的view需要平移的距离
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    // 3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.tabview.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT + transformY - Anno750(98) - 64 - Anno750(30));
        self.talkView.transform = CGAffineTransformMakeTranslation(0, transformY - 64);
        [self scrollTableViewToBottom];
        
    }];
}
/**
 *  tableView快速滚动到底部
 */
- (void)scrollTableViewToBottom {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.titles.count - 1) inSection:0];
    [self.tabview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [Factory getSize:self.titles[indexPath.row] maxSize:CGSizeMake(Anno750(750 - 270), 99999) font:[UIFont systemFontOfSize:font750(28)]];
    return size.height >= Anno750(42) ? size.height + Anno750(50) : Anno750(92) ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(64);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * header = [Factory creatViewWithColor:[UIColor clearColor]];
    header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(64));
    UILabel * time = [Factory creatLabelWithText:@"10:26"
                                       fontValue:font750(20)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    time.backgroundColor = UIColorFromRGBA(0x000000, 0.1);
    CGSize size = [Factory getSize:time.text maxSize:CGSizeMake(UI_WIDTH, 99999) font:[UIFont systemFontOfSize:font750(20)]];
    time.layer.cornerRadius = Anno750(20);
    time.layer.masksToBounds = YES;
    [header addSubview:time];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@(Anno750(-10)));
        make.width.equalTo(@(size.width + Anno750(30)));
        make.height.equalTo(@(Anno750(40)));
    }];
    
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 ==1) {
        static NSString * cellid = @"RightTalkCell";
        RightTalkCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[RightTalkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithText:self.titles[indexPath.row]];
        return cell;
    }
    static NSString * cellid = @"leftCell";
    LeftTalkCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[LeftTalkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithText:self.titles[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self SendMessage];
    return YES;
}
- (void)SendMessage{
    [self.titles addObject:self.talkView.textField.text];
    self.talkView.textField.text = @"";
    [self.tabview reloadData];
    [self.view endEditing:YES];
}
@end
