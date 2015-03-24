//
//  EnterView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-23.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "EnterView.h"
#import "EnterInformation.h"
#import <ShareSDK/ShareSDK.h>
#import "RightController.h"
#import "UIImageView+WebCache.h"

@interface EnterView ()<UITableViewDelegate,UITableViewDataSource>
{
    RightController *rightview;
}

@end

@implementation EnterView

- (void)viewDidLoad {
    [super viewDidLoad];
    _table.delegate=self;
    _table.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popback:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     EnterInformation *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (indexPath.row==0) {
        if (cell==nil) {
            cell=[EnterInformation setEnterInformationOne];
        }
        return cell;
    }
    else if (indexPath.row==1){
        if (cell==nil) {
            cell=[EnterInformation setEnterInformationTwo];
        }
        return cell;
    }
    else if(indexPath.row==2){
        if (cell==nil) {
            cell=[EnterInformation setEnterInformationThree];
        }
        return cell;
    }
    else
    {
        if (cell==nil) {
            cell=[EnterInformation setEnterInformationFour];
        }
        [cell.sinaBtn addTarget:self action:@selector(sinaEnter) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 60;
    }
    else if(indexPath.row==1){
        return 60;
    }
    else if(indexPath.row==2){
        return 150;
    }
    else
    {
        return [UIScreen mainScreen].bounds.size.height-64-120-150;
    }
}
-(void)sinaEnter
{
    ShareType type = ShareTypeSinaWeibo;
    [ShareSDK getUserInfoWithType:type authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
        if (result) {
            NSLog(@"授权登陆成功，已获取用户信息");
            NSString *uid = [userInfo uid];
            NSString *nickname = [userInfo nickname];
            NSString *profileImage = [userInfo profileImage];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:[NSString stringWithFormat:@"授权登陆成功,用户ID:%@,昵称:%@,头像:%@",uid,nickname,profileImage] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            NSUserDefaults *deda=[NSUserDefaults standardUserDefaults];
            [deda setObject:uid forKey:@"uid"];
            [deda setObject:nickname forKey:@"nickname"];
            [deda setObject:profileImage forKey:@"profileImage"];
            [deda synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shabi" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
//            NSLog(@"source:%@",[userInfo sourceData]);
//            NSLog(@"uid:%@",[userInfo uid]);
            
            
        }else{
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Code4App" message:@"授权失败，请看日记错误描述" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];

    
}
@end
