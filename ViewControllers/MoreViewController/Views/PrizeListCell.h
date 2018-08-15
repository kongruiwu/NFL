//
//  PrizeListCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/20.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "PrizeListModel.h"

@protocol PrizeListCellDelegate <NSObject>

- (void)changePrize:(UIButton *)btn;

@end

@interface PrizeListCell : UITableViewCell

@property (nonatomic, strong) UIImageView * prizeIcon;
@property (nonatomic, strong) UILabel * prizeName;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UIButton * exchangeBtn;
@property (nonatomic, strong) UIView * line;
@property (nonatomic, assign) id<PrizeListCellDelegate> delegate;


- (void)updateWithPrizeListModel:(PrizeListModel *)model;
@end
