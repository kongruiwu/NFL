//
//  WKWebViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "LoginViewController.h"
#import "TeachViewController.h"

#import "HomeViewController.h"

@interface WKWebViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView * webview;
@property (nonatomic, strong) NSString * urlStr;
@property (nonatomic, strong) UIProgressView * progressView;
@property (nonatomic, strong) NSString * titleStr;
@property (nonatomic, strong) UIImageView * shareImg;

@end

@implementation WKWebViewController

- (instancetype)initWithTitle:(NSString *)title url:(NSString *)urlStr{
    self = [super init];
    if (self) {
        self.titleStr = title.length > 0 ? title : @"资讯";
        self.urlStr = urlStr;
        if ([UserManager manager].isLogin) {
            if ([self.titleStr isEqualToString:@"天天NFL"] || [self.titleStr isEqualToString:@"101课堂"] ||[self.titleStr isEqualToString:@"视频直播"]) {
                self.urlStr = urlStr;
            }else{
                self.urlStr = [NSString stringWithFormat:@"%@&uid=%@&callback_verify=%@",self.urlStr,[UserManager manager].userID,[UserManager manager].info.callback_verify];
            }
            
        }
    }
    return self;
}

- (instancetype)initWithNewsId:(NSNumber *)newsID{
    self = [super init];
    if (self) {
        self.titleStr = @"资讯";
        NSString * url = [NSString stringWithFormat:@"http://m.nflchina.com/news/detail/%@.html?app_iframe",newsID];
        if ([UserManager manager].isLogin) {
            self.urlStr = url;
        }else{
            self.urlStr = [NSString stringWithFormat:@"%@&uid=%@&callback_verify=%@",url,[UserManager manager].userID,[UserManager manager].info.callback_verify];
        }
        [self requestNewsDetail:newsID];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    self.tabBarController.tabBar.hidden = YES;
    if ([self.titleStr isEqualToString:@"101课堂"]) {
        [MobClick event:@"101H5"];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawBackButton];
    [self setNavTitle:self.titleStr];
    [self creatUI];
    if (![self.titleStr isEqualToString:@"用户使用协议"] && ![self.titleStr isEqualToString:@"视频直播"]) {
        [self drawShareButton];
    }
    
}

- (void)creatUI{
    
    self.shareImg = [Factory creatImageViewWithImage:@""];
    if (self.infoModel) {
        [self.shareImg sd_setImageWithURL:[NSURL URLWithString:self.infoModel.pic_thumbnail]];
    }
    
    
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64)];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    self.webview.navigationDelegate = self;
    [self.view addSubview:self.webview];
    
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(30))];
    self.progressView.trackTintColor = Color_Line;
    self.progressView.progressTintColor = Color_MainBlue;
    [self.view addSubview:self.progressView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webview) {
            [self.progressView setAlpha:1.0f];
            [self.progressView setProgress:self.webview.estimatedProgress animated:YES];
            if(self.webview.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self.progressView setAlpha:0.0f];
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        }else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)doShare{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //图片
        UIImage * image = self.shareImg.image;
        if (!image) {
            image = [UIImage imageNamed:@"180"];
        }
        NSString * title;
        NSString * desc;
        NSString * url ;
        if (self.infoModel) {
            title = self.infoModel.title;
            desc = [NSString stringWithFormat:@"NFL橄榄球：“%@“快来看看吧",self.infoModel.title];
            url = self.infoModel.share_link;
        }else{
            title = self.titleStr;
            desc = @"更多精彩内容来自[NFL橄榄球]APP";
            url = self.urlStr;
        }
        UMSocialMessageObject * messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject * shareObj;
        shareObj = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
        shareObj.webpageUrl = url;
        messageObject.shareObject = shareObj;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }];
}

// 在发送请求之前，决定是否跳转
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString * urlStr = [NSString stringWithFormat:@"%@",navigationAction.request.URL];
    if ([urlStr containsString:@"nflchina:"]) {
        if ([self.titleStr containsString:@"101"]) {
            TeachViewController * teachVC = [TeachViewController new];
            if ([urlStr containsString:@"type=rules"]) {
                teachVC.index = 0;
                [self.navigationController pushViewController:teachVC animated:YES];
            }else if([urlStr containsString:@"type=super_star"]){
                teachVC.index = 1;
                [self.navigationController pushViewController:teachVC animated:YES];
            }else if([urlStr containsString:@"schedules"]){
                
                if ([self.navigationController.viewControllers.firstObject isKindOfClass:[HomeViewController class]]) {
                    [self.navigationController popToRootViewControllerAnimated:NO];
                }else{
                    self.tabBarController.selectedIndex = 0;
                }
            }
            
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)collectThisNews{
    if (![UserManager manager].isLogin) {
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"您还没有登录，请先登录" duration:1.0f];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"uid":[UserManager manager].userID,
                              @"type":self.infoModel.cont_type,
                              @"id":self.infoModel.id
                              };
    [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
        NSString * title = @"收藏成功";
        if (self.infoModel.collected) {
            title = @"取消收藏";
        }
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title duration:1.0f];
    } error:^(NFError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}

- (void)doBack{
    if (self.webview.canGoBack) {
        [self.webview goBack];
    }else{
        [super doBack];
    }
}
- (void)requestNewsDetail:(NSNumber *)newsID{
    NSDictionary * params = @{
                              @"id":newsID
                              };
    [[NetWorkManger manager] sendRequest:PageNewsDetail route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.infoModel = [[InfoListModel alloc]initWithDictionary:dic];
        [self.shareImg sd_setImageWithURL:[NSURL URLWithString:self.infoModel.pic_thumbnail]];
    } error:^(NFError *byerror) {
        
    }];
}

@end
