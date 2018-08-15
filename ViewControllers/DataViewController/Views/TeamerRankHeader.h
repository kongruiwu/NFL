//
//  TeamerRankHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PlayerRankModel.h"
@interface TeamerRankHeader : UIView

@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UILabel * rank;
@property (nonatomic, strong) UILabel * teamer;
@property (nonatomic, strong) UILabel * pass;
@property (nonatomic, strong) UILabel * arrive;
@property (nonatomic, strong) UILabel * stop;


- (void)updateWithTitle:(NSString *)title descs:(NSArray<Stats *> *)descs;
@end
