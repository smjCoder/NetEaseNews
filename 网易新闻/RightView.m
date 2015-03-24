//
//  RightView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-23.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "RightView.h"

@implementation RightView

+(id)rightview
{
    return [[NSBundle mainBundle]loadNibNamed:@"RightView" owner:nil options:nil][0];
}

@end
