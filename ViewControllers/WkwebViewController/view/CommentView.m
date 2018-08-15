//
//  CommentView.m
//  NFL
//
//  Created by 吴孔锐 on 2018/7/16.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_MainBlue;
    self.userIcon = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.userIcon.layer.cornerRadius = Anno750(75/2);
    self.userIcon.layer.masksToBounds = YES;
    self.textF = [Factory creatTextFiledWithPlaceHold:@"说说你的看法"];
    UIView * view = [Factory creatViewWithColor:[UIColor clearColor]];
    view.frame = CGRectMake(0, 0, Anno750(20), Anno750(40));
    self.textF.leftView = view;
    self.textF.leftViewMode = UITextFieldViewModeAlways;
    self.textF.layer.cornerRadius = Anno750(8);
    self.textF.backgroundColor = [UIColor whiteColor];
    self.textF.returnKeyType = UIReturnKeySend;
    self.clearBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    self.clearBtn.hidden = YES;
    
    
    [self addSubview:self.userIcon];
    [self addSubview:self.textF];
    [self addSubview:self.clearBtn];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(75)));
        make.width.equalTo(@(Anno750(75)));
    }];
    [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(Anno750(20));
        make.centerY.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
}

- (void)updateLoginStatus{
    if ([UserManager manager].isLogin) {
        [self.userIcon sd_setImageWithURL:[NSURL URLWithString:[UserManager manager].info.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
        self.clearBtn.hidden = YES;
    }else{
        self.userIcon.image = [UIImage imageNamed:@"list_img_user_normal"];
        self.clearBtn.hidden = NO;
    }
}

@end
