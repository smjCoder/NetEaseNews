//
//  PhotoNewsCell.m
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "PhotoNewsCell.h"
#import "UIImageView+WebCache.h"
#import "App_Configs.h"

@implementation PhotoNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)photoNewsCell
{
    return [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil][2];
}
-(void)setNews:(News *)news
{
    _news=news;
   [ _img1 sd_setImageWithURL: [NSURL URLWithString:news.imgsrc] placeholderImage:DEFAULT_IMG];
    [ _img2 sd_setImageWithURL: [NSURL URLWithString:news.imgsrc] placeholderImage:DEFAULT_IMG];
    [ _img2 sd_setImageWithURL: [NSURL URLWithString:news.imgsrc] placeholderImage:DEFAULT_IMG];
    _title.text=news.title;
     [_replyCount setTitle:[NSString stringWithFormat:@"%i跟贴",news.replyCount] forState:UIControlStateNormal];
    

}
@end
