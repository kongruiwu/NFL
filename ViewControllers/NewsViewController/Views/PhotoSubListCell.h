//
//  PhotoSubListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeButton.h"
#import "InfoListModel.h"

@interface PhotoSubListView : UIView

@property (nonatomic, strong) UIImageView * topImg;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * countLabel;

@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UILabel * timelabel;
@property (nonatomic, strong) LikeButton * likeBtn;

- (void)updateWithPhotoListModel:(InfoListModel *)model;

@end

@protocol PhotoSubListCellDelegate <NSObject>

- (void)checkLeftPhotos:(UIButton *)button;
- (void)checkRightPhotos:(UIButton *)button;
- (void)collectThisPictures:(UIButton *)button;
@end

@interface PhotoSubListCell : UITableViewCell

@property (nonatomic, strong) PhotoSubListView * leftView;
@property (nonatomic, strong) PhotoSubListView * rightView;
@property (nonatomic, strong) UIButton * leftButton;
@property (nonatomic, strong) UIButton * rightButton;
@property (nonatomic, assign) id<PhotoSubListCellDelegate> delegate;

- (void)updateWithLeftModel:(InfoListModel *)leftm rightModel:(id)rightm;
@end
