//
//  BigPicNewsCell.h
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"


@interface BigPicNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imgbig;
@property (weak, nonatomic) IBOutlet UIImageView *editorImg;
@property (weak, nonatomic) IBOutlet UILabel *editorName;
@property (weak, nonatomic) IBOutlet UILabel *digest;
@property (nonatomic,strong) News *news;
+(id)bigPicNewsCell;
@end
