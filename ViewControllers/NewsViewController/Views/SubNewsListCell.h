//
//  SubNewsListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "LikeButton.h"
#import "VideoListModel.h"
#import "InfoListModel.h"
@interface SubNewsListCell : UITableViewCell

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) LikeButton * likeBtn;
@property (nonatomic, strong) UILabel * adLabel;
@property (nonatomic, strong) UIImageView * playIcon;
- (void)updateWithObjectModel:(id)model;
@end
