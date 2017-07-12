//
//  GameSegmentView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HMSegmentedControl.h>
#import "ConfigHeader.h"
@interface GameSegmentView : UIView

@property (nonatomic, strong) HMSegmentedControl * segmentView;
@property (nonatomic, strong) UIImageView * groundImg;

@end
