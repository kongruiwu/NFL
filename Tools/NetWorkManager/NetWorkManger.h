//
//  NetWorkManger.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "API.h"
#import "NFError.h"
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
typedef void(^ CompleteBlock)(NSDictionary * result);
typedef void(^ ErrorBlock)(NFError *byerror);
@interface NetWorkManger : NSObject
+ (instancetype)manager;
- (void)sendRequest:(NSString *)action route:(NSString *)route withParams:(NSDictionary *)dataDic complete:(CompleteBlock)complete error:(ErrorBlock)byerror;
- (void)postRequest:(NSString *)action route:(NSString *)route withParams:(NSDictionary *)dataDic complete:(CompleteBlock)complete error:(ErrorBlock)byerror;
@end
