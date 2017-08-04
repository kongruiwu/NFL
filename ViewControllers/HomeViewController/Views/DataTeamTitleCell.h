//
//  DataTeamTitleCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface DataTeamTitleCell : UITableViewCell

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) NSMutableArray * labels;
- (void)updateWithtitles:(NSArray *)titles isTitle:(BOOL)rec;
@end
