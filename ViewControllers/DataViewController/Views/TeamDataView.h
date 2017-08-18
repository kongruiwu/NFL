//
//  TeamDataView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/16.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "TeamDataModel.h"

@interface TeamDataView : UIView
/**进攻得分*/
@property (nonatomic, strong) UILabel * scoreValue;
@property (nonatomic, strong) UILabel * scoreLabel;
/**跑球码数*/
@property (nonatomic, strong) UILabel * runValue;
@property (nonatomic, strong) UILabel * runLabel;
/**防守失分*/
@property (nonatomic, strong) UILabel * defenseValue;
@property (nonatomic, strong) UILabel * defenseLabel;
/**传球码数*/
@property (nonatomic, strong) UILabel * passValue;
@property (nonatomic, strong) UILabel * passLabel;
/**防传码数*/
@property (nonatomic, strong) UILabel * defenPassValue;
@property (nonatomic, strong) UILabel * defenPassLabel;
/**防跑码数*/
@property (nonatomic, strong) UILabel * defenRunValue;
@property (nonatomic, strong) UILabel * defenRunLabel;

/**下方描述*/
@property (nonatomic, strong) UIView * redView;
@property (nonatomic, strong) UIView * blueView;
@property (nonatomic, strong) UILabel * redDesc;
@property (nonatomic, strong) UILabel * blueDesc;

@property (nonatomic, strong) NSMutableArray * rankLabels;
@property (nonatomic, strong) NSMutableArray * points;

@property (nonatomic, strong) CAShapeLayer * insidelayer;

- (void)updateWithTeamDataInfoModel:(TeamDataInfoModel *)model;

@end
