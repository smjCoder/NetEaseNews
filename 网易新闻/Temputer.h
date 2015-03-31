//
//  Temputer.h
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Temputer : UIView
@property (weak, nonatomic) IBOutlet UILabel *week;
@property (weak, nonatomic) IBOutlet UIImageView *temp;
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *wetherlab;
@property (nonatomic,retain) NSDictionary *temdic;
@property (weak, nonatomic) IBOutlet UILabel *wind;
+(id)temputer;



@end
