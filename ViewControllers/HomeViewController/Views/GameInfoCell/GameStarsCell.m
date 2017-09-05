//
//  GameStarsCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/18.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "GameStarsCell.h"

@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{

    self.userIcon = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.userIcon.layer.cornerRadius = Anno750(80);
    self.userIcon.layer.masksToBounds = YES;
    self.nameLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(24)
                                       textColor:Color_MainBlue
                                   textAlignment:NSTextAlignmentCenter];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:font750(24)];
    self.scorekey = [Factory creatLabelWithText:@""
                                        fontValue:font750(24)
                                        textColor:Color_LightGray
                                    textAlignment:NSTextAlignmentRight];
    self.desckey = [Factory creatLabelWithText:@""
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentRight];
    self.scorevalue = [Factory creatLabelWithText:@""
                                        fontValue:font750(24)
                                        textColor:Color_MainRed textAlignment:NSTextAlignmentLeft];
    self.descvalue = [Factory creatLabelWithText:@""
                                       fontValue:font750(24)
                                       textColor:Color_MainRed
                                   textAlignment:NSTextAlignmentLeft];
    
    [self addSubview:self.userIcon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.scorekey];
    [self addSubview:self.desckey];
    [self addSubview:self.scorevalue];
    [self addSubview:self.descvalue];
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(40)));
        make.width.equalTo(@(Anno750(160)));
        make.height.equalTo(@(Anno750(160)));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userIcon.mas_bottom).offset(Anno750(24));
        make.centerX.equalTo(@0);
    }];
    [self.scorekey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(Anno750(20));
        make.right.equalTo(@(Anno750(-160)));
    }];
    [self.desckey mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scorekey.mas_bottom).offset(Anno750(5));
        make.right.equalTo(@(Anno750(-160)));
    }];
    [self.scorevalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.scorekey.mas_centerY);
        make.left.equalTo(self.scorekey.mas_right);
    }];
    [self.descvalue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.desckey.mas_centerY);
        make.left.equalTo(self.desckey.mas_right);
    }];
}
- (void)updateWithStarDetailModel:(StarDetailModel *)model{
    if ([UserManager manager].hasPic) {
        [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    }
    self.nameLabel.text = model.name;
    if (model.data_list.count>0) {
       self.scorekey.text = [NSString stringWithFormat:@"%@：",model.data_list[0].key];
        self.scorevalue.text = model.data_list[0].value;
        if (model.data_list.count>1) {
            self.desckey.text = [NSString stringWithFormat:@"%@：",model.data_list[1].key];
            self.descvalue.text = model.data_list[1].value;
        }
    }
    
    
}


@end

@implementation GameStarsCell

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
    self.homeView = [[StarView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH/2, self.frame.size.height)];
    self.visitorView = [[StarView alloc]initWithFrame:CGRectMake(UI_WIDTH/2, 0, UI_WIDTH/2, self.frame.size.height)];
    UIView * line = [Factory creatLineView];
    
    [self addSubview:line];
    [self addSubview:self.homeView];
    [self addSubview:self.visitorView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@0.5);
    }];
}
- (void)updateWithArray:(StarModel *)star{
    [self.homeView updateWithStarDetailModel:star.visitor];
    [self.visitorView updateWithStarDetailModel:star.home];
}
@end
