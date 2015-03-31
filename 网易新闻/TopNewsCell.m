//
//  TopNewsCell.m
//  网易新闻
//
//  Created by jerehedu on 15-3-27.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "TopNewsCell.h"
#import "UIImageView+WebCache.h"
#import "App_Configs.h"

@implementation TopNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(id)topNewsCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil][0];
}

- (void)setTopAry:(NSArray *)topAry {
    static int x = 0;
    if (x != 0) {
        _topAry=topAry;
        [_whview initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width, 210)];
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 0; i < topAry.count; i++) {
            News *model = topAry[i];
            UIImageView *imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:DEFAULT_IMG];
            [tempAry addObject:imageView];
        }
        [_whview setImageViewAry:tempAry];
//        [_whview shouldAutoShow:YES];
        _whview.delegate = self;
        _title.text=[topAry[_whview.pageControl.currentPage] title];
        _whview.pageControl.hidden=YES;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changetitle:) name:@"current" object:nil];
    }
    else {
        x = 1;
    }
    
    
}

#pragma mark 界面消失的时候
-(void)viewDidDisappear:(BOOL)animated
{
    [_whview shouldAutoShow:NO];
}

- (void)didReceiveMemoryWarning
{
    [self didReceiveMemoryWarning];

}
#pragma mark scrollview 头条新闻
-(void)didClickPage:(WHScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"点击了第%i页",(int)index);
}
-(void)changetitle:(NSNotification *)notification
{
    [self viewDidDisappear:YES];
    News *mondel=_topAry[[[notification.object objectForKey:@"current"] intValue]];
    _title.text=mondel.title;
    _page.currentPage=[[notification.object objectForKey:@"current"] intValue];
    
}
@end
