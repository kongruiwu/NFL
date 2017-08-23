//
//  LeftTalkCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "OnlineAnswerModel.h"
@interface LeftTalkCell : UITableViewCell

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) UIImageView * bgImg;
@property (nonatomic, strong) UILabel * contentLabel;

- (void)updateWithOnlineAnswerModel:(OnlineAnswerModel *)model;

@end
