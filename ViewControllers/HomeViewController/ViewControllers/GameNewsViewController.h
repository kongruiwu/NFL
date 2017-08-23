//
//  GameNewsViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameBassViewController.h"
#import "SubNewsListCell.h"

@interface GameNewsViewController : GameBassViewController
@property (nonatomic, strong) NSArray<InfoListModel *> * dataArray;
@end
