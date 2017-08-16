//
//  VideoPlayCell.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/12.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeButton.h"
#import "VideoListModel.h"
#define VideoPlayCellHeigh  Anno750(275 * 2)
/**
 * The style of cell cannot stop in screen center.
 * 播放滑动不可及cell的类型
 */
typedef NS_OPTIONS(NSInteger, PlayUnreachCellStyle) {
    PlayUnreachCellStyleNone = 1 << 0,  // normal 播放滑动可及cell
    PlayUnreachCellStyleUp = 1 << 1,    // top 顶部不可及
    PlayUnreachCellStyleDown = 1<< 2    // bottom 底部不可及
};


@interface VideoPlayCell : UITableViewCell

@property (nonatomic) PlayUnreachCellStyle cellStyle;

@property (nonatomic, strong) UIImageView * topImg;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * timeLabel;
@property (nonatomic, strong) LikeButton * likeBtn;
@property (nonatomic, strong) UIImageView * playIcon;
/** videoPath */
@property(nonatomic, strong)NSString *videoPath;

- (void)updateWithVideoListModel:(VideoListModel *)model;

@end
