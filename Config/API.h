//
//  API.h
//  KeTing
//
//  Created by 吴孔锐 on 2017/6/6.
//  Copyright © 2017年 wurui. All rights reserved.
//

#ifndef API_h
#define API_h

#define Base_ApiHost    @"http://api.nflchina.com"
#define BER_APP_KEY     @"98NexY5d75M76ab"


//视频
#define Route_Viedeo        @"video2017"
#define Video_List          @"list"
#define Video_Detail        @"detail"

//最新
#define Route_NewWest       @"newest2017"
//资讯
#define NewWest_Info        @"information"
//图集
#define NewWest_album       @"album"
//图集列表
#define NewWest_albumlist   @"album_list"
//图集详情
#define NewWest_albumDetail @"album_detail"
//专栏
#define NewWest_column      @"column"

//用户中心
#define Route_User          @"user2017"
//三方登录完善注册资料
#define Page_Oauth          @"oauth_info"
//检测三方帐号是否注册
#define Page_CheckOauth     @"check_oauth"
//手机注册
#define Page_MobRegister    @"mobile_register"
//手机注册信息完善
#define Page_MobOverInfo    @"mobile_register_info"
//设置
#define Route_Set           @"setting2017"
//发送验证码
#define PageSendSms         @"send_sms"
//用户登录
#define PageLogin           @"login"
//找回密码
#define Pagerepwd           @"repwd"
//忘记密码 填写新密码
#define PageNewPwd          @"repwd_new"

#endif /* API_h */
