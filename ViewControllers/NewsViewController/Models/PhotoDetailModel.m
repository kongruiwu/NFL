//
//  PhotoDetailModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailModel.h"

@implementation PhotoModel



@end

@implementation PhotoDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"list"];
        NSMutableArray * images = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            PhotoModel * model = [[PhotoModel alloc]initWithDictionary:arr[i]];
            [images addObject:model];
        }
        self.list = [NSArray arrayWithArray:images];
    }
    return self;
}

@end
