//
//  PageDetailViewController.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/9.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PageDetailViewController.h"
#import "PhotoDescView.h"
#import "PhotoDetailCell.h"
#import "LoginViewController.h"
#import "PhotoDetailModel.h"
@interface PageDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) PhotoDetailModel * photoModel;
@property (nonatomic, strong) PhotoDescView * descView;
@property (nonatomic, strong) UICollectionView * photoView;
@property (nonatomic) int index;

@end

@implementation PageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    [self drawBackButton];
    [self creatRightBarButton];
    [self setNavAlpha];
    [self getData];
    [self creatUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavUnAlpha];
    [self setNavLineHidden];
}
- (void)creatRightBarButton{
    UIImage * saveImg = [[UIImage imageNamed:@"nav_icon_download_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * shareImg = [[UIImage imageNamed:@"nav_icon_share_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * save = [[UIBarButtonItem alloc]initWithImage:saveImg style:UIBarButtonItemStylePlain target:self action:@selector(saveImage)];
    UIBarButtonItem * share = [[UIBarButtonItem alloc]initWithImage:shareImg style:UIBarButtonItemStylePlain target:self action:@selector(shareThisImages)];
    self.navigationItem.rightBarButtonItems = @[share,save];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor blackColor];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize =CGSizeMake(UI_WIDTH, UI_HEGIHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.photoView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) collectionViewLayout:layout];
    [self.photoView registerClass:[PhotoDetailCell class] forCellWithReuseIdentifier:@"PhotoDetailCell"];
    self.photoView.backgroundColor = [UIColor clearColor];
    self.photoView.pagingEnabled = YES;
    self.photoView.delegate = self;
    self.photoView.dataSource = self;
    self.photoView.backgroundColor = [UIColor clearColor];
    self.photoView.showsVerticalScrollIndicator = NO;
    self.photoView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.photoView];
    self.photoView.userInteractionEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.descView = [[PhotoDescView alloc]initWithFrame:CGRectMake(0, UI_HEGIHT -Anno750(200), UI_WIDTH, Anno750(200))];
    [self.descView.likeBtn addTarget:self action:@selector(collectThisPictures:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.descView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoModel.list.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoDetailCell" forIndexPath:indexPath];
    [cell updateWithPic:self.photoModel.list[indexPath.row].pic];
    return cell;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.photoView) {
        if (0<=scrollView.contentOffset.x<= UI_WIDTH * self.photoModel.list.count) {
            int index = (scrollView.contentOffset.x / UI_WIDTH);
            self.index = index;
            [self.descView updateWithPhotoDetail:self.photoModel withIndex:index];
        }
    }
}

#pragma mark - getdata
- (void)getData{
    [SVProgressHUD show];
    NSDictionary * params = @{
                              @"id":self.photoID,
                              };
    [[NetWorkManger manager] sendRequest:NewWest_albumDetail route:Route_NewWest withParams:params complete:^(NSDictionary *result) {
        [self hiddenNullView];
        NSDictionary * dic = result[@"data"];
        self.photoModel = [[PhotoDetailModel alloc]initWithDictionary:dic];
        [self.descView updateWithPhotoDetail:self.photoModel withIndex:0];
        [self.photoView reloadData];
    } error:^(NFError *byerror) {
        [self showNullViewByType:NullTypeNetError];
    }];
}
- (void)collectThisPictures:(UIButton *)btn{
    if (![UserManager manager].isLogin) {
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        [SVProgressHUD show];
        NSDictionary * params = @{
                                  @"uid":[UserManager manager].userID,
                                  @"type":@"album",
                                  @"id":self.photoID
                                  };
        [[NetWorkManger manager] sendRequest:PageCollect route:Route_Set withParams:params complete:^(NSDictionary *result) {
            NSString * title = @"收藏成功";
            if (self.photoModel.collected) {
                title = @"取消收藏成功";
            }
            self.photoModel.collected = !self.photoModel.collected;
            if (self.photoModel.collected) {
                self.photoModel.collect_num = @(self.photoModel.collect_num.intValue + 1);
            }else{
                self.photoModel.collect_num = @(self.photoModel.collect_num.intValue - 1);
            }
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:title  duration:1.0f];
            [self.descView updateWithPhotoDetail:self.photoModel withIndex:self.index];
        } error:^(NFError *byerror) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
        }];
    }
}


#pragma mark - 保存
- (void)saveImage{
    int index = self.photoView.contentOffset.x / UI_WIDTH;
    PhotoDetailCell * cell = (PhotoDetailCell *)[self.photoView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UIImageWriteToSavedPhotosAlbum([cell.photoView.imageView image], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的“设置-隐私-照片”中允许NFL橄榄球访问您的照片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconSuccess text:@"保存成功" duration:1.0f];
    }
}
#pragma mark - 分享
- (void)shareThisImages{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        //图片
        int index = self.photoView.contentOffset.x / UI_WIDTH;
        PhotoDetailCell * cell = (PhotoDetailCell *)[self.photoView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        UIImage * image = cell.photoView.imageView.image;
        NSString * title = self.photoModel.album_title;
        NSString * desc = self.photoModel.list[index].title;
        if (desc.length == 0) {
            desc = @"更多精彩内容来自[NFL橄榄球]APP";
        }
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        UMShareWebpageObject * shareObj;
        shareObj = [UMShareWebpageObject shareObjectWithTitle:title descr:desc thumImage:image];
        shareObj.webpageUrl = self.photoModel.share_link;
        messageObject.shareObject = shareObj;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
            if (!error) {
                [[UserManager manager] overShareTask];
            }
        }];
        
    }];
}



@end
