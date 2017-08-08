//
//  VideoDetailModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoDetailModel.h"

@implementation VideoDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSMutableArray * videos = [NSMutableArray new];
        NSArray * arr = dic[@"recommend_list"];
        for (int i = 0; i<arr.count; i++) {
            VideoListModel * model = [[VideoListModel alloc]initWithDictionary:arr[i]];
            [videos addObject:model];
        }
        self.recommend_list = [NSArray arrayWithArray:videos];
    }
    return self;
}

@end
