//
//  Base64.h
//  NetEasyNews
//
//  Created by jerehedu on 15/3/26.
//  Copyright (c) 2015年 Leon. All rights reserved.



//http://c.3g.163.com/nc/weather/6L695a6BfOS4ueS4nA==.html
//输入一个字符串："省份|城市",竖线必须是英文的
//替换掉*.html
#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+ (NSString *)ChangeStringIntoBASE64:(NSString *)str;

@end
