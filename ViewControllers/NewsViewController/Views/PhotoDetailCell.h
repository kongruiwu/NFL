//
//  PhotoDetailCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoScrollView.h"
@interface PhotoDetailCell : UICollectionViewCell

@property (nonatomic, strong) PhotoScrollView * photoView;


- (void)updateWithPic:(NSString *)pic;
@end
