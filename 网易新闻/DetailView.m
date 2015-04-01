//
//  DetailView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-30.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "DetailView.h"
#import "HTMLParser.h"
#import "FDLabelView.h"
#import "QHSliderViewController.h"
#import "MBProgressHUD+JUHua.h"
#import "HTMLNode.h"
#import "NewsBLL.h"
#import "UIImageView+WebCache.h"

#define kGap 5
#define kViewWidth [UIScreen mainScreen].bounds.size.width

@interface DetailView ()
{
    CGFloat currentY;
    UIScrollView *mScrollView;
    BOOL first;
}

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
     mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    currentY = 5.0;
    first = YES;
    [self.view addSubview:mScrollView];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popback:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
+(DetailView *)sharedManager
{
    static DetailView *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[DetailView alloc] init];
    });
    return sharedAccountManagerInstance;
}

-(void)viewWillAppear:(BOOL)animated
{
    for (UIView *view in mScrollView.subviews) {
        [view removeFromSuperview];
    }
    
    first = YES;
    [self getDataByUrl];
}

#pragma mark 从服务器取数据
-(void)getDataByUrl
{
//    [MBProgressHUD showHUDAddedTo:self.view WithText:@"loading"];
    NewsBLL *newsBll = [NewsBLL new];
    [newsBll getNewsDetailWithUrl:_htmlurl success:^(id htmlData) {
        NSString *htmlStr = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
        
        //设置标题时间来源
        if (first) {
            first = NO;
            [self setTitleAndSource:htmlStr];
        }
        
        //截取html中得数据
        [self parseHTML:htmlStr];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    } fail:^{
//        [MBProgressHUD showAutoHideHUDAddedTo:self.view Text:@"网络繁忙,请稍后重试"];
//        [MBProgressHUD showAutoHideHUDAddedTo:self.view WithText:@"网络繁忙,请稍后重试" andHideAfter:1];
    }];
    }

- (void)setTitleAndSource:(NSString *)html
{
    //截取标题
    //得到标题所在的位置
    NSRange rangeTitle=[html rangeOfString:@"<title>"];
    //截取后面有用的信息
    NSMutableString *needTidyString=[NSMutableString stringWithString:[html substringFromIndex:rangeTitle.location+rangeTitle.length]];
    //截取标题后半段
    NSRange rangeTitle2=[needTidyString rangeOfString:@"_手机网易网"];
    NSMutableString *title=[NSMutableString stringWithString:[needTidyString substringToIndex:rangeTitle2.location]];
    //替换转移字符"\"
    title = [[title stringByReplacingOccurrencesOfString:@"&#34;" withString:@"\""] mutableCopy];
    //设置上边界 ,添加标题
    currentY = 2*kGap;
    [self addSubStrongText:title];
    NSLog(@"title = %@  ",title);
    
    //截取来源、时间
    NSRange rangeST = [html rangeOfString:@"<div class=\"about\">"];
    //得到后面的字符串
    NSMutableString *stringST = [NSMutableString stringWithString:[html substringFromIndex:rangeST.location+rangeST.length]];
    //找到后面第一个br，中间时间
    NSRange timeRange = [stringST rangeOfString:@"<br/>"];
    NSMutableString *timeString = [NSMutableString stringWithString:[stringST substringToIndex:timeRange.location]];
    timeString = [NSMutableString stringWithString:[timeString substringFromIndex:timeString.length-21]];
    stringST = [NSMutableString stringWithString:[stringST substringFromIndex:timeRange.location+timeRange.length]];
    //找到来源
    NSRange sourceRange2 = [stringST rangeOfString:@"<br/>"];
    NSMutableString *sourceString = [NSMutableString stringWithString:[stringST substringToIndex:sourceRange2.location]];
    NSRange sourceRange3 = [sourceString rangeOfString:@"来源:"];
    sourceString = [NSMutableString stringWithString:[sourceString substringFromIndex:sourceRange3.location+sourceRange3.length]];
    [self addSamllText:[sourceString stringByAppendingString:timeString]];
}

#pragma mark 转为需要显示的格式
- (void)parseHTML:(NSString *)html
{
    NSString *allString = [NSString stringWithString:html];
    
    //截取正文
    //找到正文的开始，截取到最后
    NSRange contentRange1=[html rangeOfString:@"<div class=\"content\">"];
    NSMutableString *contStrTemp1=[[NSMutableString alloc]initWithString:[html substringFromIndex:contentRange1.location+contentRange1.length]];
    //找到正文的结束
    NSRange contentRange2=[contStrTemp1 rangeOfString:@"</div>"];
    NSMutableString *contStrTemp2=[[NSMutableString alloc]initWithString:[contStrTemp1 substringToIndex:contentRange2.location]];
    html = [contStrTemp2 mutableCopy]; //copy是浅拷贝，得到的新串和旧串指向同一块内存；而mutableCopy是深拷贝，得到的新串和旧串内容相同，但是新开辟一块新的内存
//    NSLog(@"正文 = %@",html);
    
    //把正文中的所有<br/>去掉
    
    html = [html stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
    [html stringByReplacingOccurrencesOfString:@"<p>  <strong>" withString:@"<strong>"];
    [html stringByReplacingOccurrencesOfString:@"</strong></p>" withString:@"</strong>"];
    NSLog(@"----------------------%@",html);
    html=[html stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    HTMLNode *bodyNode = [parser body];
    NSArray *inputNodes = [bodyNode children];
    
    for (HTMLNode *node in inputNodes) {
        
        if (node.nodetype == HTMLIFrame) {
            [self addVideoPlayer:[node getAttributeNamed:@"src"]];
        }
        
        NSArray *childNodes = [node children];
        if (childNodes.count > 0) {
            
            HTMLNode *theNode = [childNodes objectAtIndex:0];
            if (theNode.nodetype == HTMLImageNode) {
                [self addSubImageView:[theNode getAttributeNamed:@"src"]];
            }
            if (theNode.nodetype == HTMLStrongNode) {
                
                [self addSubStrongText:theNode.contents];
            }
            
            if (node.nodetype == HTMLBlockQuoteNode) {
                for (HTMLNode *node1 in childNodes) {
                    if (node1.nodetype == HTMLPNode) {
                        
                        [self addBlockQuoteView:node1.contents];
                    }
                }
            }else{
                NSMutableString *contentString = [[NSMutableString alloc]init];
                for (HTMLNode *node1 in childNodes) {
                    if (node1.nodetype == HTMLTextNode) {
                        [contentString appendString:node1.rawContents];
                        if (node1.nextSibling.nodetype != HTMLHrefNode) {
                            
                            [contentString appendString:@"\n"];
                        }
                    }
                    if (node1.nodetype == HTMLHrefNode) {
                        [contentString appendString:node1.contents];
                    }
                }
                [self addSubText:contentString];
            }
        }
        
    }
    
    //判断是否还有，如果有，再次得到url，重新取
    if ([allString containsString:@"<div class=\"reset marTop10 cBlue\">"]) {
        
        NSLog(@"还有下一页  %@",allString);
        NSRange nextRange = [allString rangeOfString:@"<div class=\"reset marTop10 cBlue\">"];
        
        NSMutableString *nextString1 = [NSMutableString stringWithString:[allString substringFromIndex:nextRange.location+nextRange.length]] ;
        
        if ([allString containsString:@"余下全文"]) {
            //还有多页
            NSRange nextRange2 = [nextString1 rangeOfString:@"\">余下全文</a>"];
            NSMutableString *nextString2 = [NSMutableString stringWithString:[nextString1 substringToIndex:nextRange2.location]] ;
            
            NSRange nextRange3 = [nextString2 rangeOfString:@"下页</a>　    <a href=\""];
            _htmlurl = [NSMutableString stringWithString:[nextString2 substringFromIndex:nextRange3.location+nextRange3.length]] ;
            NSLog(@"%@",_htmlurl);
            [self getDataByUrl];
        }
        else if ([nextString1 containsString:@"\">下页"])
        {
            //只有一页
            NSRange nextRange2 = [nextString1 rangeOfString:@"\">下页"];
            NSMutableString *nextString2 = [NSMutableString stringWithString:[nextString1 substringToIndex:nextRange2.location]] ;
            NSRange nextRange3 = [nextString1 rangeOfString:@"<a href=\""];
            _htmlurl = [NSMutableString stringWithString:[nextString2 substringFromIndex:nextRange3.location+nextRange3.length]];
            NSLog(@"%@",_htmlurl);
            [self getDataByUrl];
        }
        
        //        [self getDataByUrl];
    }
}

#pragma mark 添加文章标题
- (void)addSubStrongText:(NSString *)content {
    
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(kGap, currentY, kViewWidth-2*kGap, 0)];
    //    titleView.backgroundColor = [UIColor redColor];
    //    titleView.textColor = [UIColor colorWithHue:0.57 saturation:0.87 brightness:0.82 alpha:0.80];
    titleView.textColor = [UIColor blackColor];
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 0.00;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    currentY += titleView.visualTextHeight;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}

#pragma mark 添加来源时间
- (void)addSamllText:(NSString *)content {
    
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(kGap, currentY-2, kViewWidth-kGap*2, 0)];
    titleView.textColor = [UIColor grayColor];
    titleView.font = [UIFont boldSystemFontOfSize:12];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 1;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 0.00;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    currentY += titleView.visualTextHeight;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}

#pragma mark 加图片
- (void)addSubImageView:(NSString *)imageURL {
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
    
    CGFloat height = (kViewWidth-4*kGap)/img.size.width * img.size.height;
    CGRect rect = CGRectMake(2*kGap, currentY, kViewWidth-4*kGap, height);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"cell_image_background"]];
    [mScrollView addSubview:imageView];
    currentY += imageView.frame.size.height+10;
}

#pragma mark 添加引用
- (void)addBlockQuoteView:(NSString *)content {
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(20, currentY, 280, 0)];
    titleView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:13];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.90;
    titleView.fixedLineHeight = 0.00;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    
    currentY += titleView.visualTextHeight + 10;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}


#pragma mark 添加文章段落
- (void)addSubText:(NSString *)content {
    NSLog(@"%@",content);
    FDLabelView *titleView = [[FDLabelView alloc] initWithFrame:CGRectMake(10, currentY, 300, 0)];
    titleView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.00];
    titleView.textColor = [UIColor blackColor];
    titleView.font = [UIFont systemFontOfSize:16];
    titleView.minimumScaleFactor = 0.50;
    titleView.numberOfLines = 0;
    titleView.text = content;
    titleView.lineHeightScale = 0.80;
    titleView.fixedLineHeight = 20;
    titleView.fdLineScaleBaseLine = FDLineHeightScaleBaseLineCenter;
    titleView.fdTextAlignment = FDTextAlignmentLeft;
    titleView.fdAutoFitMode = FDAutoFitModeAutoHeight;
    titleView.fdLabelFitAlignment = FDLabelFitAlignmentCenter;
    titleView.contentInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
    [mScrollView addSubview:titleView];
    
    currentY += titleView.visualTextHeight + 10;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
    
    titleView.debug = NO;
}

#pragma mark 视频
- (void)addVideoPlayer:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    UIWebView *videoWeb = [[UIWebView alloc]initWithFrame:CGRectMake(10, currentY, 300, 190)];
    [videoWeb loadRequest:[NSURLRequest requestWithURL:url]];
    [mScrollView addSubview:videoWeb];
    currentY += 190 + 10;
    [mScrollView setContentSize:CGSizeMake(self.view.frame.size.width, currentY)];
}
@end
