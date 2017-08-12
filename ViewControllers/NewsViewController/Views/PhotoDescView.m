//
//  PhotoDescView.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDescView.h"

@implementation PhotoDescView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = UIColorFromRGBA(0x000000, 0.7);
    self.countLabel = [Factory creatLabelWithText:@""
                                        fontValue:font750(24)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentLeft];
    self.titleLabel = [Factory creatLabelWithText:@""
                                        fontValue:font750(32)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentLeft];
    self.descLabel = [Factory creatLabelWithText:@""
                                       fontValue:font750(24)
                                       textColor:[UIColor whiteColor]
                                   textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 0;
    self.likeBtn = [LikeButton buttonWithType:UIButtonTypeCustom];
    [self.likeBtn setImage:[UIImage imageNamed:@"nav_icon_collection_normal"] forState:UIControlStateNormal];
    [self addSubview:self.countLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.descLabel];
    [self addSubview:self.likeBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(30)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(100)));
        make.top.equalTo(@(Anno750(30)));
        make.right.equalTo(@(-Anno750(150)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(20));
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.bottom.equalTo(self.titleLabel.mas_bottom);
    }];
}
- (void)updateWithPhotoDetail:(PhotoDetailModel *)model withIndex:(int)index{
    NSString * title = [NSString stringWithFormat:@"%@",model.album_title];
    self.titleLabel.text = title;
    NSString * count = [NSString stringWithFormat:@"%d",index+1];
    NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@/%@",count,model.photo_num]];
    [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font750(32)] range:NSMakeRange(0, count.length)];
    self.countLabel.attributedText = attstr;
    self.descLabel.text = model.list[index].title;
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%@",model.collect_num] forState:UIControlStateNormal];
}
@end
