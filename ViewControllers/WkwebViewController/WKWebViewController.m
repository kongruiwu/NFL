//
//  WKWebViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
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
            if ([urlStr isEqualToString:DaydayNFL]) {
                self.urlStr = [NSString stringWithFormat:@"%@?uid=%@&callback_verify=%@",self.urlStr,[UserManager manager].userID,[UserManager manager].info.callback_verify_ttnfl];
            }else{
                self.urlStr = [NSString stringWithFormat:@"%@?uid=%@&callback_verify=%@",self.urlStr,[UserManager manager].userID,[UserManager manager].info.callback_verify];
            }
            
        }
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    self.tabBarController.tabBar.hidden = YES;
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
    [self drawShareButton];
}

- (void)creatUI{
    
    self.shareImg = [Factory creatImageViewWithImage:@""];
    [self.shareImg sd_setImageWithURL:[NSURL URLWithString:self.infoModel.pic_thumbnail]];
    
    self.webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 49)];
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
        NSString * title = self.infoModel.title;
        NSString * desc = [NSString stringWithFormat:@"NFL橄榄球：“%@“快来看看吧",self.infoModel.title];
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareObject * shareObj;
        if (platformType == UMSocialPlatformType_Sina) {
            shareObj = [UMShareImageObject shareObjectWithTitle:title descr:desc thumImage:image];
        }else{
            shareObj = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
            UMShareWebpageObject * shareWeb = (UMShareWebpageObject *)shareObj;
            shareWeb.webpageUrl = self.infoModel.share_link;
        }
        if (platformType == UMSocialPlatformType_Sina) {
            messageObject.text = [NSString stringWithFormat:@"%@%@",desc,self.infoModel.share_link];
        }
        messageObject.shareObject = shareObj;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }];
}

@end
