//
//  SignInTableViewCell.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/19.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@protocol SignInTableViewCellDelegate <NSObject>

- (void)completeTaskClick:(UIButton *)btn;

@end

@interface SignInTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UIButton * missonBtn;
@property (nonatomic, assign) id<SignInTableViewCellDelegate> delegate;

- (void)updateWithTitle:(NSString *)title image:(NSString *)imageName;
@end
