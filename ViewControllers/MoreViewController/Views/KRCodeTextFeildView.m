//
//  KRCodeTextFeildView.m
//  NFL
//
//  Created by 吴孔锐 on 2018/8/14.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import "KRCodeTextFeildView.h"

#define CodeCount   8
#define CodeSpace   Anno750(18)
@implementation KRCodeTextFeildView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    float with = (self.frame.size.width -  (CodeCount - 1) * CodeSpace)/CodeCount;
    self.labels = [NSMutableArray new];
    self.textField = [[UITextField alloc]init];
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.textColor = [UIColor clearColor];
    self.textField.alpha = 1;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.mas_bottom);
        make.height.equalTo(@0.01);
    }];
    
    for (int i = 0 ; i<CodeCount; i++) {
        UILabel * label = [Factory creatLabelWithText:@""
                                            fontValue:font750(36)
                                            textColor:Color_MainBlack
                                        textAlignment:NSTextAlignmentCenter];
        UIView * line = [Factory creatViewWithColor:Color_MainBlack];
        [self addSubview:label];
        [label addSubview:line];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.left.equalTo(@0);
            }else{
                make.left.equalTo(@(i * (with + CodeSpace)));
            }
            make.height.equalTo(@(Anno750(56)));
            make.width.equalTo(@(with));
            make.centerY.equalTo(@0);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.bottom.equalTo(@0);
            make.height.equalTo(@1);
            make.right.equalTo(@0);
        }];
        [self.labels addObject:label];
    }
    
    UIButton * clearBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    [clearBtn addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.width.equalTo(@(Anno750(750 - 190)));
        make.height.equalTo(@(Anno750(56)));
        make.centerY.equalTo(@0);
    }];
    
}
- (void)beginEditing{
    if (self.textField.isEditing) {
        return;
    }
    [self.textField becomeFirstResponder];
}
- (void)textFieldDidChange:(UITextField *)textfield{
    NSString *verStr = textfield.text;
    //有空格去掉空格
    verStr = [verStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (verStr.length >= CodeCount) {
        verStr = [verStr substringToIndex:CodeCount];
        [textfield endEditing:YES];
    }
    textfield.text = verStr;
    
    for (int i= 0; i < self.labels.count; i++) {
        //以text为中间
        UILabel *label = self.labels[i];
        if (i<verStr.length) {
            label.text = [verStr substringWithRange:NSMakeRange(i, 1)];
        }else{
            label.text = @"";
        }
    }
}

- (void)clearText{
    self.textField.text = @"";
    for (int i = 0; i<self.labels.count; i++) {
        self.labels[i].text = @"";
    }
}
@end
