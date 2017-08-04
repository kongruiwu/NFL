//
//  PhotoSubListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeButton.h"
@interface PhotoSubListView : UIView

@property (nonatomic, strong) UIImageView * topImg;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * countLabel;

@property (nonatomic, strong) UIView * whiteView;
@property (nonatomic, strong) UILabel * timelabel;
@property (nonatomic, strong) LikeButton * likeBtn;



@end



@interface PhotoSubListCell : UITableViewCell

@property (nonatomic, strong) PhotoSubListView * leftView;
@property (nonatomic, strong) PhotoSubListView * rightView;

@end
