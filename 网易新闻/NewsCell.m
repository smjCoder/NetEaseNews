//
//  NewsCell.m
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "App_Configs.h"

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)newsCell
{
    return [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil][1];
}
-(void)setNews:(News *)news
{
    _news=news;
    [_imgsrc sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] placeholderImage:DEFAULT_IMG];
    _title.text=news.title;
    _digest.text=news.digest;
    [_replyCount setTitle:[NSString stringWithFormat:@"%i跟贴",news.replyCount] forState:UIControlStateNormal];
    //差属性

}

@end
