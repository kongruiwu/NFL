//
//  TeamerRankListCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerRankListCell.h"
#import "TeamerRankCollectionViewCell.h"
@implementation TeamerRankListCell

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
    self.rankLabel = [Factory creatLabelWithText:@"1"
                                       fontValue:font750(30)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.teamerIcon = [Factory creatImageViewWithImage:@""];
    self.teamerIcon.layer.cornerRadius = Anno750(40);
    self.teamerIcon.layer.masksToBounds = YES;
    self.userName = [Factory creatLabelWithText:@""
                                      fontValue:font750(26)
                                      textColor:Color_MainBlack
                                  textAlignment:NSTextAlignmentLeft];
    self.teamName = [Factory creatLabelWithText:@""
                                      fontValue:font750(24)
                                      textColor:Color_LightGray
                                  textAlignment:NSTextAlignmentLeft];
    self.passLabel = [Factory creatLabelWithText:@"25"
                                       fontValue:font750(30)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.arriveLabel = [Factory creatLabelWithText:@"8"
                                         fontValue:font750(30)
                                         textColor:Color_MainBlack
                                     textAlignment:NSTextAlignmentCenter];
    self.stopLabel = [Factory creatLabelWithText:@"3"
                                       fontValue:font750(30)
                                       textColor:Color_MainBlack
                                   textAlignment:NSTextAlignmentCenter];
    self.line = [Factory creatLineView];
    
    [self addSubview:self.rankLabel];
    [self addSubview:self.teamerIcon];
    [self addSubview:self.userName];
    [self addSubview:self.teamName];
    [self addSubview:self.passLabel];
    [self addSubview:self.arriveLabel];
    [self addSubview:self.stopLabel];
    [self addSubview:self.line];
    
    //40  90 310  90 * 3 40
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.width.equalTo(@(Anno750(90)));
        make.centerY.equalTo(@0);
    }];
    [self.teamerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankLabel.mas_right).offset(Anno750(15));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(80)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [self.stopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.width.equalTo(@(Anno750(130)));
        make.centerY.equalTo(@0);
    }];
    [self.arriveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.stopLabel.mas_left);
        make.width.equalTo(@(Anno750(90)));
        make.centerY.equalTo(@0);
    }];
    [self.passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arriveLabel.mas_left);
        make.width.equalTo(@(Anno750(90)));
        make.centerY.equalTo(@0);
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.teamerIcon.mas_right).offset(Anno750(10));
        make.right.equalTo(self.passLabel.mas_left).offset(Anno750(-15));
        make.bottom.equalTo(self.mas_centerY).offset(Anno750(-4));
    }];
    [self.teamName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_left);
        make.right.equalTo(self.userName.mas_right);
        make.top.equalTo(self.mas_centerY).offset(Anno750(4));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(40)));
        make.right.equalTo(@(-Anno750(40)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}

- (void)updateWithRankPlayer:(RankPlayer *)player{
    self.rankLabel.text = [NSString stringWithFormat:@"%@",player.idx];
    self.userName.text = player.name;
    if ([UserManager manager].hasPic) {
        [self.teamerIcon sd_setImageWithURL:[NSURL URLWithString:player.avatar] placeholderImage:[UIImage imageNamed:@"list_img_user_normal"]];
    }
    self.teamName.text = player.team_name;
    self.passLabel.text = player.stats1;
    self.arriveLabel.text = player.stats2;
    self.stopLabel.text = player.stats3;
}

- (void)creatUI{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, Anno750(24), 0, Anno750(24));
    layout.itemSize =CGSizeMake(Anno750(200), Anno750(220));
    layout.minimumLineSpacing = Anno750(0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(220)) collectionViewLayout:layout];
    
    [self.collectView registerClass:[TeamerRankCollectionViewCell class] forCellWithReuseIdentifier:@"TeamerRankCollectionViewCell"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.showsHorizontalScrollIndicator = NO;
    
    [self.contentView addSubview:self.collectView];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeamerRankCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamerRankCollectionViewCell" forIndexPath:indexPath];
    [cell updateWithRankPlayer:self.dataArray[indexPath.row]];
    return cell;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.collectView reloadData];
}
@end
