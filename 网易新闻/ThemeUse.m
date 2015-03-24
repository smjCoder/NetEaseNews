//
//  ThemeUse.m
//  网易新闻
//
//  Created by jerehedu on 15-3-20.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "ThemeUse.h"

@implementation ThemeUse

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)themeuse
{
    return [[NSBundle mainBundle]loadNibNamed:@"Theme" owner:nil options:nil][0];
}
+(id)themeimg
{
    return [[NSBundle mainBundle]loadNibNamed:@"Theme" owner:nil options:nil][1];
}
@end
