//
//  BaseViewController.h
//  KeTing
//
//  Created by 吴孔锐 on 2017/6/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfigHeader.h"
#import <MJRefresh.h>
#import "RefreshGifHeader.h"
#import "NullView.h"
@interface BaseViewController : UIViewController

@property (nonatomic, strong) RefreshGifHeader * refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter * refreshFooter;
@property (nonatomic) SelectorBackType backType;
@property (nonatomic, strong) NullView * nullView;

- (void)doBack;
- (void)doShare;
- (void)setNavAlpha;
- (void)setNavUnAlpha;
- (void)setNavTitle:(NSString *)title;
- (void)drawNavLogo;
- (void)setNavLineHidden;
- (void)drawBackButton;
- (void)drawShareButton;
- (void)getData;

- (void)showNullViewByType:(NullType)type;
- (void)hiddenNullView;
@end
