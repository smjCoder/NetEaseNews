//
//  NewsDAL.m
//  网易新闻
//
//  Created by jerehedu on 15-3-28.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "NewsDAL.h"
#import "App_Configs.h"


@implementation NewsDAL
-(void)getNewsWithpageindex:(NSString *)pageindex success:(void (^)(id json))success fail:(void (^)())fail
{
    NSString *strurl=[NSString stringWithFormat:@"%@%@-20.html",BASE_URL,pageindex];
    [super getJsonWith:strurl andSuccess:success andFail:fail];
}
-(void)getTopNewsWithuccess:(void (^)(id json))success fail:(void (^)())fail
{
    NSString *strurl=[NSString stringWithFormat:@"%@",TOP_URL];
    [super getJsonWith:strurl andSuccess:success andFail:fail];
}


@end
