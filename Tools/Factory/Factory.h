//
//  KTFactory.h
//  KeTing
//
//  Created by 吴孔锐 on 2017/6/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ConfigHeader.h"

@interface Factory : NSObject
+ (UITableView *)creatTabviewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)obj;

+ (UILabel *)creatLabelWithText:(NSString *)title fontValue:(float)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

+ (void)setLabel:(UILabel *)label BorderColor:(UIColor *)color with:(CGFloat)withValue cornerRadius:(CGFloat)radiusValue;

+ (UIButton *)creatButtonWithTitle:(NSString *)title backGroundColor:(UIColor *)groundColor textColor:(UIColor *)textColor textSize:(float)fontValue;

+ (UIButton *)creatButtonWithNormalImage:(NSString *)normalImage selectImage:(NSString *)selectImage;

+ (UIImageView *)creatImageViewWithImage:(NSString *)imageName;

+ (UIImageView *)creatArrowImage;

+ (UIView *)creatLineView;

+ (UIView *)creatViewWithColor:(UIColor *)color;

+ (CGSize)getSize:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont*)font;

+ (CGSize)getSize:(NSMutableAttributedString *)attributes maxSize:(CGSize)maxSize;

+ (UITextField *)creatTextFiledWithPlaceHold:(NSString *)placeHold;

+ (NSString *)changePhoneString:(NSString *)phone;

+ (NSString *)timestampSwitchWithHourStyleTime:(NSInteger)timestamp;

+ (UIImage *)getImageWithNumer:(NSNumber *)teamid white:(BOOL)rec;
@end
