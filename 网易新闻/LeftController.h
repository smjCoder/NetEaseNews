//
//  LeftController.h
//  网易新闻
//
//  Created by jerehedu on 15-3-16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftView.h"

@interface LeftController : UIViewController
@property (nonatomic,strong) LeftView  *leftview;
-(void)imgAanimation:(int)viewtag andimgAry:(NSArray *)imgAry;
- (void)setTimerInterval;

@end
