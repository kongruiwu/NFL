//
//  KTFactory.m
//  KeTing
//
//  Created by 吴孔锐 on 2017/6/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "Factory.h"

@implementation Factory

/**
 creat tabview
 */
+ (UITableView *)creatTabviewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)obj{
    UITableView * tabview = [[UITableView alloc]initWithFrame:frame style:style];
    tabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabview.showsVerticalScrollIndicator = NO;
    tabview.showsHorizontalScrollIndicator = NO;
    tabview.delegate = obj;
    tabview.dataSource = obj;
    tabview.backgroundColor = [UIColor clearColor];
    return tabview;
}

/**
 creat Label
 */
+ (UILabel *)creatLabelWithText:(NSString *)title fontValue:(float)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment{
    UILabel * label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = alignment;
    return label;
}
/**
  set label border 
 */
+ (void)setLabel:(UILabel *)label BorderColor:(UIColor *)color with:(CGFloat)withValue cornerRadius:(CGFloat)radiusValue{
    label.layer.borderColor = color.CGColor;
    label.layer.borderWidth = withValue;
    label.layer.cornerRadius = radiusValue;
}
/**
 creat button
 */
+ (UIButton *)creatButtonWithTitle:(NSString *)title backGroundColor:(UIColor *)groundColor textColor:(UIColor *)textColor textSize:(float)fontValue{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:groundColor];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontValue];
    return button;
}
+ (UIButton *)creatButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    if (selectImage != nil) {
        [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }
    return button;
}

/**
 creat imgView with img
 */
+ (UIImageView *)creatImageViewWithImage:(NSString *)imageName{
    UIImageView * imgView = [[UIImageView alloc]init];
    imgView.image = [UIImage imageNamed:imageName];
    return imgView;
}

/**
 creat arrrowimage
 */
+ (UIImageView *)creatArrowImage{
    UIImageView * imgview = [[UIImageView alloc]init];
    imgview.image = [UIImage imageNamed:@"arrow"];
    return imgview;
}

/**
 creat line
 */
+ (UIView *)creatLineView{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.94 alpha:1.00];
    return view;
}

/**
 creat color view
 */
+ (UIView *)creatViewWithColor:(UIColor *)color{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = color;
    return view;
}

/**
 get text size
 */
+ (CGSize)getSize:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font{
    CGSize sizeFirst = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font} context:nil].size;
    return sizeFirst;
}
+ (CGSize)getSize:(NSMutableAttributedString *)attributes maxSize:(CGSize)maxSize{
    CGSize attSize = [attributes boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    
    return attSize;
}

/**
 将时间戳转化为时间
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"MM月dd日"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
    
}
@end