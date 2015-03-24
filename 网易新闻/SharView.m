//
//  SharView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-19.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "SharView.h"

@implementation SharView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(id)sharview
{
    return [[NSBundle mainBundle]loadNibNamed:@"leftView" owner:nil options:nil][1];
}
@end
