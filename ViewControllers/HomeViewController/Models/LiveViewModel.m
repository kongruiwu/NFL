//
//  LiveViewModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LiveViewModel.h"

@implementation LiveViewModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"play_by_play"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            LiveModel * model = [[LiveModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.play_by_play = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end
