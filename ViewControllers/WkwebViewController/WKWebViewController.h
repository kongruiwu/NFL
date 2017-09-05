//
//  WKWebViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/10.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseViewController.h"
#import "InfoListModel.h"

@interface WKWebViewController : BaseViewController

@property (nonatomic, strong) InfoListModel * infoModel;


- (instancetype)initWithTitle:(NSString *)title url:(NSString *)urlStr;
- (instancetype)initWithNewsId:(NSNumber *)newsID;
@end
