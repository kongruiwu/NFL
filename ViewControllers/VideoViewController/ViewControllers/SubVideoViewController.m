//
//  SubVideoViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SubVideoViewController.h"
#import "VideoPlayCell.h"
#import "VideoDetailViewController.h"
#import "VideoListModel.h"
#import "VideoPlayViewController.h"
#import "PlayerView.h"
#import "LoginViewController.h"
typedef NS_ENUM(NSUInteger, ScrollDerection) {
    ScrollDerectionNone = 0,
    ScrollDerectionUp = 1, // 向上滚动
    ScrollDerectionDown = 2 // 向下滚动
};

@interface SubVideoViewController ()<UITableViewDelegate,UITableViewDataSource,VideoPlayCellDelegate>

@property (nonatomic, strong) NSMutableArray<VideoListModel *> * dataArray;
@property (nonatomic, strong) UITableView * tabview;
/**判断滚动方向用的*/
@property (nonatomic) CGFloat offestY_last;
/**滚动方向*/
@property (nonatomic) ScrollDerection derection;
/**正在播放的cell*/
@property (nonatomic, strong) VideoPlayCell * playingCell;

@property (nonatomic, strong) PlayerView * playerView;

@end

@implementation SubVideoViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 用来防止选中 cell push 到下个控制器时, tableView 再次调用 scrollViewDidScroll 方法, 造成 playingCell 被置空.
//    if (!self.tabview.delegate) {
//        self.tabview.delegate = self;
//    }
//    if (!self.playingCell) {
        // 在可见cell中找第一个有视频的进行播放.
//        [self playVideoInVisiableCells];
//    }
//    else{
        //播放视频
//        NSURL *url = [NSURL URLWithString:self.tableView.playingCell.videoPath];
//        [self.tableView.playingCell.videoImv jp_playVideoMutedDisplayStatusViewWithURL:url];
//        [self.playerView playVideoWithUrl:self.playingCell.videoPath];
//        [self.playingCell addSubview:self.playerView];
//        NSLog(@"视频开始播放");
//    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 用来防止选中 cell push 到下个控制器时, tableView 再次调用 scrollViewDidScroll 方法, 造成 playingCell 被置空.
//    self.tabview.delegate = nil;
//    
//    if (self.playingCell) {
//        [self.playerView removeFromSuperview];
//            //停止播放
//        NSLog(@"视频停止播放");
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self getData];
}
- (void)creatUI{
    
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.tabview = [Factory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64- Anno750(80)) style:UITableViewStyleGrouped delegate:self];
    [self.view addSubview:self.tabview];
    
    self.refreshHeader = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;
    
    self.playerView = [PlayerView playView];
}
- (void)refreshData{
    [self.dataArray removeAllObjects];
    [self getData];
}
- (void)loadMoreData{
    [self getData];
}
- (void)getData{
    [SVProgressHUD show];
    NSString * action;
    switch (self.videoType) {
        case VideoTypeBallStar:
            action = @"star";
            break;
        case VideoTypeMatch:
            action = @"match";
            break;
        case VideoTypeTidbits:
            action = @"tidbits";
            break;
        case VideoTypeTeach:
            action = @"teach";
            break;
        case VideoTypeInFollow:
            action = @"follow_list";
            break;
        default:
            break;
    }
    
    NSDictionary * params =@{
                             @"last_id":self.dataArray.count == 0 ? @"" : self.dataArray.lastObject.id,
                             @"type":action,
                             };
    [[NetWorkManger manager] sendRequest:Video_List route:Route_Viedeo withParams:params complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * dic = result[@"data"];
        NSArray * list = dic[@"list"];
        for (int i = 0; i<list.count; i++) {
            VideoListModel * model = [[VideoListModel alloc]initWithDictionary:list[i]];
            [self.dataArray addObject:model];
        }
        if (list.count == 0 && self.dataArray.count == 0) {
            [self showNullViewByType:NullTypeNoneData];
        }else{
            [self.tabview reloadData];
        }
        [self.refreshHeader endRefreshing];
        if (list.count < 10) {
            [self.refreshFooter endRefreshingWithNoMoreData];
        }else{
            [self.refreshFooter endRefreshing];
        }
        //当前界面player不存在时 即第一次进入时 要创建播放器 播放第一条视频
//        if (!self.playerView.player) {
//            [self playVideoInVisiableCells];
//        }
//        
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return VideoPlayCellHeigh;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(20);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"VideoPlayCell";
    VideoPlayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[VideoPlayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.delegate = self;
    [cell updateWithVideoListModel:self.dataArray[indexPath.section]];
    
//    if (self.maxNumCannotPlayVideoCells > 0) {
//        if (indexPath.row <= self.maxNumCannotPlayVideoCells-1) { // 上不可及
//            cell.cellStyle = PlayUnreachCellStyleUp;
//        }
//        else if (indexPath.row >= self.dataArray.count-self.maxNumCannotPlayVideoCells){ // 下不可及
//            cell.cellStyle = PlayUnreachCellStyleDown;
//        }
//        else{
//            cell.cellStyle = PlayUnreachCellStyleNone;
//        }
//    }
//    else{
//        cell.cellStyle = PlayUnreachCellStyleNone;
//    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoDetailViewController * vc = [VideoDetailViewController new];
    vc.videoID = self.dataArray[indexPath.section].id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 滑动cell的选取
/**
 * 松手时已经静止, 只会调用scrollViewDidEndDragging
 */
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (decelerate == NO){
//        [self handleScrollStop];
//    }
//}

/**
 * 松手时还在运动, 先调用scrollViewDidEndDragging, 再调用scrollViewDidEndDecelerating
 */
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    // scrollView 已经完全静止
//    [self handleScrollStop];
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // 处理滚动方向
//    [self handleScrollDerectionWithOffset:scrollView.contentOffset.y];
//    // 处理循环利用
//    [self handleQuickScroll];
//}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    self.offestY_last = scrollView.contentOffset.y;
//}
//
//- (void)handleScrollDerectionWithOffset:(CGFloat)offsetY{
//    self.derection = (offsetY-self.offestY_last>0) ? ScrollDerectionUp :ScrollDerectionDown;
//    self.offestY_last = offsetY;
//}
#pragma mark - 处理滑动时的playingcell的操作
//- (void)handleQuickScroll{
//    if (!self.playingCell) return;
//    // 当前播放视频的cell移出视线，要移除播放器.
//    if (![self playingCellIsVisiable]) {
//        [self stopPlay];
//    }
//}

//当滑动停止时的处理
//- (void)handleScrollStop{
//    VideoPlayCell * bestCell = [self findTheBestToPlayVideoCell];
    // 注意, 如果正在播放的 cell 和 finnalCell 是同一个 cell, 不应该在播放.
//    if (self.playingCell.hash != bestCell.hash && bestCell.hash != 0) {
//        NSLog(@"视频开始播放");
//        [self.playingCell.videoImv jp_stopPlay];
//        
//        NSURL *url = [NSURL URLWithString:bestCell.videoPath];
//        
//        [bestCell.videoImv jp_playVideoWithURL:url];
        
//        self.playingCell = bestCell;
//        [self.playerView playVideoWithUrl:self.playingCell.videoPath];
//        [self.playingCell addSubview:self.playerView];
//    }
//    
//    
//}

#pragma mark - 停止播放
//- (void)stopPlay{
//    NSLog(@"视频停止播放");
//    [self.playerView removeFromSuperview];
////    [self.playingCell.videoImv jp_stopPlay];
//    self.playingCell = nil;
//}

#pragma mark - 当前播放cell是否可见
//- (BOOL)playingCellIsVisiable{
//    CGRect windowRect = [UIScreen mainScreen].bounds;
//    windowRect.origin.y = 64;
//    windowRect.size.height -= 64;
//    if (self.derection == ScrollDerectionUp) { // 向上滚动
//        CGPoint cellLeftUpPoint = self.playingCell.frame.origin;
//        CGFloat cellDownY = cellLeftUpPoint.y + self.playingCell.bounds.size.height;
//        CGPoint cellLeftDownPoint = CGPointMake(cellLeftUpPoint.x, cellDownY);
//        // 不要在边界上.
//        cellLeftUpPoint.y -= 1;
//        CGPoint coorPoint = [self.playingCell.superview convertPoint:cellLeftDownPoint toView:nil];
//        BOOL isContain = CGRectContainsPoint(windowRect, coorPoint);
//        return isContain;
//    }
//    else if(self.derection == ScrollDerectionDown){ // 向下滚动
//        CGPoint cellLeftUpPoint = self.playingCell.frame.origin;
//        
//        // 不要在边界上.
//        cellLeftUpPoint.y += 1;
//        CGPoint coorPoint = [self.playingCell.superview convertPoint:cellLeftUpPoint toView:nil];
//        
//        BOOL isContain = CGRectContainsPoint(windowRect, coorPoint);
//        return isContain;
//    }
//    return YES;
//}


#pragma mark - 查找最佳播放的cell
//- (VideoPlayCell *)findTheBestToPlayVideoCell{
//    VideoPlayCell * finnalCell = nil;
//    NSArray * visiableCells = [self.tabview visibleCells];
//    CGFloat gap = MAXFLOAT;
//    CGRect windowRect = [UIScreen mainScreen].bounds;
//    windowRect.origin.y = 64;
//    windowRect.size.height -= 64 + 49;
//    
//    for (VideoPlayCell *cell in visiableCells) {
//        
//        @autoreleasepool {
//            if (cell.videoPath.length > 0) {
//            // 优先查找滑动不可及cell.
//                if (cell.cellStyle != PlayUnreachCellStyleNone) {
//                    // 并且不可及cell要全部露出.
//                    if (cell.cellStyle == PlayUnreachCellStyleUp) {
//                        CGPoint cellLeftUpPoint = cell.frame.origin;
//                        //不要在边界上.
//                        cellLeftUpPoint.y += 2;
//                        CGPoint coorPoint = [cell.superview convertPoint:cellLeftUpPoint toView:nil];
//                        BOOL isContain = CGRectContainsPoint(windowRect, coorPoint);
//                        if (isContain){
//                            finnalCell = cell;
//                            break;
//                        }
//                    }
//                    else if (cell.cellStyle == PlayUnreachCellStyleDown){
//                        CGPoint cellLeftUpPoint = cell.frame.origin;
//                        CGFloat cellDownY = cellLeftUpPoint.y + cell.bounds.size.height;
//                        CGPoint cellLeftDownPoint = CGPointMake(cellLeftUpPoint.x, cellDownY);
//                        // 不要在边界上.
//                        cellLeftDownPoint.y -= 1;
//                        CGPoint coorPoint = [cell.superview convertPoint:cellLeftDownPoint toView:nil];
//                        BOOL isContain = CGRectContainsPoint(windowRect, coorPoint);
//                        if (isContain){
//                            finnalCell = cell;
//                            break;
//                        }
//                    }
//                
//                }else{
//                    CGPoint coorCentre = [cell.superview convertPoint:cell.center toView:nil];
//                    CGFloat delta = fabs(coorCentre.y- 64 -windowRect.size.height*0.5);
//                    if (delta < gap) {
//                        gap = delta;
//                        finnalCell = cell;
//                    }
//                }
//            }
//        }
//    }
//    
//    return finnalCell;
//}
#pragma mark - 在当前界面播放视频
//- (void)playVideoInVisiableCells{
//    
//    NSArray *visiableCells = [self.tabview visibleCells];
//    // 在可见cell中找到第一个有视频的cell
//    VideoPlayCell * videoCell = nil;
//    for (VideoPlayCell *cell in visiableCells) {
//        if (cell.videoPath.length > 0) {
//            videoCell = cell;
//            break;
//        }
//    }
//    // 如果找到了, 就开始播放视频
//    if (videoCell) {
//        self.playingCell = videoCell;
//        
//        if (!self.playerView.player) {
//            [self.playerView setUpPlayer:@[self.playingCell.videoPath]];
//        }
//        //播放过视频
//        [self.playingCell addSubview:self.playerView];
//    }
//}
//- (NSUInteger)maxNumCannotPlayVideoCells{
//    NSUInteger num = [objc_getAssociatedObject(self, _cmd) integerValue];
//    if (num==0) {
//        CGFloat radius = [UIScreen mainScreen].bounds.size.height / VideoPlayCellHeigh;
//        NSUInteger maxNumOfVisiableCells = ceil(radius);
//        if (maxNumOfVisiableCells >= 3) {
//            num =  [[self.dictOfVisiableAndNotPlayCells valueForKey:[NSString stringWithFormat:@"%ld", (unsigned long)maxNumOfVisiableCells]] integerValue];
//            objc_setAssociatedObject(self, @selector(maxNumCannotPlayVideoCells), @(num), OBJC_ASSOCIATION_ASSIGN);
//        }
//    }
//    return num;
//}

#pragma mark - 这里返回为0 为了以后看懂思路还要保留这些

/**
 * 由于我们是在tableView静止的时候播放停在屏幕中心的cell, 所以可能出现总有一些cell无法满足我们的播放条件.
 * 所以我们必须特别处理这种情况, 我们首先要做的就是检查什么样的情况下才会出现这种类型的cell.
 * 下面是我的测量结果(iPhone 6s, iPhone 6 plus).
 * 每屏可见cell个数           4  3  2
 * 滑动不可及的cell个数        1  1  0
 * 注意 : 你需要仔细思考一下我的测量结果, 举个例子, 如果屏幕上有4个cell, 那么这个时候, 我们能够在顶部发现一个滑动不可及cell, 同时, 我们在底部也会发现一个这样的cell.
 * 注意 : 只有每屏可见cell数在3以上时,才会出现滑动不可及cell.
 */
//- (NSDictionary *)dictOfVisiableAndNotPlayCells{
//    // 以每屏可见cell的最大个数为key, 对应的滑动不可及cell数为value
//    NSDictionary *dict = objc_getAssociatedObject(self, _cmd);
//    if (!dict) {
//        dict = @{
//                 @"4" : @"1",
//                 @"3" : @"1",
//                 @"2" : @"0"
//                 };
//        objc_setAssociatedObject(self, @selector(setDictOfVisiableAndNotPlayCells:), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return dict;
//}
//- (void)setDictOfVisiableAndNotPlayCells:(NSDictionary *)dictOfVisiableAndNotPlayCells{
//    
//}


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
    VideoListModel * model = self.dataArray[indexpath.section];
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

@end
