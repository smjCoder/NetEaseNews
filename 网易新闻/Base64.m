//
//  Base64.m
//  NetEasyNews
//
//  Created by jerehedu on 15/3/26.
//  Copyright (c) 2015年 Leon. All rights reserved.
//

#import "Base64.h"

@implementation Base64

+ (NSString *)ChangeStringIntoBASE64:(NSString *)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return str64;
}

@end
