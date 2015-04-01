//
//  MBProgressHUD+JUHua.m
//  凤凰新闻
//
//  Created by jerehedu on 15-3-11.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "MBProgressHUD+JUHua.h"

@implementation MBProgressHUD (JUHua)

+ (instancetype)showHUDAddedTo:(UIView *)view WithText:(NSString *)text
{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:view];
    hud.removeFromSuperViewOnHide=YES;
    [view addSubview:hud];
    hud.labelText=text;
    [hud show:YES];
    return hud;
}
+ (instancetype)showAutoHideHUDAddedTo:(UIView *)view WithText:(NSString *)text andHideAfter:(NSTimeInterval)timeInterval
{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud = [[self alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    [view addSubview:hud];
    hud.labelText=text;
    [hud show:YES];
    [hud hide:YES afterDelay:timeInterval];
    return hud;

}

@end
