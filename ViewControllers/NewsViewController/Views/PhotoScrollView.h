//
//  PhotoScrollView.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#define MaxZoomScale  2.5f
#define MinZoomScale  1.0f

@interface PhotoScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIActivityIndicatorView * loadView;


- (void)updateImageviewWithurl:(NSString *)url;
- (void)doubleTapAction;
@end
