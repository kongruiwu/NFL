//
//  HomeInfoModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeInfoModel.h"

@implementation InfoParams



@end

@implementation HomeInfoModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            if (dic[@"pre"]) {
                self.pre = [[InfoParams alloc]initWithDictionary:dic[@"pre"]];
            }
            if (dic[@"index"]) {
                self.index = [[InfoParams alloc]initWithDictionary:dic[@"index"]];
            }
            if (dic[@"next"]) {
                self.next = [[InfoParams alloc]initWithDictionary:dic[@"next"]];
            }
        }
    }
    return self;
}


@end
