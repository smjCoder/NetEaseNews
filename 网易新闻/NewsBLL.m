//
//  NewsBLL.m
//  网易新闻
//
//  Created by jerehedu on 15-3-28.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "NewsBLL.h"

@implementation NewsBLL
-(void)getNewsWithpageindex:(NSString *)pageindex success:(void (^)(id json))success fail:(void (^)())fail
{
    NewsDAL *dal=[NewsDAL new];
    [dal getNewsWithpageindex:pageindex success:success fail:fail];
}
-(void)getTopNewsWithuccess:(void (^)(id json))success fail:(void (^)())fail
{
     NewsDAL *dal=[NewsDAL new];
    [dal getTopNewsWithuccess:success fail:fail];
}

@end
