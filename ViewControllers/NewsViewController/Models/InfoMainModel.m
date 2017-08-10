//
//  InfoMainModel.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/8.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "InfoMainModel.h"

@implementation InfoCoverModel


@end

@implementation InfoMainModel

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        if (!self.coverModel) {
            NSArray * arr = dic[@"cover"];
            if (arr.count > 0) {
                self.coverModel = [[InfoCoverModel alloc]initWithDictionary:arr[0]];
            }
        }
        NSMutableArray * datas = [NSMutableArray new];
        NSArray * list = dic[@"list"];
        for (int i = 0; i<list.count; i++) {
            InfoListModel * model = [[InfoListModel alloc]initWithDictionary:list[i]];
            [datas addObject:model];
        }
        self.list = [NSMutableArray arrayWithArray:datas];
    }
    return self;
}


@end
