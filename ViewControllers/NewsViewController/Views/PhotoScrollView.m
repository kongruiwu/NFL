//
//  PhotoScrollView.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoScrollView.h"

@implementation PhotoScrollView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    
    self.delegate = self;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.alwaysBounceVertical = NO;
    self.maximumZoomScale = MaxZoomScale;
    self.minimumZoomScale = MinZoomScale;
    self.contentSize = self.bounds.size;
    self.tag = -1;
    
    self.loadView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.loadView.center = self.center;
    [self addSubview:self.loadView];
    [self.loadView startAnimating];
    [self.loadView setHidesWhenStopped:YES];
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView setClipsToBounds:YES];
    self.imageView.image = [UIImage imageNamed:@"banner_defult"];
    CGSize size = [self imageSizeWithImage:self.imageView.image];
    self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
    [self scrollViewDidZoom:self];
    [self addSubview:self.imageView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
}
#pragma mark 恢复图片原始状态
- (void)replyStatuseAnimated:(BOOL)animated{
    [self setZoomScale:1.0f animated:animated];
}
#pragma mark 双击事件
- (void)doubleTapAction{//图片变大或变小
    if (self.minimumZoomScale <= self.zoomScale && self.maximumZoomScale > self.zoomScale) {
        [self setZoomScale:self.maximumZoomScale animated:YES];
    }else {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
}
#pragma mark - Scroll View Deledate (不断适配图片大小)
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //放大或缩小时图片位置(frame)调整,保证居中
    CGFloat Wo = self.frame.size.width - self.contentInset.left - self.contentInset.right;
    CGFloat Ho = self.frame.size.height - self.contentInset.top - self.contentInset.bottom;
    CGFloat W = self.imageView.frame.size.width;
    CGFloat H = self.imageView.frame.size.height;
    CGRect rct = self.imageView.frame;
    rct.origin.x = MAX((Wo-W)*0.5, 0);
    rct.origin.y = MAX((Ho-H)*0.5, 0);
    self.imageView.frame = rct;
}
-(CGSize)imageSizeWithImage:(UIImage *)image{//图片根据屏幕大小来调整size,保证与屏幕比例适配
    CGFloat wid = image.size.width;
    CGFloat heig = image.size.height;
    if ((wid <= UI_WIDTH) && (heig <= UI_HEGIHT)) {
        return image.size;
    }
    
    CGFloat scale_poor = (wid/UI_WIDTH)-( heig/UI_HEGIHT);
    CGSize endSize = CGSizeZero;
    
    if (scale_poor > 0) {
        CGFloat height_now = heig*(UI_WIDTH/wid);
        endSize = CGSizeMake(UI_WIDTH, height_now);
    }else{
        CGFloat width_now = wid*(UI_HEGIHT/heig);
        endSize = CGSizeMake(width_now, UI_HEGIHT);
    }
    
    return endSize;
}
- (void)updateImageviewWithurl:(NSString *)url{
    [self replyStatuseAnimated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self.loadView stopAnimating];
        CGSize size = [self imageSizeWithImage:self.imageView.image];
        self.imageView.frame = CGRectMake(0, 0, size.width, size.height);
        [self scrollViewDidZoom:self];
    }];
}

@end
