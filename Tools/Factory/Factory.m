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
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00];
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
+ (NSString *)changePhoneString:(NSString *)phone{
    NSMutableString * str = [NSMutableString stringWithString:phone];
    [str replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return str;
}

/**UITextField*/
+ (UITextField *)creatTextFiledWithPlaceHold:(NSString *)placeHold{
    UITextField * textField = [[UITextField alloc] init];
    textField.placeholder = placeHold;
    textField.textColor = Color_MainBlack;
    textField.font = [UIFont systemFontOfSize:Anno750(28)];
    return textField;
}

/**
 将时间戳转化为时间
 */
+ (NSString *)timestampSwitchWithHourStyleTime:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"HH:mm"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+ (UIImage *)getImageWithNumer:(NSNumber *)teamid white:(BOOL)rec{
    NSString * imageName = [NSString stringWithFormat:@"%@",teamid];
    if ([teamid intValue] == 3410) {
        if (rec) {
           imageName = [NSString stringWithFormat:@"%@w",teamid];
        }
    }
    return [UIImage imageNamed:imageName];
}

/**上传图片压缩尺寸*/
+ (NSData *)dealWithAvatarImage:(UIImage *)avatarImage{
    CGSize avatarSize = avatarImage.size;
    CGSize newSize = CGSizeMake(640, 640);
    //尺寸压缩
    if (avatarSize.width <= newSize.width && avatarSize.height <= newSize.height) {
        newSize = avatarSize;
    }
    else if (avatarSize.width > newSize.width && avatarSize.height > newSize.height) {
        CGFloat tempLength = avatarSize.width > avatarSize.height ?  avatarSize.width : avatarSize.height;
        CGFloat rate = tempLength / newSize.width;
        newSize.width = avatarSize.width / rate;
        newSize.height = avatarSize.height / rate;
    }
    else if (avatarSize.width > newSize.width) {
        newSize.height = avatarSize.height * newSize.width / avatarSize.width;
    }
    else {
        avatarSize.width = avatarSize.width * newSize.height / avatarSize.height;
    }
    UIImage *avatarNew = [self imageWithImage:avatarImage scaledToSize:newSize];
    NSData *data = UIImageJPEGRepresentation(avatarNew, 0.5);
    return data;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 根据总时间返回当前时间及格式
 */
+ (NSString *)getTimeStingWithCurrentTime:(int)num andTotalTime:(int)totalSeconds{
    int seconds = num % 60;
    int minutes = (num / 60) % 60;
    int hours = num / 3600;
    int totalHour = totalSeconds / 3600;
    if (totalHour>0) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
    }else{
        return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
    }
}
@end
