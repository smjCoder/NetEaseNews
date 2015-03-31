//
//  NewsDAL.h
//  网易新闻
//
//  Created by jerehedu on 15-3-28.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFnetworkingHelper.h"

@interface NewsDAL :AFnetworkingHelper
-(void)getNewsWithpageindex:(NSString *)pageindex success:(void (^)(id json))success fail:(void (^)())fail;
-(void)getTopNewsWithuccess:(void (^)(id json))success fail:(void (^)())fail;
@end
