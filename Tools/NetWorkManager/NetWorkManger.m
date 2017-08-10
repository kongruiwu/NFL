//
//  NetWorkManger.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "NetWorkManger.h"
#import "UIDevice+IdentifierAddition.h"
#import "NSDictionary+AXNetworkingMethods.h"
#import "NSString+MD5Addition.h"
@implementation NetWorkManger

+ (instancetype)manager{
    static NetWorkManger * manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[NetWorkManger alloc]init];
    });
    return manger;
}

- (void)sendRequest:(NSString *)action route:(NSString *)route withParams:(NSDictionary *)dataDic complete:(CompleteBlock)complete error:(ErrorBlock)byerror{
    NSString * url = [NSString stringWithFormat:@"%@/%@",Base_ApiHost,route];
    NSDictionary * params = [self newParamsWithPublicSetting:dataDic action:action];
    DLog(@"APIurlStar*******\n%@\n*******APIurlEnd",url);
    DLog(@"ParamsStar*******\n%@\n*******ParamsEnd",params);
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary * resultDic = (NSDictionary *)responseObject;
        if ([resultDic[@"code"] integerValue] == 0) {
            complete(resultDic);
        }else{
            NFError * error = [[NFError alloc]init];
            error.errorCode = [NSString stringWithFormat:@"%@",resultDic[@"code"]];
            error.errorMessage = resultDic[@"msg"];
            byerror(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NFError * error1 = [[NFError alloc]init];
        error1.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        error1.errorMessage = error.description;
        byerror(error1);
        [SVProgressHUD dismiss];
    }];
}
- (void)postRequest:(NSString *)action route:(NSString *)route withParams:(NSDictionary *)dataDic complete:(CompleteBlock)complete error:(ErrorBlock)byerror{
    NSString * url = [NSString stringWithFormat:@"%@/%@",Base_ApiHost,route];
    NSDictionary * params = [self newParamsWithPublicSetting:dataDic action:action];
    DLog(@"APIurlStar*******\n%@\n*******APIurlEnd",url);
    DLog(@"ParamsStar*******\n%@\n*******ParamsEnd",params);
    AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
    [manger POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary * resultDic = (NSDictionary *)responseObject;
        if ([resultDic[@"code"] integerValue] == 0) {
            complete(resultDic);
        }else{
            NFError * error = [[NFError alloc]init];
            error.errorCode = [NSString stringWithFormat:@"%@",resultDic[@"code"]];
            error.errorMessage = resultDic[@"msg"];
            byerror(error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NFError * error1 = [[NFError alloc]init];
        error1.errorCode = [NSString stringWithFormat:@"%ld",(long)error.code];
        error1.errorMessage = error.description;
        byerror(error1);
        [SVProgressHUD dismiss];
    }];
}
- (NSDictionary *)newParamsWithPublicSetting:(NSDictionary *)dic action:(NSString *)action{
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSDictionary *commnSignDic = @{
                                   @"action"    : action,
                                   @"platform"  : @"ios",
                                   @"deviceId"  : [UIDevice currentDevice].uniqueDeviceIdentifier,
                                   @"version"   : version
                                   };
    NSMutableDictionary *signDic = [NSMutableDictionary dictionaryWithDictionary:commnSignDic];
    for (int i = 0; i<dic.allKeys.count; i++) {
        NSString * key = dic.allKeys[i];
        id value = dic[key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString * valueStr = (NSString *)value;
            if (valueStr.length>0) {
                [signDic setValue:valueStr forKey:key];
            }
        }else{
            [signDic setValue:value forKey:key];
        }
    }
    NSMutableString *sign = [NSMutableString stringWithString:[signDic AIF_urlParamsStringSignature:YES]];
    [sign appendString:BER_APP_KEY];
    NSString * signstr = [sign stringFromMD5];
    [signDic setObject:signstr forKey:@"sign"];
    return signDic;
}



@end
