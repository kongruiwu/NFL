//
//  TeamDetailHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "SelectTopView.h"
@interface TeamDetailHeader : UIView

@property (nonatomic, strong) UIImageView * bgImg;
@property (nonatomic, strong) UIImageView * teamImg;
@property (nonatomic, strong) UILabel * name_zn;
@property (nonatomic, strong) UILabel * name_en;
@property (nonatomic, strong) UIButton * teamVideo;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UILabel * belongLabel;
@property (nonatomic, strong) UILabel * creatAt;
@property (nonatomic, strong) UILabel * address;
@property (nonatomic, strong) UILabel * playground;
@property (nonatomic, strong) UIView * line;
@property (nonatomic, strong) SelectTopView * selectView;
@end
