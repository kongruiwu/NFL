//
//  AttentionTeamHeader.m
//  NFL
//
//  Created by 吴孔锐 on 2017/7/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "AttentionTeamHeader.h"
#import "SmallTeamCell.h"
@implementation AttentionTeamHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.groundImg = [Factory creatImageViewWithImage:@"nav_bg_default"];
    self.addBtn = [Factory creatButtonWithNormalImage:@"nav_button_add_white" selectImage:nil];    
    
    [self addSubview:self.groundImg];
    [self addSubview:self.addBtn];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, Anno750(24), 0, Anno750(24));
    layout.itemSize =CGSizeMake(Anno750(80), Anno750(80));
    layout.minimumLineSpacing = Anno750(40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(Anno750(110+16), self.frame.size.height - Anno750(80), UI_WIDTH, Anno750(80)) collectionViewLayout:layout];
    self.collectView.backgroundColor = [UIColor clearColor];
    
    [self.collectView registerClass:[SmallTeamCell class] forCellWithReuseIdentifier:@"SmallTeamCell"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.groundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(30)));
        make.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(80)));
        make.width.equalTo(@(Anno750(80)));
    }];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addBtn.mas_right).offset(Anno750(16));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(UI_WIDTH - Anno750(126)));
        make.height.equalTo(@(Anno750(80)));
    }];
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SmallTeamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallTeamCell" forIndexPath:indexPath];
    HomeTeam * team = self.dataArray[indexPath.row];
    cell.teamImg.image = [Factory getImageWithNumer:team.team_id white:YES];
    return cell;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.collectView reloadData];
}
@end
