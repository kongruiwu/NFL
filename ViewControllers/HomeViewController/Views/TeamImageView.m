//
//  TeamImageView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamImageView.h"

@implementation TeamImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)creatUI{
    self.teamImg = [Factory creatImageViewWithImage:@""];
    
}

@end
