//
//  GameStarsCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "LiveViewModel.h"
@interface StarView : UIView

@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * scorekey;
@property (nonatomic, strong) UILabel * desckey;
@property (nonatomic, strong) UILabel * scorevalue;
@property (nonatomic, strong) UILabel * descvalue;

- (void)updateWithStarDetailModel:(StarDetailModel *)model;

@end


@interface GameStarsCell : UITableViewCell

@property (nonatomic, strong) StarView * homeView;
@property (nonatomic, strong) StarView * visitorView;
- (void)updateWithArray:(StarModel *)star;

@end

