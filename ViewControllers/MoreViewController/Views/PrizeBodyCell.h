//
//  PrizeBodyCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface PrizeBodyCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UITextField * valueTextf;
@property (nonatomic, strong) UIView * line;

- (void)updateWithTitle:(NSString *)title placeHold:(NSString *)placeHold;
@end
