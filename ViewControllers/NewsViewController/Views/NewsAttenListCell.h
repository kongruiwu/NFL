//
//  NewsAttenListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeButton.h"
#import "ConfigHeader.h"
#import "VideoListModel.h"
#import "InfoListModel.h"


@interface NewsAttenListCell : UITableViewCell

@property (nonatomic, strong) UIImageView * topImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) LikeButton * likeBtn;
@property (nonatomic, strong) UIImageView * playIcon;


- (void)updateWithObjectModel:(id)model;
@end
