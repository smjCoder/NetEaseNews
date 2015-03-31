//
//  TopNewsCell.h
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
#import "WHScrollAndPageView.h"
@interface TopNewsCell : UITableViewCell <WHcrollViewViewDelegate>

@property (weak, nonatomic) IBOutlet WHScrollAndPageView *whview;
@property (weak, nonatomic) IBOutlet UIPageControl *page;

@property (weak, nonatomic) IBOutlet UIImageView *imgtag;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (nonatomic,strong) News *news;
@property (nonatomic,retain) NSArray *topAry;
+(id)topNewsCell;

@end
