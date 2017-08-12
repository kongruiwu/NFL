//
//  VideoPlayViewController.h
//  NFL
//
//  Created by 吴孔锐 on 2017/8/11.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <AVKit/AVKit.h>

@interface VideoPlayViewController : AVPlayerViewController
- (instancetype)initWithUrl:(NSURL *)url;
- (void)playUrl:(NSURL *)ur;
@end
