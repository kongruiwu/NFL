//
//  PhoneAboutViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"
#import <UMSocialCore/UMSocialCore.h>
typedef NS_ENUM(NSInteger, ChangeType){
    ChangeTypeBindPhone = 0,        //绑定手机
    ChangeTypeChangePhone,          //修改手机
    ChangeTypeChangePwd,            //修改密码
    ChangeTypeRegister,             //注册
    ChangeTypeOverInfo,             //完善信息
    ChangeTypeOverThirdInfo,        //完善三方信息
    ChangeTypeFindPwd,              //找回密码
    ChangeTypeFindToChangePwd,      //找回密码 ->修改密码
};

@interface PhoneAboutViewController : BaseViewController

@property (nonatomic, assign) ChangeType vcType;
@property (nonatomic, strong) NSString * thirdType;
@property (nonatomic, strong) UMSocialUserInfoResponse * thirdResp;

- (instancetype)initWithType:(ChangeType)changeType;

@end
