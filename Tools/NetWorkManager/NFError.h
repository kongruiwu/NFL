//
//  NFError.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFError : NSObject
@property (nonatomic, strong) NSString * errorCode;
@property (nonatomic, strong) NSString * errorMessage;
@end
