//
//  MainController.h
//  网易新闻
//
//  Created by jerehedu on 15-3-16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *nav_btn;
+(id)init:(NSString *)str;
@property (weak, nonatomic) IBOutlet UIButton *nickimg;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;


@end
