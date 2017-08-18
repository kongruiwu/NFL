//
//  TeamDataCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamDataView.h"
@interface TeamDataCell : UITableViewCell

@property (nonatomic, strong) TeamDataView * dataView;

- (void)updateWithTeamDataInfoModel:(TeamDataInfoModel *)model;

@end
