//
//  VideoDetailViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "SubNewsListCell.h"
#import "VideoHeadCell.h"
#import "VideoDetailModel.h"
#import "VideoPlayViewController.h"
#import "LoginViewController.h"
@interface VideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource,SubNewsListCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) VideoDetailModel * videoModel;

@end

@implementation VideoDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"视频详情"];
    [self drawBackButton];
    [self drawShareButton];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - Nav64) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.videoModel.recommend_list.count+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = [Factory getSize:self.videoModel.content maxSize:CGSizeMake(UI_WIDTH - Anno750(48), 99999) font:[UIFont systemFontOfSize:font750(26)]];
    
    return indexPath.section == 0 ? Anno750(570) + size.height : Anno750(160);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 1 ? Anno750(60) : 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 0.01 : Anno750(20);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel * label = [Factory creatLabelWithText:@"推荐视频"
                                            fontValue:font750(24)
                                            textColor:Color_DarkGray
                                        textAlignment:NSTextAlignmentCenter];
        label.backgroundColor = Color_BackGround;
        label.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(60));
        return label;
    }else{
        return nil;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"VideoHeadCell";
        VideoHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[VideoHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell.likeBtn addTarget:self action:@selector(collectThisVideo) forControlEvents:UIControlEventTouchUpInside];
        [cell updateWithDetailModel:self.videoModel];
        return cell;
    }else{
        static NSString * cellid = @"SubNewsListCell";
        SubNewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[SubNewsListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        cell.delegate = self;
        [cell updateWithObjectModel:self.videoModel.recommend_list[indexPath.section - 1]];
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        VideoPlayViewController * vc = [[VideoPlayViewController alloc]initWithUrl:[NSURL URLWithString:self.videoModel.src]];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        VideoDetailViewController * vc = [[VideoDetailViewController alloc]init];
        vc.videoID = self.videoModel.recommend_list[indexPath.section - 1].id;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showNetChangeMessage{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您现在使用的是运营商网络\n继续观看可能产生超额流量费用" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * play = [UIAlertAction actionWithTitle:@"继续播放" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * cannce = [UIAlertAction actionWithTitle:@"取消播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:play];
    [alert addAction:cannce];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"id":self.videoID
                              };
    [[NetWorkManger manager] sendRequest:Video_Detail route:Route_Viedeo withParams:params complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * dic = result[@"data"];
        self.videoModel = [[VideoDetailModel alloc]initWithDictionary:dic];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
    }];
}

- (void)collectThisCellItem:(UIButton *)btn{
    
    if (![UserManager manager].isLogin) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"您还没有登录，请先登录" duration:1.0f];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    UITableViewCell * cell = (UITableViewCell *)[btn superview];
    NSIndexPath * indexpath = [self.tabview indexPathForCell:cell];
    VideoListModel * model = self.videoModel.recommend_list[indexpath.section - 1];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":model.cont_type,
                              @"id":model.id
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"收藏成功";
        if (model.collected) {
            title = @"取消收藏";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        model.collected = !model.collected;
        if (model.collected) {
            model.collect_num = @(model.collect_num.intValue + 1);
        }else{
            model.collect_num = @(model.collect_num.intValue - 1);
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

- (void)collectThisVideo{
    if (![UserManager manager].isLogin) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"您还没有登录，请先登录" duration:1.0f];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":self.videoModel.recommend_list.firstObject.cont_type,
                              @"id":self.videoModel.id
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"收藏成功";
        if (self.videoModel.collected) {
            title = @"取消收藏";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
        self.videoModel.collected = !self.videoModel.collected;
        if (self.videoModel.collected) {
            self.videoModel.collect_num = @(self.videoModel.collect_num.intValue + 1);
        }else{
            self.videoModel.collect_num = @(self.videoModel.collect_num.intValue - 1);
        }
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

- (void)doShare{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //图片
        VideoHeadCell * cell = (VideoHeadCell *)[self.tabview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        UIImage * image = cell.topImg.image;
        NSString * title = self.videoModel.title;
        NSString * desc = self.videoModel.content;
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject * shareObj;
        shareObj = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
        shareObj.webpageUrl = self.videoModel.share_link;
        messageObject.shareObject = shareObj;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }];
}

@end
