//
//  TeamImageView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "TeamModel.h"
@interface TeamImageView : UIImageView

@property (nonatomic, strong) UIImageView * teamImg;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UIImageView * selectImg;

@property (nonatomic, strong) UIButton * clearBtn;

- (void)updateWithTeamModel:(TeamModel *)model;

@end
