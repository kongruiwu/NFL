//
//  AttentionTeamHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface AttentionTeamHeader : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView * groundImg;
@property (nonatomic, strong) UIButton * addBtn;

@property (nonatomic, strong) UICollectionView * collectView;

@property (nonatomic, strong) NSArray * dataArray;
@end
