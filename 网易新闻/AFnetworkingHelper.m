//
//  AFnetworkingHelper.m
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "AFnetworkingHelper.h"
#import "AFNetworking.h"

@implementation AFnetworkingHelper
-(void)getJsonWith:(NSString *)urlString andSuccess:(void (^)(id))success andFail:(void (^)())fail{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        fail();
    }];

}
#pragma mark 队列异步下载
-(void)getJsonAry:(NSArray *)urlAry andSuccess:(void (^)(id))success
{
    NSMutableArray *operationAry=[NSMutableArray array];
    for (int i=0; i<urlAry.count; i++) {
        NSURLRequest *request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlAry[i] parameters:nil error:nil];
        AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
        operation.responseSerializer=[AFJSONResponseSerializer serializer];
        [operationAry addObject:operation];
    }
    NSArray *operations=[AFURLConnectionOperation batchOfRequestOperations:operationAry progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
        
    } completionBlock:^(NSArray *operations) {
        NSMutableArray *ary=[NSMutableArray array];
        for (AFHTTPRequestOperation *obj in operations) {
            [ary addObject:obj.responseObject[0]];
        }
        success(ary);
        
    }];
    [[NSOperationQueue mainQueue]addOperations:operations waitUntilFinished:NO];
}


@end
