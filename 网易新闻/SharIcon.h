//
//  SharIcon.h
//  网易新闻
//
//  Created by jerehedu on 15-3-19.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharIcon : UIView
+(id)sharicon;

@property (weak, nonatomic) IBOutlet UIImageView *sharimg;

@property (weak, nonatomic) IBOutlet UILabel *sharimgLab;
@property (weak, nonatomic) IBOutlet UIButton *sharebtn;

@end
