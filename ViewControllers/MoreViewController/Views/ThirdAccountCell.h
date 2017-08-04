//
//  ThirdAccountCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface ThirdAccountCell : UITableViewCell

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIImageView * nextIcon;

- (void)updateWithImage:(NSString *)image title:(NSString *)title desc:(NSString *)desc;
@end
