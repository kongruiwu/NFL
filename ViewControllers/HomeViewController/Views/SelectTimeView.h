//
//  SelectTimeView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import "TimeListModel.h"

@protocol SelectTimeViewDelegate <NSObject>

- (void)selectTimeSection:(TimeListModel *)model;

@end

@interface SelectTimeView : UIView<UITableViewDelegate,UITableViewDataSource>
/**日程数据*/
@property (nonatomic, strong) NSMutableArray * dateArray;

@property (nonatomic, strong) UIButton * cannceBtn;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UIButton * cannceImg;
@property (nonatomic, strong) UIView * showView;
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic) NSInteger defaultWeek;
@property (nonatomic, assign) id<SelectTimeViewDelegate> delegate;
/**是否是球队界面的时间*/
@property (nonatomic) BOOL isTeam;
- (void)show;
- (void)disMiss;
- (instancetype)initWithFrame:(CGRect)frame isTeam:(BOOL)rec defaultWeek:(NSInteger)index;
@end
