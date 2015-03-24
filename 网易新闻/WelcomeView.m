//
//  WelcomeView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-18.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "WelcomeView.h"
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import "SharView.h"
#import "SharIcon.h"
#import "SendView.h"

@interface WelcomeView ()
{
    UIImage *s_image;
    SendView *sendview;
    SharView *sharview;
    CGSize keybord;
    BOOL flag;
}

@end

@implementation WelcomeView

- (void)viewDidLoad {
    [super viewDidLoad];
    flag=YES;

    [_webimg sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"ali2.jpg"]];
    [self  registerForKeyboardNotifications];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sharbtnClick:(UIButton *)sender {
    _btnOfShare.hidden=YES;
    s_image=[self getImageWithView:self.view];
    _btnOfShare.hidden=NO;
    
    sharview=[SharView sharview];
    sharview.frame=CGRectMake(10,self.view.window.bounds.size.height- _webimg.frame.size.height, self.view.window.bounds.size.width-20,_webimg.frame.size.height/2);
    sharview.transform=CGAffineTransformMakeScale(0.5, 0.5);
    sharview.alpha = 0.3;
    [self.view addSubview:sharview];
    sharview.hidden=YES;
    [UIView animateWithDuration:0.2 animations:^{
        sharview.hidden = NO;
        sharview.transform=CGAffineTransformMakeScale(1, 1);
        sharview.alpha = 1;
    }];

    
    NSArray *arry=@[@"share_platform_sina",@"share_platform_tencent",@"share_platform_renren",@"share_platform_wechat",@"share_platform_qqfriends",@"share_platform_qzone",@"share_platform_wechattimeline",@"share_platform_yixin",@"share_platform_yixintimeline",@"share_platform_email",@"share_platform_imessage"];
    NSArray *name= @[@"新浪",@"腾讯微博",@"人人网",@"微信",@"QQ",@"QQ空间",@"微信朋友圈",@"易信",@"易信朋友圈",@"邮件",@"短信"];
    sharview.sharScroll.contentSize=CGSizeMake(sharview.bounds.size.width*(arry.count/8+1), 132);
    sharview.sharScroll.pagingEnabled=YES;
    for (int i=0; i<arry.count; i++) {
        SharIcon *sharicon=[SharIcon sharicon];
        sharicon.sharimg.image=[UIImage imageNamed:arry[i]];
        sharicon.sharimgLab.text=name[i];
            if (i<8) {
                 sharicon.frame=CGRectMake(i/2*(sharview.frame.size.width/4),i%2*(sharview.frame.size.height/4), sharview.frame.size.height/4, sharview.frame.size.height/4);
            }
            else
            {
                 sharicon.frame=CGRectMake(((i-8)%4*(sharview.frame.size.width/4))+sharview.frame.size.width,0, sharview.frame.size.height/4, sharview.frame.size.height/4);
            }
         sharicon.sharebtn.tag=i+10;
        [sharicon.sharebtn addTarget:self action:@selector(sharimgclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [sharview.sharScroll addSubview:sharicon];
    }
    [sharview.cancellBtn addTarget:self action:@selector(cacelview) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)sharimgclick:(UIButton *)sender
{
    [self cacelview];
        sendview=[SendView sendview];
        sendview.frame=CGRectMake(0, self.view.window.bounds.size.height, self.view.window.bounds.size.width, 209);
    [sendview.textLab becomeFirstResponder];
    sendview.imageV.image=s_image;
    
    [sendview.sendBtn addTarget:self action:@selector(sendbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    [sendview.stopbtn addTarget:self action:@selector(stopbtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendview];
    
    //  //键盘
    [[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillShowNotification object:nil];
    
    [UIView animateWithDuration:0.5 animations:^{
         sendview.frame=CGRectMake(0, self.view.window.bounds.size.height-209-258, self.view.window.bounds.size.width, 209);
        }];
    
 
    
//    UITextField *text=[[UITextField alloc]init];
//    text.resignFirstResponder
    
    
}
- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];

}
- (void) keyboardWasShown:(NSNotification *) notif
{
    
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyBoard:%f", keyboardSize.height);
    if (keyboardSize.height==258) {
         sendview.frame=CGRectMake(0, self.view.window.bounds.size.height-209-216, self.view.window.bounds.size.width, 209);
    }
    else
    {
        sendview.frame=CGRectMake(0, self.view.window.bounds.size.height-209-258, self.view.window.bounds.size.width, 209);
    }
   
//    keyboardWasShown = YES;
    
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    
    // keyboardWasShown = NO;
    
}
- (UIImage *)getImageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(375, 667), NO, 1.0);  //NO，YES 控制是否透明
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 生成后的image
    
    return image;
}
-(void)sendbtnclick:(UIButton *)sender
{
    
    id<ISSContent> publishContent = [ShareSDK content:sendview.textLab.text defaultContent:nil image:[ShareSDK pngImageWithImage:s_image] title:@"This is title" url:@"http://mob.com" description:@"This is description" mediaType:SSPublishContentMediaTypeNews];
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                        }
                        
                    }];
    
}
-(void)stopbtnclick
{
    [UIView animateWithDuration:0.5 animations:^{
         sendview.frame=CGRectMake(0, self.view.window.bounds.size.height, self.view.window.bounds.size.width, 209);
    } completion:^(BOOL finished) {
        [sendview removeFromSuperview];
    }];
    
   
 
}
-(void)cacelview
{
    [UIView animateWithDuration:0.2 animations:^{
        sharview.transform=CGAffineTransformMakeScale(0.5, 0.5);
        sharview.alpha = 0.3;
    } completion:^(BOOL finished) {
        [sharview removeFromSuperview];
        [sharview resignFirstResponder];
    }];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter]removeObserver:UIKeyboardWillHideNotification];
}

@end
