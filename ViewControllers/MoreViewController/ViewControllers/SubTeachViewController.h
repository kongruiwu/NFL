//
//  SubTeachViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/22.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, TeachType) {
    TeachTypeRule = 0 ,     //规则
    TeachTypeStars = 1,     //球星
    TeachTypeSuperBowl      //超级碗
};

@interface SubTeachViewController : BaseViewController

@property (nonatomic, assign) TeachType teachType;

@end
