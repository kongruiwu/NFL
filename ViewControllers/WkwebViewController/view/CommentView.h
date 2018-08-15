//
//  CommentView.h
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface CommentView : UIView


@property (nonatomic, strong) UIButton * clearBtn;
@property (nonatomic, strong) UIImageView * userIcon;
@property (nonatomic, strong) UITextField * textF;


- (void)updateLoginStatus;

@end
