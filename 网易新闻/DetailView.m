//
//  DetailView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-30.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "DetailView.h"
#import "HTMLParser.h"

@interface DetailView ()

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popback:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
