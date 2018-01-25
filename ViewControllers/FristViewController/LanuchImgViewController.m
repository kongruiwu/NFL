//
//  LanuchImgViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/10/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LanuchImgViewController.h"
#import "ConfigHeader.h"
//#import "LanuchMovieViewController.h"
#import "FristViewController.h"
#import "RootViewController.h"
@interface LanuchImgViewController ()
@property (nonatomic, strong) NSURLSession * session;
@property (nonatomic, strong) NSURLSessionDownloadTask * downloadTask;
@property (nonatomic, strong) NSFileManager * fileManager;
@end

@implementation LanuchImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor blueColor];
    
    [[NetWorkManger manager] sendRequest:StarImg route:Route_Set withParams:@{} complete:^(NSDictionary *result) {
        NSDictionary * data = result[@"data"];
        NSString * pic = data[@"pic"];
        NSString * homePage = data[@"home_page"];
        [[NSUserDefaults standardUserDefaults] setObject:homePage forKey:@"HOMEPAGE"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString * downImg = [[NSUserDefaults standardUserDefaults] objectForKey:@"downImg"];
        if (!downImg && ![downImg isEqualToString:pic]) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage * image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pic]]];
                NSString *path_sandox = NSHomeDirectory();
                NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/star.png"];
                [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
                [[NSUserDefaults standardUserDefaults] setObject:pic forKey:@"downImg"];
                [[NSUserDefaults standardUserDefaults] setObject:imagePath forKey:@"starImg"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            });
        }
    } error:^(NFError *byerror) {

    }];
    UIImage * image;
    NSString * url = [[NSUserDefaults standardUserDefaults] objectForKey:@"starImg"];
    if (url) {
        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/star.png"];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    if (!image) {
        image = [UIImage imageNamed:@"def"];
    }
    UIImageView * imgview = [[UIImageView alloc]initWithImage:image];
    
    UIImageView * backImg = [Factory creatImageViewWithImage:@"sta"];
    backImg.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT);
    [self.view addSubview:backImg];
    [backImg addSubview:imgview];
    [imgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@(Anno750(1174)));
    }];
    
//    LanuchMovieViewController * lanuchVC = [LanuchMovieViewController new];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Frist"]) {
            [[UIApplication sharedApplication].keyWindow setRootViewController:[FristViewController new]];
        }else{
            [[UIApplication sharedApplication].keyWindow setRootViewController:[RootViewController new]];
        }
    });
}


@end
