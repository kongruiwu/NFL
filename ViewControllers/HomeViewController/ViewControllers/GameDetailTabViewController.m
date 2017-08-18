//
//  GameDetailTabViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameDetailTabViewController.h"
#import "GameLiveViewController.h"
#import "GameHeaderView.h"
#import "GameSegmentView.h"
#import "GameDataViewController.h"
#import "GameInfoViewController.h"
#import "GameVideoViewController.h"
#import "GameNewsViewController.h"
#import "GameRatioViewController.h"
#import "LiveViewModel.h"
#define GameHeadHigh    Anno750(480)
#define GameSelectHigh  (64 + Anno750(80))
@interface GameDetailTabViewController ()<GameBassDelegate>

@property (nonatomic, strong) GameHeaderView * headView;
@property (nonatomic, strong) GameSegmentView * segementView;
@property (nonatomic, strong) GameBassViewController * currentVC;

@property (nonatomic, strong) LiveViewModel * viewModel;

@property (nonatomic, strong) NSMutableArray<GameBassViewController *> * viewControllers;

@end

@implementation GameDetailTabViewController

- (instancetype)initWithMatchDetailModel:(MatchDetailModel *)model{
    self = [super init];
    if (self) {
        self.game = model;
    }
    return self;
}
- (instancetype)initWithGameID:(NSNumber *)gameID matchStatus:(MacthStatus)status{
    self = [super init];
    if (self) {
        self.gameID = gameID;
        self.gameStatus = status;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavAlpha];
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavUnAlpha];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self drawBackButton];
//    [self drawShareButton];
    [self setNavTitle:@"比赛详情"];
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    self.viewControllers = [NSMutableArray new];
    NSArray * titles;
    UIView * header = [Factory creatViewWithColor:[UIColor clearColor]];
    header.frame = CGRectMake(0, 0, UI_WIDTH, GameHeadHigh - GameSelectHigh);
    switch ([self.game.match_state integerValue]) {
        case 0: //未开始
        {
            titles = @[@"对阵信息",@"数据对比",@"资讯"];
            GameInfoViewController * info = [[GameInfoViewController alloc]init];
            info.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
            [self.view addSubview:info.view];
            [self addChildViewController:info];
            info.tabview.tableHeaderView = header;
            info.delegate = self;
            [self.viewControllers addObject:info];
            self.currentVC = info;
            
            GameRatioViewController * ratio = [[GameRatioViewController alloc]init];
            ratio.gameID = self.game.gameId;
            ratio.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
            [self addChildViewController:ratio];
            ratio.tabview.tableHeaderView = header;
            ratio.delegate = self;
            [self.viewControllers addObject:ratio];
            
            GameNewsViewController * news = [[GameNewsViewController alloc]init];
            news.gameID =self.game.gameId;
            news.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
            [self addChildViewController:news];
            news.tabview.tableHeaderView = header;
            news.delegate = self;
            [self.viewControllers addObject:news];
            
        }
            break;
        case 1: //正在进行
        case 2: //已结束
        {
            titles = @[[self.game.match_state integerValue] == 1 ? @"直播" :@"战报",@"数据",@"视频"];
            GameLiveViewController * live = [[GameLiveViewController alloc]init];
            live.gameID = self.game.gameId;
            live.isPlaying = [self.game.match_state integerValue] == 1 ? YES : NO;
            live.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT );
            [self addChildViewController:live];
            live.delegate = self;
            live.tabview.tableHeaderView = header;
            [self.view addSubview:live.view];
            self.currentVC = live;
            [self.viewControllers addObject:live];
            
            GameDataViewController * data = [[GameDataViewController alloc]init];
            data.gameID = self.game.gameId;
            data.homeName = self.game.home_name;
            data.visiName = self.game.visitor_name;
            data.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
            [self addChildViewController:data];
            data.tabview.tableHeaderView = header;
            data.delegate = self;
            [self.viewControllers addObject:data];
            
            GameVideoViewController * video = [[GameVideoViewController alloc]init];
            video.gameID = self.game.gameId;
            video.view.frame = CGRectMake(0, GameSelectHigh, UI_WIDTH, UI_HEGIHT);
            [self addChildViewController:video];
            video.tabview.tableHeaderView = header;
            video.delegate = self;
            [self.viewControllers addObject:video];
            
        }
            break;
            
        default:
            break;
    }
    
    self.segementView = [[GameSegmentView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, GameSelectHigh) titles:titles];
    [self.segementView updateWithMatchDetailModel:self.game];
    [self.view addSubview:self.segementView];
    
    self.headView = [[GameHeaderView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, GameHeadHigh) titles:titles];
    [self.headView updateWithMatchDetailModel:self.game];
    [self.view addSubview:self.headView];
    
    __weak GameDetailTabViewController * weakself = self;
    [self.headView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.segementView.segmentView setSelectedSegmentIndex:index];
    }];
    [self.segementView.segmentView setIndexChangeBlock:^(NSInteger index) {
        [weakself changeControllerFromOldController:weakself.currentVC toNewController:weakself.viewControllers[index]];
        [weakself.headView.segmentView setSelectedSegmentIndex:index];
    }];
}
#pragma mark - 切换viewController
- (void)changeControllerFromOldController:(UIViewController *)oldController toNewController:(UIViewController *)newController
{
    [self addChildViewController:newController];
    /**
     *  切换ViewController
     */
    [self transitionFromViewController:oldController toViewController:newController duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        //做一些动画
    } completion:^(BOOL finished) {
        
        if (finished) {
            //移除oldController，但在removeFromParentViewController：方法前不会调用willMoveToParentViewController:nil 方法，所以需要显示调用
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = (GameBassViewController *)newController;
            [self.view bringSubviewToFront:self.headView];
            [self updateScrollerViewContentOffset];
            
        }else
        {
            self.currentVC = (GameBassViewController *)oldController;
        }
        
    }];
}
- (void)updateScrollerViewContentOffset{
    if (self.headView.hidden) {
        self.currentVC.tabview.contentOffset = CGPointMake(0, GameHeadHigh - GameSelectHigh);
    }else{
        self.currentVC.tabview.contentOffset = CGPointMake(0, 0);
    }
}

- (void)hiddenOutHeadView:(CGFloat)y{
    if (y > GameHeadHigh + Anno750(200)) {
        return;
    }else if(y< 0){
        self.headView.frame = CGRectMake(0, 0, UI_WIDTH, GameHeadHigh);
    }else{
        self.headView.frame = CGRectMake(0, -y, UI_WIDTH, GameHeadHigh);
    }
    self.headView.groundImg.alpha = 1 - y/(GameHeadHigh - GameSelectHigh);
    if (y >= Anno750(270)) {
        self.headView.hidden = YES;
    }else{
        self.headView.hidden = NO;
    }
    
    //动画
    if (y>0) {
        float uas = y/(GameHeadHigh - GameSelectHigh);
        float leftImgx = Anno750(60) + uas*(Anno750(85 * 2) - Anno750(60));
        float imagY = Anno750(160) - (Anno750(160) - 20 - Anno750(4)) * uas;
        float w = Anno750(120) - uas * (Anno750(40));
        float rightImgx = (UI_WIDTH - Anno750(180)) + uas *(Anno750(100) - Anno750(85 *2));
        float leftScoreX = Anno750(240) + uas * (Anno750(85 * 2) - Anno750(120));
        float scoreY = Anno750(210) - (Anno750(210) - 20 - Anno750(12)) * uas;
        float rightScoreX = UI_WIDTH - Anno750(300) - uas * (Anno750(85 * 2 - 120));
        
        self.headView.leftName.alpha = 1 - uas;
        self.headView.videoButton.alpha = 1 - uas;
        self.headView.rightName.alpha = 1 - uas;
        self.headView.vsLabel.alpha = 1 - uas;
        self.headView.timeLabel.alpha = 1 - uas;
        self.headView.gameStatus.alpha = 1 - uas;
        self.navigationItem.titleView.alpha = 1- uas;
        self.headView.leftImg.frame = CGRectMake(leftImgx, imagY + y, w, w);
        self.headView.rightImg.frame = CGRectMake(rightImgx, imagY+ y, w, w);
        self.headView.leftScore.frame = CGRectMake(leftScoreX, scoreY + y, Anno750(60), Anno750(60));
        self.headView.rightScore.frame = CGRectMake(rightScoreX, scoreY + y, Anno750(60), Anno750(60));
    }
    
}
- (void)getData{
    
    
    
    NSDictionary * params = @{
                              @"gameId":self.game.gameId,
                              };
    [[NetWorkManger manager] sendRequest:PageGameDetail route:Route_Match withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        self.viewModel = [[LiveViewModel alloc]initWithDictionary:dic];
        
        
        
        if ([self.currentVC isKindOfClass:[GameLiveViewController class]]) {
            GameLiveViewController * live = (GameLiveViewController *)self.currentVC;
            live.isPlaying = [self.viewModel.match_state intValue] == 1 ? YES : NO;
            if (!live.isPlaying) {
                [live updateWithTeamFightInfo:self.viewModel.play_by_play];
            }
        }else if([self.currentVC isKindOfClass:[GameInfoViewController class]]){
            GameInfoViewController * info = (GameInfoViewController *)self.currentVC;
            info.viewModel = self.viewModel;
        }
    } error:^(NFError *byerror) {
        
    }];
}
/**
 *  当gamestatus == 0 时 检测 状态是否变为 1  变为 则提示用户
 *  用户提示  如果用户确定 则更改当前所有信息为 进行中 状态， 进入直播界面
 *  用户取消  原界面不做任何变化
 *  当gamestatus == 1 时 变成状态 2 则只做状态值更新
 */
- (void)checkMatchStatusChange{
    switch (self.gameStatus) {
        case MacthStatusReady:
            //比赛状态发生改变
            if ([self.viewModel.match_state integerValue] == MacthStatusPlaying) {
                
            }
            break;
        case MacthStatusPlaying:
            
            break;
        case MacthStatusOver:
            
            break;
        default:
            break;
    }
}
- (void)showMessageToChangeStaus{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"比赛提示" message:@"比赛已经开始啦！是否进入直播界面？" preferredStyle:UIAlertControllerStyleAlert];
    
}

//- (void)doShare{
//    if (!self.viewModel) {
//        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"数据正在获取中，请稍后" duration:1.0f];
//        return;
//    }
//    
//    //显示分享面板
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        //图片
//        
//        UIImage * image = self.shareImg.image;
//        NSString * title = self.infoModel.title;
//        NSString * desc = [NSString stringWithFormat:@"NFL橄榄球：“%@“快来看看吧",self.infoModel.title];
//        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//        UMShareObject * shareObj;
//        if (platformType == UMSocialPlatformType_Sina) {
//            shareObj = [UMShareImageObject shareObjectWithTitle:title descr:desc thumImage:image];
//        }else{
//            shareObj = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
//            UMShareWebpageObject * shareWeb = (UMShareWebpageObject *)shareObj;
//            shareWeb.webpageUrl = self.infoModel.share_link;
//        }
//        if (platformType == UMSocialPlatformType_Sina) {
//            messageObject.text = [NSString stringWithFormat:@"%@%@",desc,self.infoModel.share_link];
//        }
//        messageObject.shareObject = shareObj;
//        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//            NSLog(@"%@",error);
//        }];
//        
//    }];
//}

@end
