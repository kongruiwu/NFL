//
//  ShowMessageView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"



typedef NS_ENUM(NSInteger, MessageType){
    MessageTypeSex = 0,         //性别
    MessageTypeBrithday,        //生日
    MessageTypeTeam,            //设置主队
};


@protocol ShowMessageViewDelegate <NSObject>

- (void)UserClickSureButtonWithType:(MessageType)type;

@end


@interface ShowMessageView : UIView

@property (nonatomic, assign) MessageType messageType;


/**界面点击消失使用*/
@property (nonatomic, strong) UIButton * topBtn;
@property (nonatomic, strong) UIButton * bottomBtn;

/**主显示界面*/
@property (nonatomic, strong) UIView * showView;

/**标题栏*/
@property (nonatomic, strong) UILabel * titleLabel;


/**性别*/
@property (nonatomic, strong) UIButton * menButton;
@property (nonatomic, strong) UIView * topLine;
@property (nonatomic, strong) UIButton * womButton;

/**生日*/
@property (nonatomic ,strong) UIDatePicker * datePicker;

/**设置主队*/
@property (nonatomic, strong) UIButton * setTeam;
@property (nonatomic, strong) UILabel * teamDesc;


/**底部确认*/
@property (nonatomic, strong) UIView * bottomLine;
@property (nonatomic, strong) UIButton * sureButton;
@property (nonatomic, strong) UIView * centerLine;
@property (nonatomic, strong) UIButton * cannceBtn;

@property (nonatomic, assign) id <ShowMessageViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame MessageType:(MessageType)type;
- (void)show;
- (void)dismiss;
@end
