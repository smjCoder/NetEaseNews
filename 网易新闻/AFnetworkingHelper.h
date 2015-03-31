//
//  AFnetworkingHelper.h
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFnetworkingDelegate.h"
#import "AFNetworking.h"

@interface AFnetworkingHelper : NSObject
@property (nonatomic,strong) id<AFnetworkingDelegate>  delegate;
-(void)getJsonWith:(NSString *)urlString andSuccess:(void(^)(id json))success andFail:(void(^)())fail;
-(void)getJsonAry:(NSArray *)urlAry andSuccess:(void (^)(id))success;


@end
