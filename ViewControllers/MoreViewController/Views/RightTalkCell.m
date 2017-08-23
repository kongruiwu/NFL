//
//  RightTalkCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/1.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RightTalkCell.h"

@implementation RightTalkCell

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
    
    self.rightImg = [Factory creatImageViewWithImage:@"list_img_user_normal"];
    self.rightImg.layer.cornerRadius = Anno750(36);
    self.rightImg.layer.masksToBounds = YES;
    
    UIImage * image = [UIImage imageNamed:@"content_blue"];
    UIEdgeInsets insets = UIEdgeInsetsMake(Anno750(45), 10, 10, 10);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    self.bgImg = [[UIImageView alloc]initWithImage:image];
    self.contentLabel = [Factory creatLabelWithText:@""
                                          fontValue:font750(28)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentLeft];
    self.contentLabel.numberOfLines = 0;
    
    self.contentLabel.frame = CGRectMake(Anno750(24+72+15+24), Anno750(15), Anno750(750 - 270), Anno750(30));
    self.bgImg.frame = CGRectMake(Anno750(24 + 72), 0, Anno750(100), Anno750(72));
    [self addSubview:self.rightImg];
    [self addSubview:self.bgImg];
    [self.bgImg addSubview:self.contentLabel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(Anno750(-24)));
        make.top.equalTo(@0);
        make.width.equalTo(@(Anno750(72)));
        make.height.equalTo(@(Anno750(72)));
    }];
}

- (void)updateWithOnlineAnswerModel:(OnlineAnswerModel *)model{
    NSString * text = model.content;
    CGSize size = [Factory getSize:text maxSize:CGSizeMake(99999, Anno750(30)) font:[UIFont systemFontOfSize:font750(28)]];
    size.width = size.width >= Anno750(750 - 270) ? Anno750(750 - 270) : size.width;
    if (size.width >= Anno750(750 - 270)) {
        size = [Factory getSize:text maxSize:CGSizeMake(Anno750(750 - 270), 9999) font:[UIFont systemFontOfSize:font750(28)]];
    }
    float h = (size.height + Anno750(30)) >= Anno750(72) ? (size.height + Anno750(30)) : Anno750(72);
    self.bgImg.frame = CGRectMake( UI_WIDTH - Anno750(24 + 72 + 15 + 48) - size.width, 0, size.width + Anno750(48), h);
    self.contentLabel.frame = CGRectMake(Anno750(16),(self.bgImg.frame.size.height - size.height)/2, size.width, size.height);
    self.contentLabel.text = text;
    
    if ([UserManager manager].hasPic) {
        [self.rightImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    }
}

@end
