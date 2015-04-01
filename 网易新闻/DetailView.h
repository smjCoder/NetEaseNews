//
//  DetailView.h
//  网易新闻
//
//  Created by jerehedu on 15-3-30.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIViewController
@property (nonatomic,copy) NSString *htmlurl;
+(DetailView *)sharedManager;
@end
