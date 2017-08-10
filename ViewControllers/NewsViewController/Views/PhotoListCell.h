//
//  PhotoListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PhotoSetModel.h"
@interface PhotoListCell : UITableViewCell

@property (nonatomic, strong) UIImageView * bgImg;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UIView * topLine;
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, strong) UILabel * titleLabel;


- (void)updateWithPhotoSetModel:(PhotoSetModel *)model;
@end
