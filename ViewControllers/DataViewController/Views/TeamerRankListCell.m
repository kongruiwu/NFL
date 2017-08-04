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
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
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
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TeamerRankCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamerRankCollectionViewCell" forIndexPath:indexPath];
//    [cell configUIwithUrls:self.skuurls[indexPath.row]];
    return cell;
}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(@0);
//    }];
//}
@end
