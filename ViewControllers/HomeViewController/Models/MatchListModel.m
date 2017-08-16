//
//  MatchListModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "MatchListModel.h"

@implementation MatchListModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        NSArray * arr = dic[@"list"];
        NSMutableArray * muarr = [NSMutableArray new];
        for (int i = 0; i<arr.count; i++) {
            MatchDetailModel * model = [[MatchDetailModel alloc]initWithDictionary:arr[i]];
            [muarr addObject:model];
        }
        self.list = [NSArray arrayWithArray:muarr];
    }
    return self;
}

@end
