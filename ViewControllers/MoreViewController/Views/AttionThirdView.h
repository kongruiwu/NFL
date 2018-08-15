//
//  AttionThirdView.h
//  NFL
//
//  Created by 吴孔锐 on 2018/8/9.
//  Copyright © 2018年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "KRCodeTextFeildView.h"
typedef NS_ENUM(NSInteger,ThirdType){
    ThirdTypeSina = 0 ,
    ThirdTypeWexin
};

@interface AttionThirdView : UIView

@property (nonatomic, strong) UIView * showView;
@property (nonatomic, strong) UIImageView * blueImg;
@property (nonatomic, strong) UIImageView * nflIcon;
@property (nonatomic, strong) UILabel * thirdName;
@property (nonatomic, strong) UIImageView * thirdIcon;
@property (nonatomic, strong) NSMutableArray<UILabel *> * descLabels;
@property (nonatomic, strong) UILabel * writeCode;
@property (nonatomic, strong) UIButton * sureBtn;

@property (nonatomic, strong) KRCodeTextFeildView * codeView;

@property (nonatomic, strong) UIButton * canncleBtn;

@property (nonatomic, assign) ThirdType thirdType;

- (void)show;
- (void)dismiss;

@end
