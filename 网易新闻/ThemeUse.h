//
//  ThemeUse.h
//  网易新闻
//
//  Created by jerehedu on 15-3-20.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeUse : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *useBtn;
@property (weak, nonatomic) IBOutlet UIImageView *useImg;
@property (weak, nonatomic) IBOutlet UIImageView *themeimg1;
@property (weak, nonatomic) IBOutlet UILabel *useLab;
@property (weak, nonatomic) IBOutlet UIImageView *themeimg2;
+(id)themeuse;
+(id)themeimg;
@end
