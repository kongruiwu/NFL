//
//  TeamDataProgressCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface TeamDataProgressCell : UITableViewCell

@property (nonatomic, strong) UILabel * leftScore;
@property (nonatomic, strong) UILabel * rightScore;
@property (nonatomic, strong) UILabel * nameLabel;

@property (nonatomic, strong) UISlider * slider;
- (void)updateWithTitles:(NSString *)title leftScore:(NSNumber *)left rightScore:(NSNumber *)right;
- (void)updateThirdWithTitles:(NSString *)title leftScore:(NSNumber *)left rightScore:(NSNumber *)right;

@end
