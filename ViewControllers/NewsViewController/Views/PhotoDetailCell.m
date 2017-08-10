//
//  PhotoDetailCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailCell.h"

@implementation PhotoDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.photoView = [[PhotoScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.photoView];
    
    UITapGestureRecognizer * doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
}

- (void)doubleTapAction{
    [self.photoView doubleTapAction];
}


- (void)updateWithPic:(NSString *)pic{
    [self.photoView updateImageviewWithurl:pic];
}

@end
