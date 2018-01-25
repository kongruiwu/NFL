//
//  RootViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, StarType){
    StarTypeHome = 0,
    StarTypeNews    ,
    StarTypeVideo   ,
    StarTypeData    ,
    StarTypeMore
};
@interface RootViewController : UITabBarController

@property (nonatomic, assign) StarType starType;

@end
