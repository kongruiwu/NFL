//
//  SelectTopView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HMSegmentedControl.h>
#import "ConfigHeader.h"
@interface SelectTopView : UIView

@property (nonatomic, strong) HMSegmentedControl * segmentView;
@property (nonatomic, strong) UIImageView * groundImg;

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

@end
