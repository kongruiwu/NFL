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
    
    self.topImg = [Factory creatImageViewWithImage:@"plac_holderZ"];
    
    self.topImg.contentMode = UIViewContentModeScaleAspectFill;
    self.topImg.clipsToBounds = YES;
    
    self.grayView = [Factory creatViewWithColor:UIColorFromRGBA(0x000000, 0.3)];
    
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
    self.countLabel.backgroundColor = UIColorFromRGBA(0x000000, 0.7);
    self.countLabel.layer.cornerRadius = Anno750(20);
    self.countLabel.layer.masksToBounds = YES;
    
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
        make.centerY.equalTo(@0);
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
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
        make.height.equalTo(@(Anno750(50)));
        make.width.equalTo(@(Anno750(100)));
    }];
    
}

- (void)updateWithPhotoListModel:(InfoListModel *)model{
    if ([UserManager manager].hasPic) {
        [self.topImg sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"plac_holderZ"]];
    }
    self.nameLabel.text = model.title;
    self.timelabel.text = model.time;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.collect_num] forState:UIControlStateNormal];
    self.countLabel.text = [NSString stringWithFormat:@"%@张",model.num];
    self.likeBtn.selected = model.collected;
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
    self.leftButton = [Factory creatButtonWithNormalImage:@"" selectImage:@""];
    self.rightButton =[Factory creatButtonWithNormalImage:@"" selectImage:@""];
    
    self.leftView.likeBtn.tag = 1;
    self.rightView.likeBtn.tag = 2;
    [self.leftView.likeBtn addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.likeBtn addTarget:self action:@selector(likeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.leftButton.frame = CGRectMake(0, 0, Anno750(365), Anno750(365));
    self.rightButton.frame = CGRectMake(Anno750(385), 0, Anno750(365), Anno750(365));
    
    [self.leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
}

- (void)leftButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(checkLeftPhotos:)]) {
        [self.delegate checkLeftPhotos:btn];
    }
}
- (void)rightButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(checkRightPhotos:)]) {
        [self.delegate checkRightPhotos:btn];
    }
}
- (void)likeButtonClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(collectThisPictures:)]) {
        [self.delegate collectThisPictures:btn];
    }
}

- (void)updateWithLeftModel:(InfoListModel *)leftm rightModel:(id)rightm{
    [self.leftView updateWithPhotoListModel:leftm];
    if (rightm) {
        self.rightView.hidden = NO;
        InfoListModel * model = (InfoListModel *)rightm;
        [self.rightView updateWithPhotoListModel:model];
    }else{
        self.rightView.hidden = YES;
    }
}
@end
