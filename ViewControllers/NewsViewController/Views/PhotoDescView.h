//
//  PhotoDescView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeButton.h"
#import "PhotoDetailModel.h"
@interface PhotoDescView : UIView


@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * countLabel;
@property (nonatomic, strong) LikeButton * likeBtn;

- (void)updateWithPhotoDetail:(PhotoDetailModel *)model withIndex:(int)index;

@end
