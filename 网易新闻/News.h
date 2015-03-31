//
//  News.h
//  网易新闻
//
//  Created by jerehedu on 15-3-28.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel/WXBaseModel.h"

@interface News : WXBaseModel
@property (nonatomic,strong) NSString *ptime;
//source 发表来源
@property (nonatomic,strong) NSString *source;
//cid / docid  新闻id
@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) NSString *docid;

//title 标题
@property (nonatomic,strong) NSString *title;
//digest 副标题
@property (nonatomic,strong) NSString *digest;
//imgsrc 图片新闻缩略图链接
@property (nonatomic,strong) NSString *imgsrc;
//skipType 新闻分类，类型标志（live直播、special专题、photoset图片新闻、没有的）
@property (nonatomic,strong) NSString *skipType;
//TAGS \ TAG标签 特殊说明（"独家","视频","LIVE"）
@property (nonatomic,strong) NSString *TAGS;
@property (nonatomic,strong) NSString *TAG;
//replyCount 评论数
@property (nonatomic,assign) int replyCount;
//url 新闻详情页面的URL
@property (nonatomic,strong) NSString *url;
//photosetID 图片ID
@property (nonatomic,strong) NSString *photosetID;
//imgextra 多张图片
@property (nonatomic,retain) NSArray *imgextra;
//url_3w 新闻网页版
//imgType 一张大图cell里面特有的
@property (nonatomic,assign) NSInteger *imgType;
@property (nonatomic,assign) NSInteger *hasHead;
@property (nonatomic,retain) NSArray *editor;
@end
