//
//  SelectTimeView.h
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
@interface SelectTimeView : UIView<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UIButton * cannceBtn;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UIButton * cannceImg;
@property (nonatomic, strong) UIView * showView;
@property (nonatomic, strong) UITableView * tabview;
- (void)show;
- (void)disMiss;
@end
