//
//  ShareView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "ShareView.h"
#define ShowH   Anno750(288 * 2)
@implementation ShareButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.bounds.size.width - Anno750(86))/2, Anno750(50), Anno750(86), Anno750(86));
    self.titleLabel.frame = CGRectMake(0, Anno750(146), UI_WIDTH / 3, Anno750(30));
}


@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    /*
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
     */
    
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    self.showView = [Factory creatViewWithColor:[UIColor whiteColor]];
    self.showView.frame = CGRectMake(0, UI_HEGIHT, UI_WIDTH, ShowH);
    [self addSubview:self.showView];
    self.cannceBtn = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    self.cannceBtn.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - ShowH);
    [self.cannceBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cannceBtn];
    
    self.descLabel = [Factory creatLabelWithText:@"分享至"
                                       fontValue:font750(28)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentLeft];
    [self.showView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(24)));
    }];
    
    NSArray * images = @[@"",@"",@"",@"",@"",@""];
    NSArray * titles = @[@"微信",@"朋友圈",@"QQ空间",@"QQ",@"微博",@"链接"];
    for (int i = 0; i<images.count; i++) {
        ShareButton * btn = [self creatSubShareButtonTitle:titles[i] imageName:images[i]];
        btn.tag = 1000 + i;
        
    }
    
    
    
    self.grayView = [Factory creatViewWithColor:Color_Line];
    [self.showView addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@0.5);
        make.top.equalTo(self.wechatBtn.mas_bottom);
    }];
    self.disBtn = [Factory creatButtonWithTitle:@"取消"
                                  backGroundColor:[UIColor clearColor]
                                        textColor:Color_LightGray
                                         textSize:font750(30)];
    [self.showView addSubview:self.disBtn];
    [self.disBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.grayView.mas_bottom);
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    [self.disBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setFristValue{
    self.shareTitle = @"超级碗nfl";
    self.shareDesc = @"nfl";
    self.targeturl = [NSString stringWithFormat:@""];
    self.imageUrl = @"";
    self.image = [UIImage imageNamed:@"logo"];
}

- (void)updateWithShareModel:(ShareModel *)model{
    self.shareTitle = model.shareTitle;
    self.shareDesc = model.shareDesc;
    self.targeturl = model.targeturl;
    self.imageUrl = model.imageUrl;
    self.image = model.image;
}
- (ShareButton *)creatSubShareButtonTitle:(NSString *)title imageName:(NSString *)imgName{
    ShareButton * btn = [ShareButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:Color_DarkGray forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font750(26)];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(doShareWithButton:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)show{
    self.hidden = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        self.showView.frame = CGRectMake(0, UI_HEGIHT - ShowH - Nav64, UI_WIDTH,  ShowH);
    }];
}
- (void)disMiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.showView.frame = CGRectMake(0, UI_HEGIHT - Nav64, UI_WIDTH, ShowH);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
    });
}
- (void)doShareWithButton:(UIButton *)btn{
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//    id image;
//    if (self.imageUrl.length<1) {
//        image = self.image;
//    }else{
//        image = self.imageUrl;
//    }
//    UMShareWebpageObject * shareObj = [UMShareWebpageObject shareObjectWithTitle:self.shareTitle descr:self.shareDesc thumImage:image];
//    UMShareImageObject * shareImage = [UMShareImageObject shareObjectWithTitle:self.shareTitle descr:self.shareDesc thumImage:image];
//    shareObj.webpageUrl = self.targeturl;
//    UMSocialPlatformType type = UMSocialPlatformType_WechatSession;
//    switch (btn.tag - 1001) {
//        case 0:
//            type = UMSocialPlatformType_WechatSession;
//            break;
//        case 1:
//            type = UMSocialPlatformType_WechatTimeLine;
//            break;
//        case 2:
//            type = UMSocialPlatformType_QQ;
//            break;
//        case 3:
//            type = UMSocialPlatformType_Qzone;
//            break;
//        case 4:
//        {
//            type = UMSocialPlatformType_Sina;
//            [shareImage setShareImage:image];
//        }
//            break;
//    }
//    
//    messageObject.shareObject = shareObj;
//    //调用分享接口
//    if (type == UMSocialPlatformType_Sina) {
//        messageObject.text = [NSString stringWithFormat:@"%@%@",self.shareDesc,self.targeturl];
//        messageObject.shareObject = shareImage;
//    }
//    [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    [self disMiss];
    
}

@end
