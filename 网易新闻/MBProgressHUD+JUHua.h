//
//  MBProgressHUD+JUHua.h
//  凤凰新闻
//
//  Created by jerehedu on 15-3-11.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (JUHua)
+ (instancetype)showHUDAddedTo:(UIView *)view WithText:(NSString *)text;
+ (instancetype)showAutoHideHUDAddedTo:(UIView *)view WithText:(NSString *)text andHideAfter:(NSTimeInterval)timeInterval;
@end
