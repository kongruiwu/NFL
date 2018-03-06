//
//  FollowedTeamCell.m
//  NFL
//
//  Created by 吴孔锐 on 2017/8/17.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "FollowedTeamCell.h"
#import "SmallTeamCell.h"
@implementation FollowedTeamCell

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
    layout.itemSize =CGSizeMake(Anno750(80), Anno750(80));
    layout.minimumLineSpacing = Anno750(40);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, Anno750(20), UI_WIDTH, Anno750(80)) collectionViewLayout:layout];
    
    [self.collectView registerClass:[SmallTeamCell class] forCellWithReuseIdentifier:@"SmallTeamCell"];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    self.collectView.showsVerticalScrollIndicator = NO;
    self.collectView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.collectView];
    
    
    self.descLabel = [Factory creatLabelWithText:@"您还未关注球队\n点击球队logo可直接关注，再次点击可以取消"
                                       fontValue:font750(24)
                                       textColor:Color_LightGray
                                   textAlignment:NSTextAlignmentCenter];
    self.descLabel.numberOfLines = 0;
    self.descLabel.backgroundColor = [UIColor whiteColor];
    self.descLabel.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(120));
    [self.contentView addSubview:self.descLabel];
    
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SmallTeamCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallTeamCell" forIndexPath:indexPath];
    HomeTeam * team = self.dataArray[indexPath.row];
    if (self.isWhite) {
        cell.selectImg.image = [UIImage imageNamed:@"list_button_60x60_sel"];
    }else{
        cell.selectImg.image = [UIImage imageNamed:@"list_button_select_white"];
    }
    cell.teamImg.image = [Factory getImageWithNumer:team.team_id white:YES];
    return cell;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    self.descLabel.hidden = dataArray.count == 0 ? NO : YES;
    [self.collectView reloadData];
}
@end
