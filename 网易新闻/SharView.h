//
//  SharView.h
//  网易新闻
//
//  Created by jerehedu on 15-3-19.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharView : UIView
+(id)sharview;
@property (weak, nonatomic) IBOutlet UIScrollView *sharScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *page;
@property (weak, nonatomic) IBOutlet UIButton *cancellBtn;

@end
