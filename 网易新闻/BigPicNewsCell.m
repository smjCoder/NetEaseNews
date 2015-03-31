//
//  BigPicNewsCell.m
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "BigPicNewsCell.h"
#import "UIImageView+WebCache.h"
#import "App_Configs.h"

@implementation BigPicNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)bigPicNewsCell
{
    return  [[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil][3];
}

-(void)setNews:(News *)news
{
    _news=news;
    _title.text=news.title;
    [_imgbig sd_setImageWithURL: [NSURL URLWithString:news.imgsrc] placeholderImage:DEFAULT_IMG];
    if (news.editor.count!=0) {
            [_editorImg sd_setImageWithURL: [NSURL URLWithString:[news.editor[0] objectForKey:@"editorImg"]] placeholderImage:DEFAULT_IMG];
            _editorName.text=[news.editor[0] objectForKey:@"editorName"];
    }
    else
    {
        _editorImg.hidden=YES;
        _editorName.hidden=YES;
    }


    _digest.text=news.digest;
}
@end
