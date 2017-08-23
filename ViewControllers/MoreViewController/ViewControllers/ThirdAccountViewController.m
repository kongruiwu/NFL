//
//  ThirdAccountViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ThirdAccountViewController.h"
#import "ThirdAccountCell.h"
#import "ThirdInfoModel.h"
@interface ThirdAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) ThirdListModel * listModel;
@end


@implementation ThirdAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:@"第三方帐号绑定"];
    [self creatUI];
    [self userThirdInfoRequest];
}
- (void)creatUI{
    self.titles = @[@"微信",@"QQ",@"微博"];
    self.images = @[@"list_login_icon_wechat",@"list_icon_qq",@"list_login_icon_weibo"];
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain delegate:self];
    [self.view addSubview:self.tabview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"ThirdAccountCell";
    ThirdAccountCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[ThirdAccountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSString * desc = @"未绑定";
    BOOL rec = indexPath.row == 0 && self.listModel.weixin.binded;
    BOOL rec2 = indexPath.row == 1 && self.listModel.qq.binded;
    BOOL rec3 = indexPath.row == 2 && self.listModel.weibo.binded;
    if (rec || rec2 || rec3) {
        desc = @"已绑定";
    }
    [cell updateWithImage:self.images[indexPath.row] title:self.titles[indexPath.row] desc:desc];
    return cell;
}
#pragma mark - 获取用户三方登录列表
- (void)userThirdInfoRequest{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID
                              };
    [[NetWorkManger manager] sendRequest:PageThirdList route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.listModel = [[ThirdListModel alloc]initWithDictionary:dic];
        [self.tabview reloadData];
    } error:^(NFError *byerror) {
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self WeChatLoginRequest];
    }else if(indexPath.row == 1){
        [self QQloginRequest];
    }else if(indexPath.row == 2){
        [self SinaLoginRequest];
    }
}

#pragma mark - 三方登录
- (void)QQloginRequest{
    [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
}
- (void)WeChatLoginRequest{
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}
- (void)SinaLoginRequest{
    [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
}
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        if (error && error.description.length>0) {
            return ;
        }
        NSString * type;
        UMSocialUserInfoResponse * resp = result;
        if (platformType == UMSocialPlatformType_QQ) {
            type = @"qq";
        }else if(platformType == UMSocialPlatformType_WechatSession){
            type = @"weixin";
        }else if(platformType == UMSocialPlatformType_Sina){
            type = @"weibo";
        }
        [SVProgressHUD show];
        NSDictionary * params = @{
                                  @"type":type,
                                  @"uid":[UserManager manager].userID,
                                  @"openid":resp.openid,
                                  @"username":resp.name,
                                  @"avatar":resp.iconurl,
                                  };
        [SVProgressHUD show];
        [[NetWorkManger manager] sendRequest:Page_bind route:Route_User withParams:params complete:^(NSDictionary *result) {
            if ([type isEqualToString:@"qq"]) {
                self.listModel.qq.binded = YES;
            }else if([type isEqualToString:@"weixin"]){
                self.listModel.weixin.binded = YES;
            }else if([type isEqualToString:@"weibo"]){
                self.listModel.weibo.binded = YES;
            }
            [self.tabview reloadData];
        } error:^(NFError *byerror) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
        }];
    }];
}

@end
