//
//  KRCodeTextFeildView.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/14.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface KRCodeTextFeildView : UIView

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) NSMutableArray<UILabel *> * labels;
- (void)clearText;
@end
