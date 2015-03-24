//
//  EnterInformation.m
//  网易新闻
//
//  Created by jerehedu on 15-3-23.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "EnterInformation.h"

@implementation EnterInformation

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)setEnterInformationOne
{
    return [[NSBundle mainBundle]loadNibNamed:@"EnterInformation" owner:nil options:nil][0];
}
+(id)setEnterInformationTwo{
     return [[NSBundle mainBundle]loadNibNamed:@"EnterInformation" owner:nil options:nil][1];
}
+(id)setEnterInformationThree{
     return [[NSBundle mainBundle]loadNibNamed:@"EnterInformation" owner:nil options:nil][2];
}
+(id)setEnterInformationFour{
     return [[NSBundle mainBundle]loadNibNamed:@"EnterInformation" owner:nil options:nil][3];
}

@end
