//
//  TeamHeadView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface TeamHeadView : UIView

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * subScore;
@property (nonatomic, strong) UILabel * winProgress;
@property (nonatomic, strong) UILabel * unionScore;
@property (nonatomic, strong) UILabel * outScore;
@property (nonatomic, strong) UIView * lineView;

@end
