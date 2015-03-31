//
//  NewsCell.h
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgsrc;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *digest;
@property (weak, nonatomic) IBOutlet UIButton *replyCount;
@property (nonatomic,strong) News *news;
+(id)newsCell;
@end
