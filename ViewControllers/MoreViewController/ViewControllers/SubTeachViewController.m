//
//  SubTeachViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubTeachViewController.h"
#import "SubNewsListCell.h"
#import "WKWebViewController.h"
#import "SubNewsHeadCell.h"
#import "VideoListModel.h"
#import "InfoListModel.h"
#import "VideoDetailViewController.h"
#import "PageDetailViewController.h"
#import "SubNewsHeadCell.h"

@interface SubTeachViewController ()<UITableViewDelegate, UITableViewDataSource,SubNewsListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation SubTeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    //第一次进入时才显示
    [SVProgressHUD show];
    self.dataArray = [NSMutableArray new];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64- Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? Anno750(420) : Anno750(160);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"SubNewsHeadCell";
        SubNewsHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubNewsHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithObjModel:self.dataArray[indexPath.section]];
        return cell;
    }
    
    static NSString * cellid = @"SubNewsListCell";
    SubNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithObjectModel:self.dataArray[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id  idModel = self.dataArray[indexPath.section];
    if ([idModel isKindOfClass:[VideoListModel class]]) {
        VideoListModel * model = self.dataArray[indexPath.section];
        VideoDetailViewController * vc = [[VideoDetailViewController alloc]init];
        vc.videoID = model.id;
        [self.navigationController pushViewController:vc animated:YES];
    }else if([idModel isKindOfClass:[InfoListModel class]]){
        InfoListModel * model = self.dataArray[indexPath.section];
        if ([model.cont_type isEqualToString:@"news"]) {
            WKWebViewController * vc = [[WKWebViewController alloc]initWithTitle:@"资讯" url:model.app_iframe];
            vc.infoModel = model;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            PageDetailViewController * vc = [[PageDetailViewController alloc]init];
            vc.photoID = model.id;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


- (void)getData{
    NSString * type ;
    switch (self.teachType) {
        case TeachTypeRule:
            type = @"rules";
            break;
        case TeachTypeStars:
            type = @"super_star";
            break;
        case TeachTypeSuperBowl:
            type = @"super_bowl";
            break;
        default:
            break;
    }
    NSDictionary * params = @{
                              @"type":type,
                              @"uid":[UserManager manager].isLogin ? [UserManager manager].userID : @"",
                              };
    [[NetWorkManger manager] sendRequest:PageClass101 route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        NSArray * arr = dic[@"list"];
        for (int i = 0; i<arr.count; i++) {
            NSDictionary * infoDic = arr[i];
            if ([infoDic[@"cont_type"] isEqualToString:@"video"]) {
                VideoListModel * model = [[VideoListModel alloc]initWithDictionary:infoDic];
                [self.dataArray addObject:model];
            }else{
                InfoListModel * model = [[InfoListModel alloc]initWithDictionary:infoDic];
                [self.dataArray addObject:model];
            }
        }
        if (self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self hiddenNullView];
        }
        
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
    }];
}

- (void)collectThisCellItem:(UIButton *)btn{
    [SVProgressHUD show];
    
    UITableViewCell * cell = (UITableViewCell *)[btn superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    id idmodel = self.dataArray[indexpath.section];
    NSString * idNum = @"";
    NSString * type = @"";
    if ([idmodel isKindOfClass:[VideoListModel class]]) {
        VideoListModel * model = idmodel;
        idNum = [NSString stringWithFormat:@"%@",model.id];
        type = model.cont_type;
    }else{
        InfoListModel * model = idmodel;
        idNum = [NSString stringWithFormat:@"%@",model.id];
        type = model.cont_type;
    }
    
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":type,
                              @"id":idNum
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"收藏成功";
        BOOL rec = NO;
        int num = 0;
        if ([idmodel isKindOfClass:[VideoListModel class]]) {
            VideoListModel * model = idmodel;
            rec = model.collected;
            num = model.collect_num.intValue;
        }else{
            InfoListModel * model = idmodel;
            rec = model.collected;
            num = model.collect_num.intValue;
        }
        if (rec) {
            title = @"取消收藏";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        rec = !rec;
        if (rec) {
            num += 1;
        }else{
            num -= 1;
        }
        if ([idmodel isKindOfClass:[VideoListModel class]]) {
            VideoListModel * model = idmodel;
            model.collected = rec;
            model.collect_num = @(num);
        }else{
            InfoListModel * model = idmodel;
            model.collected = rec;
            model.collect_num = @(num);
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
@end
