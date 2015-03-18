//
//  MainController.m
//  网易新闻
//
//  Created by jerehedu on 15-3-16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "MainController.h"
#import "SliderViewController/QHSliderViewController.h"
#import "LeftController.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    


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
- (IBAction)leftAction:(UIButton *)sender {
    
    
    LeftController *left=(LeftController *)[[QHSliderViewController sharedSliderController]LeftVC];

    [left setTimerInterval];
    


    
    [[QHSliderViewController sharedSliderController] showLeftViewController];
    
    
}

- (IBAction)rIghtAction:(UIButton *)sender {
    [[QHSliderViewController sharedSliderController] showRightViewController];
}
+(id)init:(NSString *)str
{
    MainController *controller=[[MainController alloc]init];
    [controller.nav_btn setTitle:str forState:UIControlStateNormal];
    return self;
}

@end
