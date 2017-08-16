//
//  LiveModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LiveModel.h"

@implementation LiveDetailModel



@end

@implementation LiveModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"list"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i =0; i<arr.count; i++) {
            LiveDetailModel * model = [[LiveDetailModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.list = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end
