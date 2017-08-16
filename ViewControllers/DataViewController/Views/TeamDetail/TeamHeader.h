//
//  TeamHeader.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"


@interface TeamLeftSection : UIView

@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UILabel * fristLabel;
@property (nonatomic, strong) UILabel * otherLabel;
@property (nonatomic, strong) UIView * line1;
@property (nonatomic, strong) UIView * line2;

@end

@interface TeamRightSection : UIView

@property (nonatomic, strong) UILabel * numlabel;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * addressLabel;
@property (nonatomic, strong) UIView * line1;
@property (nonatomic, strong) UIView * line2;

@end


@interface TeamHeader : UIView

@property (nonatomic, strong) UISegmentedControl * segmentbtn;

@property (nonatomic, strong) TeamLeftSection * leftSection;
@property (nonatomic, strong) TeamRightSection * rightSection;

@end
