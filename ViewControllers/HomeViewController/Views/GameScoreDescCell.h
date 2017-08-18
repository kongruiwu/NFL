//
//  GameScoreDescCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface GameScoreDescCell : UITableViewCell

@property (nonatomic, strong) UIImageView * leftImg;
@property (nonatomic, strong) NSMutableArray * lines;
@property (nonatomic, strong) NSMutableArray * labels;
@property (nonatomic, strong) UIView * topLine;

- (void)updateWithTitles:(NSArray *)titles TeamId:(NSNumber *)teamid;

@end
