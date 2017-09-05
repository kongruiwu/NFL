//
//  GameSegmentView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameSegmentView.h"

@implementation GameSegmentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUIWithTitles:titles];
    }
    return self;
}
- (void)creatUIWithTitles:(NSArray *)titles{
    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.segmentView = [[HMSegmentedControl alloc]initWithSectionTitles:titles];
    self.segmentView.backgroundColor = [UIColor clearColor];
    
    self.segmentView.titleTextAttributes = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                             NSForegroundColorAttributeName : Color_White_5};
    self.segmentView.selectedTitleTextAttributes = @{
                                                     NSFontAttributeName : [UIFont systemFontOfSize:font750(28)],
                                                     NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    self.segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView.selectionIndicatorHeight = Anno750(6);
    self.segmentView.selectionIndicatorColor = Color_HsmRed;
    
    self.groundImg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.segmentView.frame = CGRectMake(0, 64, self.frame.size.width, self.frame.size.height - 64);
    
    [self addSubview:self.groundImg];
    [self addSubview:self.segmentView];
    
    self.leftImg = [Factory creatImageViewWithImage:@"list_logo_60x60_49ren"];
    self.rightImg = [Factory creatImageViewWithImage:@"list_logo_60x60_aiguozhe"];
    self.leftScore = [Factory creatLabelWithText:@"13"
                                     fontValue:font750(48)
                                     textColor:[UIColor whiteColor]
                                 textAlignment:NSTextAlignmentCenter];
    self.rightScore = [Factory creatLabelWithText:@"21"
                                        fontValue:font750(48)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    
    self.lineView = [Factory creatLineView];
    
    self.leftImg.frame = CGRectMake(Anno750(85 *2), 20 + Anno750(4), Anno750(80), Anno750(80));
    self.rightImg.frame = CGRectMake(UI_WIDTH - Anno750(80) - Anno750(85 *2), 20+ Anno750(4), Anno750(80), Anno750(80));
    self.leftScore.frame = CGRectMake(Anno750(85 * 2)+ Anno750(80) + Anno750(40), 20 + Anno750(12), Anno750(60), Anno750(60));
    self.rightScore.frame = CGRectMake(UI_WIDTH - Anno750(60) -Anno750(85 * 2)- Anno750(80) - Anno750(40) , 20 + Anno750(12), Anno750(60), Anno750(60));
    
    [self addSubview:self.leftImg];
    [self addSubview:self.rightImg];
    [self addSubview:self.leftScore];
    [self addSubview:self.rightScore];
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@((20 + Anno750(88 - 6)/2)));
        make.height.equalTo(@(Anno750(6)));
        make.width.equalTo(@(Anno750(18)));
    }];
}
- (void)updateWithMatchLiveViewModel:(LiveViewModel *)model{
    self.leftScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
    self.rightScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
    self.leftImg.image = [Factory getImageWithNumer:model.visitor_teamId white:NO];
    self.rightImg.image =[Factory getImageWithNumer:model.home_teamId white:NO];
    switch ([model.match_state intValue]) {
        case 0://未开始
        {
            self.leftScore.text = @"";
            self.rightScore.text = @"";
        }
            break;
        case 1://正在进行
        case 2://已结束
        {
            self.leftScore.text = [NSString stringWithFormat:@"%@",model.visitor_scores];
            self.rightScore.text = [NSString stringWithFormat:@"%@",model.home_scores];
            if ([model.home_scores intValue] > [model.visitor_scores intValue]) {
                self.leftScore.textColor = Color_White_5;
            }else if([model.home_scores intValue] < [model.visitor_scores intValue]){
                self.rightScore.textColor = Color_White_5;
            }
        }
            break;
        default:
            break;
    }
    if (model.page_list.count>= 3) {
        self.segmentView.sectionTitles = @[model.page_list[0].title,model.page_list[1].title,model.page_list[2].title];
    }
}

@end
