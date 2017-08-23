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
#import "OnlineAnswerModel.h"
@interface OnlineQuestionViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) TalkeInputView * talkView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation OnlineQuestionViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotify:) name:UIKeyboardWillChangeFrameNotification object:nil];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(getAnswer) userInfo:nil repeats:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"在线问答"];
    [self drawBackButton];
    [self creatUI];
    [self scrollToEnd];
    [self getData];
}
- (void)creatUI{
    
    self.dataArray = [NSMutableArray new];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT -Anno750(98) - 64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    self.tabview.mj_header = self.refreshHeader;
    
    
    UIView * header = [Factory creatViewWithColor:[UIColor clearColor]];
    header.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(20));
    self.tabview.tableHeaderView = header;
    
    self.talkView = [[TalkeInputView alloc]initWithFrame:CGRectMake(0, UI_HEGIHT - Anno750(98) - 64 , UI_WIDTH, Anno750(98))];
    [self.talkView.sendBtn addTarget:self action:@selector(SendMessage) forControlEvents:UIControlEventTouchUpInside];
    self.talkView.textField.delegate = self;
    [self.view addSubview:self.talkView];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewCotrollerTouch)];
    [self.tabview addGestureRecognizer:tap];
}
- (void)viewCotrollerTouch{
    [self.view endEditing:YES];
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
        self.tabview.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT + transformY - Anno750(98) - 64 - 64);
        self.talkView.transform = CGAffineTransformMakeTranslation(0, transformY - 64);
        [self scrollToEnd];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = self.dataArray[section];
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * arr = self.dataArray[indexPath.section];
    OnlineAnswerModel * model = arr[indexPath.row];
    CGSize size = [Factory getSize:model.content maxSize:CGSizeMake(Anno750(750 - 270), 99999) font:[UIFont systemFontOfSize:font750(28)]];
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
    NSArray * arr = self.dataArray[section];
    OnlineAnswerModel * model = arr.firstObject;
    NSString * timestr = [Factory timestampSwitchWithHourStyleTime:model.time.integerValue];
    UILabel * time = [Factory creatLabelWithText:timestr
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
    NSArray * arr = self.dataArray[indexPath.section];
    OnlineAnswerModel * model = arr[indexPath.row];
    if (!model.is_admin) {
        static NSString * cellid = @"RightTalkCell";
        RightTalkCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[RightTalkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithOnlineAnswerModel:model];
        return cell;
    }
    static NSString * cellid = @"leftCell";
    LeftTalkCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[LeftTalkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithOnlineAnswerModel:model];
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
    [self.view endEditing:YES];
    [self sendMessageRequest];
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

- (void)getData{
    NSString * num = @"";
    if (self.dataArray.count>0) {
        NSArray * arr = self.dataArray.firstObject;
        if (arr.count>0) {
            OnlineAnswerModel * model = arr.firstObject;
            num = [NSString stringWithFormat:@"%@",model.id];
        }
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"oldest_id":num,
                              };
    [[NetWorkManger manager] sendRequest:PageOnlineList route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        NSMutableArray * datas = [NSMutableArray new];
        for (int i = 0; i<arr.count/5; i++) {
            NSMutableArray * muarr = [NSMutableArray new];
            for (int j = 0; j<5; j++) {
                OnlineAnswerModel * model = [[OnlineAnswerModel alloc] initWithDictionary:arr[i * 5 + j]];
                [muarr addObject:model];
            }
            
            [datas addObject:muarr];
        }
        NSMutableArray * muarry = [NSMutableArray new];
        for (int i = (int)arr.count/5 * 5; i<arr.count; i++) {
            OnlineAnswerModel * model = [[OnlineAnswerModel alloc]initWithDictionary:arr[i]];
            [muarry addObject:model];
        }
        if (muarry.count >0) {
            [datas addObject:muarry];
        }
        [datas addObjectsFromArray:self.dataArray];
        self.dataArray = [NSMutableArray arrayWithArray:datas];
        [self.tabview reloadData];
        if (num.length == 0) {
            [self scrollToEnd];
        }
        [self.refreshHeader endRefreshing];
    } error:^(NFError *byerror) {
        [self.refreshHeader endRefreshing];
    }];
}


- (void)sendMessageRequest{
    if (self.talkView.textField.text.length == 0) {
        return;
    }
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"content":self.talkView.textField.text,
                              };
    [[NetWorkManger manager] sendRequest:PageSubmitQuest route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSNumber * idNum = dic[@"id"];
        OnlineAnswerModel * model  =[[OnlineAnswerModel alloc]init];
        model.content = self.talkView.textField.text;
        model.uid = [UserManager manager].userID;
        model.username = [UserManager manager].info.username;
        model.avatar = [UserManager manager].info.avatar;
        model.is_admin = NO;
        NSNumber * num = @(time(NULL));
        model.time = num;
        model.id = idNum;
        
        NSMutableArray * muarr = self.dataArray.lastObject;
        if (muarr.count == 5) {
            NSMutableArray * newMuarr = [NSMutableArray new];
            [newMuarr addObject:model];
            [self.dataArray addObject:newMuarr];
        }else{
            [muarr addObject:model];
        }
        self.talkView.textField.text = @"";
        [self.tabview reloadData];
        [self scrollToEnd];
    } error:^(NFError *byerror) {
        
    }];
}

- (void)getAnswer{
    NSString * idnum = @"";
    if (self.dataArray.count >0) {
        NSMutableArray * arr = self.dataArray.lastObject;
        if (arr.count>0) {
            OnlineAnswerModel * model = arr.lastObject;
            idnum = [NSString stringWithFormat:@"%@",model.id];
        }
    }
    if (idnum.length == 0) {
        return;
    }
    
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"last_id":idnum
                              };
    [[NetWorkManger manager] sendRequest:PageAnswer route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        NSMutableArray * datas = [NSMutableArray new];
        for (int i = 0; i<arr.count/5; i++) {
            NSMutableArray * muarr = [NSMutableArray new];
            for (int j = 0; j<5; j++) {
                OnlineAnswerModel * model = [[OnlineAnswerModel alloc] initWithDictionary:arr[i * 5 + j]];
                [muarr addObject:model];
            }
            
            [datas addObject:muarr];
        }
        NSMutableArray * muarry = [NSMutableArray new];
        for (int i = (int)arr.count/5 * 5; i<arr.count; i++) {
            OnlineAnswerModel * model = [[OnlineAnswerModel alloc]initWithDictionary:arr[i]];
            [muarry addObject:model];
        }
        if (muarry.count >0) {
            [datas addObject:muarry];
        }
        [self.dataArray addObjectsFromArray:datas];
        [self.tabview reloadData];
        [self scrollToEnd];
    } error:^(NFError *byerror) {
        
    }];
}

@end
