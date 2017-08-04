//
//  ShareView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "ShareModel.h"
@interface ShareButton : UIButton

@end

@interface ShareView : UIView

//分享标题
@property (nonatomic, strong) NSString * shareTitle;
//分享描述
@property (nonatomic, strong) NSString * shareDesc;
//分享图片
@property (nonatomic, strong) NSString * imageUrl;
//分享目标
@property (nonatomic, strong) NSString * targeturl;
//图片
@property (nonatomic, strong) UIImage * image;


@property (nonatomic, strong) UIView * showView;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) ShareButton * wechatBtn;
@property (nonatomic, strong) ShareButton * momentBtn;
@property (nonatomic, strong) ShareButton * QQbtn;
@property (nonatomic, strong) ShareButton * QQSpaceBtn;
@property (nonatomic, strong) ShareButton * sinaBtn;
@property (nonatomic, strong) ShareButton * videoAdd;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UIButton * disBtn;
@property (nonatomic, strong) UIButton * cannceBtn;

@end
