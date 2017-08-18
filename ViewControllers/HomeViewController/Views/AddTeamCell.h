//
//  AddTeamCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamImageView.h"
#import "TeamModel.h"

@protocol AddTeamCellDelegate <NSObject>

- (void)selectTeamAtIndex:(NSInteger)index Button:(UIButton *)btn;

@end

@interface AddTeamCell : UITableViewCell

@property (nonatomic, strong) TeamImageView * teamOne;
@property (nonatomic, strong) TeamImageView * teamTwo;
@property (nonatomic, strong) TeamImageView * teamThree;
@property (nonatomic, strong) TeamImageView * teamFour;
@property (nonatomic, assign) id<AddTeamCellDelegate> delegate;
- (void)updateWithArray:(NSArray *)arr;
/**是否需要显示 被关注状态*/
- (void)updateWithArray:(NSArray *)arr NeedSelect:(BOOL)rec;
@end
