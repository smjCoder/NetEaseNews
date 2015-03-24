//
//  LeftController.m
//  网易新闻
//
//  Created by jerehedu on 15-3-16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "LeftController.h"

#import "MainController.h"
#import "SliderViewController/QHSliderViewController.h"
#import "WelcomeView.h"
#import "ZFModalTransitionAnimator.h"
#import "SubjectView.h"

@interface LeftController ()
{
    NSArray *arry;
    NSMutableArray *btnviewAry;
}
@property (nonatomic, strong) ZFModalTransitionAnimator *animator;
@end

@implementation LeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    arry=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"MenuList" ofType:@"plist"]];
    
    btnviewAry=[NSMutableArray array];
    for (int i=0; i<arry.count; i++) {
        LeftView *view=[LeftView leftview];
        view.lab.text=[arry[i] objectForKey:@"title"];
        view.btn.tag=100+i;
        view.tag=200+i;
        view.viewlayer.layer.cornerRadius=17.5;
        NSDictionary *dic=arry[i];
        view.viewlayer.layer.borderColor=[[UIColor colorWithRed:(float)[[dic objectForKey:@"color_r"] intValue]/255 green:(float)[[dic objectForKey:@"color_g"] intValue]/255 blue:(float)[[dic objectForKey:@"color_b"] intValue]/255 alpha:(float)[[dic objectForKey:@"color_a"] intValue]/255]CGColor];
        view.viewlayer.layer.borderWidth=1.1;
        
        NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:[arry[i] objectForKey:@"imgname"] ofType:@"bundle" ]];
        NSArray *ary1=[bund pathsForResourcesOfType:@"png" inDirectory:nil];
        view.icon.image=[UIImage imageNamed:[ary1 lastObject]];
        [view.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        view.translatesAutoresizingMaskIntoConstraints=NO;
        [self.view addSubview:view];
        NSLayoutConstraint *constraint1=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:i*77+60];
        NSLayoutConstraint *constraint2=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        NSLayoutConstraint *constraint3=[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        
        [self.view addConstraints:@[constraint1,constraint2,constraint3]];
        [btnviewAry addObject:view];
        
    }
    
}
-(void)clickbtn:(UIButton *)sender
{
    for (LeftView *obj in btnviewAry) {
        if (sender.tag+100==obj.tag)
        {
            NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:[arry[obj.tag-200] objectForKey:@"imgname"] ofType:@"bundle" ]];
            NSArray *ary1=[bund pathsForResourcesOfType:@"png" inDirectory:nil];
            NSMutableArray *imgAry=[NSMutableArray array];
            for (int i=0; i<ary1.count; i++) {
                [imgAry addObject:[UIImage imageNamed:ary1[i]]];
            }
            NSDictionary *dic=arry[obj.tag-200];
            obj.viewlayer.layer.borderColor=[[UIColor colorWithRed:(float)[[dic objectForKey:@"color_r"] intValue]/255 green:(float)[[dic objectForKey:@"color_g"] intValue]/255 blue:(float)[[dic objectForKey:@"color_b"] intValue]/255 alpha:0.7] CGColor];
            obj.lab.textColor=[UIColor colorWithRed:(float)[[dic objectForKey:@"color_r"] intValue]/255 green:(float)[[dic objectForKey:@"color_g"] intValue]/255 blue:(float)[[dic objectForKey:@"color_b"] intValue]/255 alpha:1];
            [self imgAanimation:(int)sender.tag-100 andimgAry:imgAry];
            MainController *controllerM=(MainController *)[[QHSliderViewController sharedSliderController] MainVC];
            [controllerM.nav_btn setTitle:[arry[obj.tag-200] objectForKey:@"title"] forState:UIControlStateNormal ];
            [[QHSliderViewController sharedSliderController] closeSideBar];
            NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
            [defa setObject:@(obj.tag-200) forKey:@"viewtag"];
            [defa synchronize];
            
            
            
            
        }
        else
        {
            [self stopimgAanimation:btnviewAry[obj.tag-200]];
            
        }
       

    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)imgAanimation:(int)viewtag andimgAry:(NSArray *)imgAry
{
    for (int i=0; i<btnviewAry.count; i++) {
        if (([btnviewAry[i] tag]-200)==viewtag) {
            LeftView *viewdemo=btnviewAry[i];
            viewdemo.icon.alpha=1;
            viewdemo.icon.animationImages=imgAry;
            viewdemo.icon.animationDuration=0.04*imgAry.count;
            viewdemo.icon.animationRepeatCount=1;
            [viewdemo.icon startAnimating];
            viewdemo.lab.font=[UIFont systemFontOfSize:24];
            viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.3, 1.3);

        }
    }
}

- (void)imgAnimation{
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:[arry[[[defa objectForKey:@"viewtag"] intValue]] objectForKey:@"imgname"] ofType:@"bundle" ]];
    NSArray *ary1=[bund pathsForResourcesOfType:@"png" inDirectory:nil];
    NSMutableArray *imgAry=[NSMutableArray array];
    for (int i=0; i<ary1.count; i++) {
        [imgAry addObject:[UIImage imageNamed:ary1[i]]];
    }

    for (int i=0; i<btnviewAry.count; i++) {
        LeftView *viewdemo=btnviewAry[i];
        if (([btnviewAry[i] tag]-200)==[[defa objectForKey:@"viewtag"] intValue]) {
            viewdemo.icon.alpha=1;
            viewdemo.icon.animationImages=imgAry;
            viewdemo.icon.animationDuration=0.04*imgAry.count;
            viewdemo.icon.animationRepeatCount=1;
            [viewdemo.icon startAnimating];
            viewdemo.lab.font=[UIFont systemFontOfSize:24];
//            viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.3, 1.3);
            [self setbigAnimate:viewdemo];
        }
        else
        [self setBorderAnimate:viewdemo];
    }
    
}
- (void)setTimerInterval{
    [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(imgAnimation) userInfo:nil repeats:NO];
}

-(void)stopimgAanimation:(UIView *)view
{
    LeftView *viewdemo=(LeftView *)view;
    viewdemo.lab.font=[UIFont systemFontOfSize:19];
    viewdemo.lab.textColor=[UIColor colorWithRed:(float)128/255 green:(float)128/255 blue:(float)128/255 alpha:1];
    CGAffineTransform trans=viewdemo.viewlayer.transform ;
    trans=CGAffineTransformMakeScale(1, 1);
    viewdemo.viewlayer.transform=trans;
    viewdemo.viewlayer.layer.cornerRadius=17.5;
    NSDictionary *dic=arry[viewdemo.tag-200];
    viewdemo.viewlayer.layer.borderColor=[[UIColor colorWithRed:(float)[[dic objectForKey:@"color_r"] intValue]/255 green:(float)[[dic objectForKey:@"color_g"] intValue]/255 blue:(float)[[dic objectForKey:@"color_b"] intValue]/255 alpha:(float)[[dic objectForKey:@"color_a"] intValue]/255]CGColor];
}
-(void)setBorderAnimate:(UIView *)view

{
     LeftView *viewdemo=(LeftView *)view;
    [UIView animateWithDuration:0.1 animations:^{
    viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
} completion:^(BOOL finished) {
    [UIView animateWithDuration:0.1 animations:^{
        viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            }];
        }];
    }];
}];
}
-(void)setbigAnimate:(UIView *)view
{
    LeftView *viewdemo=(LeftView *)view;
    [UIView animateWithDuration:0.1 animations:^{
        viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.4f, 1.4f);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    viewdemo.viewlayer.transform = CGAffineTransformMakeScale(1.3f, 1.3f);
                }];
            }];
        }];
    }];

}
- (IBAction)gowelcomview:(UIButton *)sender {
    
    
    WelcomeView *welcome=[WelcomeView new];
    welcome.view.frame=self.view.window.bounds;
    welcome.modalPresentationStyle=UIModalPresentationCustom;
    self.animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:welcome];
    self.animator.dragable = YES;
    self.animator.bounces = NO;
    self.animator.behindViewAlpha = 0.5f;
    self.animator.behindViewScale = 1.0f;
    self.animator.transitionDuration = 0.7f;
    self.animator.direction = ZFModalTransitonDirectionLeft;
    welcome.transitioningDelegate = self.animator;
    [self presentViewController:welcome animated:YES completion:nil];
}
- (IBAction)gosubjectview:(UIButton *)sender {
    SubjectView *subject=[SubjectView new];
    [self.navigationController pushViewController:subject animated:YES];

}
@end
