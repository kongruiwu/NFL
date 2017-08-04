//
//  TextFieldCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface TextFieldCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIView * line;

- (void)updateTitle:(NSString *)title placeHolder:(NSString *)placeHolder;
@end
