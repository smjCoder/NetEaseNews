//
//  AFnetworkingDelegate.h
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AFnetworkingDelegate <NSObject>
-(void)success:(id) responseObject;
//请求失败调用此方法
-(void)failure;
@end
