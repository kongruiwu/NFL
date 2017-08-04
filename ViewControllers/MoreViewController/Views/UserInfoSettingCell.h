//
//  UserInfoSettingCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface UserInfoSettingCell : UITableViewCell


@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UIImageView * nextIcon;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UIView * lineView;

@property (nonatomic, strong) UIImageView * wechat;
@property (nonatomic, strong) UIImageView * qq;
@property (nonatomic, strong) UIImageView * weibo;



- (void)updateUserIconWithTitle:(NSString *)title;
- (void)updateWithTitle:(NSString *)title desc:(NSString *)desc hidden:(BOOL)rec;
- (void)updateThirdLogIcon;
@end
