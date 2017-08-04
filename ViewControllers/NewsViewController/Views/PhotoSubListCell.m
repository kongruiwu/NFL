//
//  PhotoSubListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/29.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoSubListCell.h"

@implementation PhotoSubListView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    
    self.topImg = [Factory creatImageViewWithImage:@"list_img_Journalism1"];
    
    self.grayView = [Factory creatViewWithColor:UIColorFromRGBA(0x000000, 0.5)];
    
    self.nameLabel = [Factory creatLabelWithText:@"詹姆斯-考瑟:\n在中国做着很酷的事"
                                       fontValue:font750(36)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentCenter];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:font750(36)];
    self.nameLabel.numberOfLines = 0;
    
    self.countLabel = [Factory creatLabelWithText:@"15张"
                                        fontValue:font750(20)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    self.countLabel.layer.cornerRadius = Anno750(20);
    
    self.whiteView = [Factory creatViewWithColor:[UIColor whiteColor]];
    
    self.timelabel = [Factory creatLabelWithText:@"06月13日  12:25"
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentLeft];
    self.likeBtn = [LikeButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:self.topImg];
    [self addSubview:self.grayView];
    [self.grayView addSubview:self.nameLabel];
    [self.grayView addSubview:self.countLabel];
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.timelabel];
    [self.whiteView addSubview:self.likeBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(Anno750(365)));
        make.height.equalTo(@(Anno750(365)));
    }];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(Anno750(365)));
        make.height.equalTo(@(Anno750(365)));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@0);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(10)));
        make.bottom.equalTo(@(Anno750(-10)));
        make.width.equalTo(@(Anno750(68)));
        make.height.equalTo(@(Anno750(40)));
    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(Anno750(66)));
        make.top.equalTo(self.topImg.mas_bottom);
    }];
    
    [self.timelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
}

@end

@implementation PhotoSubListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = Color_BackGround;
    self.leftView = [[PhotoSubListView alloc]initWithFrame:CGRectMake(0, 0, Anno750(365), Anno750(430))];
    self.rightView = [[PhotoSubListView alloc]initWithFrame:CGRectMake(Anno750(385), 0, Anno750(365), Anno750(430))];
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
}


@end
