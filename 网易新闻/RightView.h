//
//  RightView.h
//  网易新闻
//
//  Created by jerehedu on 15-3-23.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightView : UIView
@property (weak, nonatomic) IBOutlet UIButton *advBtn;
@property (weak, nonatomic) IBOutlet UIImageView *classimg;
@property (weak, nonatomic) IBOutlet UIImageView *unRead;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
+(id)rightview;
@end
