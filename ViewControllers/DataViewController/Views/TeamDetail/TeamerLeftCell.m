//
//  TeamerLeftCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/15.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerLeftCell.h"

@implementation TeamerLeftCell

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
        [self creatNewUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)creatNewUI{
    self.addressLabel = [Factory creatLabelWithText:@"位置"
                                          fontValue:font750(24)
                                          textColor:Color_MainBlack
                                      textAlignment:NSTextAlignmentCenter];
    self.addressLabel.backgroundColor = Color_Line;
    self.fristLabel = [Factory creatLabelWithText:@"首发"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlue
                                    textAlignment:NSTextAlignmentCenter];
    self.line1 = [Factory creatLineView];
    self.line2 = [Factory creatLineView];
    self.line2.backgroundColor = UIColorFromRGBA(0x999999, 0.5);
    
    [self addSubview:self.addressLabel];
    [self addSubview:self.fristLabel];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@1);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(self.line1.mas_left);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.fristLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1.mas_right);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@1);
    }];
}
- (void)updateWithPlayerLineUpModel:(PlayerLineUpModel *)model{
    self.addressLabel.text = model.position;
    self.fristLabel.text = model.first;
}

- (void)creatUI{
    self.addressLabel = [Factory creatLabelWithText:@"位置"
                                          fontValue:font750(24)
                                          textColor:Color_MainBlack
                                      textAlignment:NSTextAlignmentCenter];
    self.addressLabel.backgroundColor = Color_BackGround;
    self.fristLabel = [Factory creatLabelWithText:@"    首发"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlue
                                    textAlignment:NSTextAlignmentLeft];
    self.otherLabel = [Factory creatLabelWithText:@"asdadead"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlack
                                    textAlignment:NSTextAlignmentLeft];
    self.otherLabel1 = [Factory creatLabelWithText:@"defngnde"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlack
                                    textAlignment:NSTextAlignmentLeft];
    self.otherLabel2 = [Factory creatLabelWithText:@"addenden"
                                        fontValue:font750(24)
                                        textColor:Color_MainBlack
                                    textAlignment:NSTextAlignmentLeft];
    self.otherLabel3 = [Factory creatLabelWithText:@"232321"
                                         fontValue:font750(24)
                                         textColor:Color_MainBlack
                                     textAlignment:NSTextAlignmentLeft];
    self.otherLabel4 = [Factory creatLabelWithText:@"232321"
                                         fontValue:font750(24)
                                         textColor:Color_MainBlack
                                     textAlignment:NSTextAlignmentLeft];
    
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(Anno750(310), 0, UI_WIDTH - Anno750(310), Anno750(60))];
    float w = Anno750(750 - 310 - 60)/2;
    self.scrollview.contentSize = CGSizeMake(5 * w + 6 * Anno750(15), 0);
    self.scrollview.showsVerticalScrollIndicator = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    
    
    self.line1 = [Factory creatLineView];
    self.line2 = [Factory creatLineView];
    
    [self addSubview:self.addressLabel];
    [self addSubview:self.line1];
    [self addSubview:self.fristLabel];
    [self addSubview:self.line2];
    [self addSubview:self.scrollview];
    [self.scrollview addSubview:self.otherLabel];
    [self.scrollview addSubview:self.otherLabel1];
    [self.scrollview addSubview:self.otherLabel2];
    [self.scrollview addSubview:self.otherLabel3];
    [self.scrollview addSubview:self.otherLabel4];
    
    
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(64 * 2)));
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressLabel.mas_right);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@1);
    }];
    [self.fristLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(180)));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fristLabel.mas_right);
        make.top.equalTo(@0);
        make.width.equalTo(@1);
        make.bottom.equalTo(@0);
    }];
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(15)));
        make.width.equalTo(@(w));
        make.centerY.equalTo(@0);
    }];
    [self.otherLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherLabel.mas_right).offset(Anno750(15));
        make.width.equalTo(@(w));
        make.centerY.equalTo(@0);
    }];
    [self.otherLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherLabel1.mas_right).offset(Anno750(15));
        make.width.equalTo(@(w));
        make.centerY.equalTo(@0);
    }];
    [self.otherLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherLabel2.mas_right).offset(Anno750(15));
        make.width.equalTo(@(w));
        make.centerY.equalTo(@0);
    }];
    [self.otherLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherLabel3.mas_right).offset(Anno750(15));
        make.width.equalTo(@(w));
        make.centerY.equalTo(@0);
    }];
}

- (void)updateWithPlayerLineUpModel:(PlayerLineUpModel *)model contentoffX:(CGFloat)contentoffX{
    self.addressLabel.text = model.position;
    self.fristLabel.text = [NSString stringWithFormat:@"    %@",model.first];
    self.scrollview.contentOffset = CGPointMake(contentoffX, 0);
    self.otherLabel.text = @"";
    self.otherLabel1.text = @"";
    self.otherLabel2.text = @"";
    self.otherLabel3.text = @"";
    self.otherLabel4.text = @"";
    
    for (int i = 0; i<model.alternates.count; i++) {
        if (i == 0) {
            self.otherLabel.text = model.alternates[i];
        }else if(i == 1){
            self.otherLabel1.text = model.alternates[i];
        }else if(i == 2){
            self.otherLabel2.text = model.alternates[i];
        }else if(i == 3){
            self.otherLabel3.text = model.alternates[i];
        }else if(i == 4){
            self.otherLabel3.text = model.alternates[i];
            return;
        }
    }
}

@end
