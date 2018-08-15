//
//  SignInHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface SignInHeader : UIView

@property (nonatomic, strong) UIView * centerView;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * scoreLabel;

@property (nonatomic, strong) UIButton * signIBtn;


- (void)updateScore;

@end
