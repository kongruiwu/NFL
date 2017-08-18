//
//  TeamerLeftCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PlayerLineUpModel.h"   
@interface TeamerLeftCell : UITableViewCell

@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * fristLabel;

@property (nonatomic, strong) UIScrollView * scrollview;

@property (nonatomic, strong) UILabel * otherLabel;
@property (nonatomic, strong) UILabel * otherLabel1;
@property (nonatomic, strong) UILabel * otherLabel2;
@property (nonatomic, strong) UILabel * otherLabel3;
@property (nonatomic, strong) UILabel * otherLabel4;

@property (nonatomic, strong) UIView * line1;
@property (nonatomic, strong) UIView * line2;

- (void)updateWithPlayerLineUpModel:(PlayerLineUpModel *)model contentoffX:(CGFloat)contentoffX;

@end
