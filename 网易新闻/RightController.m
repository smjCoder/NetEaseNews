//
//  RightController.m
//  网易新闻
//
//  Created by jerehedu on 15-3-16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "RightController.h"
#import "RightView.h"
#import "EnterView.h"
#import "UIImageView+WebCache.h"
#import "QHSliderViewController.h"


@interface RightController ()

@end

@implementation RightController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTheAdvertisement];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entername) name:@"shabi" object:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backhome:(id)sender {
}

-(void)addTheAdvertisement
{
     NSArray *arry=@[@"promoboard_icon_mall",@"promoboard_icon_activities",@"promoboard_icon_apps",@"promoboard_icon_game"];
    NSArray *arrytitle=@[@"三石哥自用有态度笔记本",@"免费定制你的睡眠音乐",@"挖金币技术哪里强",@"梦幻西游，跟贴拿肾6！"];
    for (int i=0; i<4; i++) {
        RightView *view=[RightView rightview];
        view.classimg.image=[UIImage imageNamed:arry[i]];
        view.titleLab.text=arrytitle[i];
        view.frame=CGRectMake(0, i*60,[UIScreen mainScreen].bounds.size.width, 60);
        [_adview addSubview:view];
        
    }
}
- (IBAction)enterInterface:(UIButton *)sender {
    
    EnterView *enterview=[EnterView new];
    [self.navigationController pushViewController:enterview animated:YES];
    
}
-(void)entername
{
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    _enterName.text=[defa objectForKey:@"nickname"];
    [_nickimg sd_setImageWithURL:[NSURL URLWithString:[defa objectForKey:@"profileImage"]]];
    _nickimg.layer.cornerRadius=30;
    _nickimg.layer.masksToBounds=YES;
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"shabi"];
}
- (IBAction)back:(UIButton *)sender {
    [[QHSliderViewController sharedSliderController]closeSideBar];
}
- (IBAction)setting:(UIButton *)sender {
    
}


@end
