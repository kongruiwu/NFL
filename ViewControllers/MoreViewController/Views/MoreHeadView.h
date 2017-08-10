//
//  MoreHeadView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface MoreHeadView : UIView

@property (nonatomic, strong) UIImageView * bgImage;
@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UILabel * loginLabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UIImageView * editImage;
@property (nonatomic, strong) UILabel * editLabel;
@property (nonatomic, strong) UIImageView * teamIcon;

@property (nonatomic, strong) UIButton * clearButton;


- (void)updateUIbyUserInfo;
@end
