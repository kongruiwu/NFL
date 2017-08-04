//
//  TalkeInputView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TalkeInputView.h"

@implementation TalkeInputView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_MainBlue;
    self.textField = [Factory creatTextFiledWithPlaceHold:@"请输入文字内容"];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    UIView * view = [Factory creatViewWithColor:[UIColor clearColor]];
    view.frame = CGRectMake(0, 0, Anno750(20), Anno750(30));
    self.textField.leftView = view;
    self.textField.layer.cornerRadius = Anno750(8);
    self.textField.returnKeyType = UIReturnKeySend;
    
    self.sendBtn = [Factory creatButtonWithNormalImage:@"input_icon_sendout_nor" selectImage:@""];
    self.textField.frame = CGRectMake(Anno750(24), Anno750(18), Anno750(620), Anno750(62));
    self.sendBtn.frame = CGRectMake(UI_WIDTH - Anno750(84), (self.frame.size.height - Anno750(50))/2, Anno750(50), Anno750(50));
    [self addSubview:self.textField];
    [self addSubview:self.sendBtn];
    
}
@end
