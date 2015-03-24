//
//  SendView.h
//  网易新闻
//
//  Created by jerehedu on 15-3-19.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendView : UIView
+(id)sendview;
@property (weak, nonatomic) IBOutlet UIButton *stopbtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UITextView *textLab;


@end
