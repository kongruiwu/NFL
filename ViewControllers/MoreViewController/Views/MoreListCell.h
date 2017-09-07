//
//  MoreListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface MoreListCell : UITableViewCell

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UIImageView * nextIcon;
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, strong) UIView * redIcon;


- (void)updateWithTitle:(NSString *)title image:(NSString *)iamge desc:(NSString *)desc;
@end
