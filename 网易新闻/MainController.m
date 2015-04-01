//
//  MainController.m
//  网易新闻
//
//  Created by jerehedu on 15-3-16.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "MainController.h"
#import "SliderViewController/QHSliderViewController.h"
#import "LeftController.h"
#import "UIButton+WebCache.h"
#import "HTHorizontalSelectionList.h"
#import "EGORefreshTableHeaderView.h"
#import "PullTableView.h"
#import "TopNewsCell.h"
#import "NewsCell.h"
#import "BigPicNewsCell.h"
#import "PhotoNewsCell.h"
#import "NewsBLL.h"
#import "WXApiObject.h"
#import "WHScrollAndPageView.h"
#import "UIImageView+WebCache.h"
#import "App_Configs.h"
#import "DetailView.h"
@interface MainController ()<HTHorizontalSelectionListDelegate, HTHorizontalSelectionListDataSource,PullTableViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,WHcrollViewViewDelegate>
{
    PullTableView *table;
    EGORefreshTableHeaderView *refreshView;
    NSMutableArray *tablesource;
    NSMutableArray *tabletopsource;
    NSMutableArray *tableAry;
    int page_index;
//    WHScrollAndPageView *_whView;
    
}

@property (nonatomic, strong)HTHorizontalSelectionList *textSelectionList;
@property (nonatomic, strong) NSArray *channelAry;


@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
        [defa setObject:@(0) forKey:@"viewtag"];
        [defa synchronize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(entername) name:@"shabi" object:nil];
    
    
    page_index=0;
    [self setchannelview];
    [self setNews];
    [self getNewsData:@"0"];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)leftAction:(UIButton *)sender {
    
    
    LeftController *left=(LeftController *)[[QHSliderViewController sharedSliderController]LeftVC];

    [left setTimerInterval];
    


    
    [[QHSliderViewController sharedSliderController] showLeftViewController];
    
    
}

- (IBAction)rIghtAction:(UIButton *)sender {
    [[QHSliderViewController sharedSliderController] showRightViewController];
}
+(id)init:(NSString *)str
{
    MainController *controller=[[MainController alloc]init];
    [controller.nav_btn setTitle:str forState:UIControlStateNormal];
    return self;
}
-(void)entername
{
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    [_nickimg sd_setBackgroundImageWithURL:[NSURL URLWithString:[defa objectForKey:@"profileImage"]] forState:UIControlStateNormal];
    _nickimg.layer.cornerRadius=15;
    _nickimg.layer.masksToBounds=YES;
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"shabi"];
}
-(void)setchannelview
{

    _textSelectionList = [[HTHorizontalSelectionList alloc] initWithFrame:CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width-40, 40)];
    _textSelectionList.delegate = self;
    _textSelectionList.dataSource = self;
    _textSelectionList.backgroundColor=[UIColor colorWithWhite:0.95 alpha:0.95];
    self.textSelectionList.selectionIndicatorColor = [UIColor redColor];
    [self.textSelectionList setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    _channelAry = @[@"头条",
                      @"娱乐",
                      @"体育",
                      @"烟台",
                      @"科技",
                      @"汽车",
                      @"图片",
                      @"跟帖",
                      @"财经",
                      @"时尚",
                      @"段子",
                      @"轻松一刻",
                      @"军事",
                      @"历史",
                      @"房产",
                      @"彩票"];
    
    [self.view addSubview:_textSelectionList];
    
}

#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.channelAry.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index {
    
    return self.channelAry[index];
}

#pragma mark - HTHorizontalSelectionListDelegate Protocol Methods

- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index {
    // update the view for the corresponding index
    _scrollview.contentOffset=CGPointMake([UIScreen mainScreen].bounds.size.width*index, 0);
   
}
-(void)setNews
{
    tabletopsource =[NSMutableArray array];
    tablesource=[NSMutableArray array];
    tableAry=[NSMutableArray array];
    _scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width*_channelAry.count, [UIScreen mainScreen].bounds.size.height-64-40);
    _scrollview.pagingEnabled=YES;
    _scrollview.delegate = self;
//    for (int i=0; i<_channelAry.count; i++)
//    {
        table=[PullTableView new];
        table.pullDelegate=self;
        table.delegate=self;
        table.dataSource=self;
        table.backgroundColor=[UIColor colorWithRed:(float)(arc4random()%255)/255 green:(float)(arc4random()%255)/255 blue:(float)(arc4random()%255)/255 alpha:1];
        table.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-40);
    
        [_scrollview addSubview:table];
        [tableAry addObject:table];
    
//    }
    
}
#pragma mark tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return tablesource.count+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0) {
        TopNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell==nil) {
            cell=[TopNewsCell topNewsCell];
            
        }
        cell.topAry=tabletopsource;
        return cell;
    }
    else{
        if([[tablesource[indexPath.row-1]skipType ]isEqualToString:@"photoset"]) {
            PhotoNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
                if (cell==nil) {
                    cell=[PhotoNewsCell photoNewsCell];
                }
       
                cell.news=tablesource[indexPath.row-1];
                return cell;
            }
            else if ([tablesource[indexPath.row-1]imgType]!=nil) {
                BigPicNewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell3"];
                if (cell==nil) {
                    cell=[BigPicNewsCell bigPicNewsCell];
                }
                cell.news=tablesource[indexPath.row-1] ;
                return cell;
            }
            else
            {
                NewsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell4"];
                if (cell==nil) {
                    cell=[NewsCell newsCell];;
                }
                cell.news=tablesource[indexPath.row-1];
                return cell;
            }
        }
   
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    int index = (int)targetContentOffset->x/[UIScreen mainScreen].bounds.size.width;
    [_textSelectionList setSelectedButtonIndex:index animated:YES];
}
#pragma mark 获取新闻
-(void)getNewsData:(NSString *)pageindex
{
//    tabletopsource =[NSMutableArray array];
//    tablesource=[NSMutableArray array];
    NewsBLL *bll=[NewsBLL new];
    [bll getNewsWithpageindex:pageindex success:^(id json) {
       NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:nil];
       NSArray *ary=[dic objectForKey:@"T1348647909107"];
       if ([pageindex isEqualToString:@"0"]) {
           [tablesource removeAllObjects];
           [tabletopsource removeAllObjects];
           [tabletopsource addObject:[self jsonTOBaseModel:ary][0]];
           [tablesource addObjectsFromArray:[self jsonTOBaseModel:ary]];
           [tablesource removeObjectAtIndex:0];
            [self gettopNewsdata];
     
       }
       else{
           [tablesource addObjectsFromArray:[self jsonTOBaseModel:ary]];
           [table reloadData];
       }
      
       
       
   } fail:^{
       NSLog(@"error");
   }];
}
-(void)gettopNewsdata
{
    NewsBLL *bll=[NewsBLL new];
    [bll getTopNewsWithuccess:^(id json) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:nil];
        NSArray *arry=[dic objectForKey:@"headline_ad"];
        [tabletopsource addObjectsFromArray:[self jsonTOBaseModel:arry]];
        [table reloadData];
    } fail:^{
        NSLog(@"error of topnews");
    }];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 240;
    }
   else{
    if ([[tablesource[indexPath.row-1] skipType]isEqualToString:@"photoset"]) {
        return 135;    }
    else if ([tablesource[indexPath.row-1] imgType]!=nil) {
        return 220;
    }
    else
    {
        return 80;
    }
    }
}
-(NSMutableArray *)jsonTOBaseModel:(NSArray *)ary
{
    NSMutableArray *changary=[NSMutableArray array];
    for (NSDictionary *obj in ary) {
        News *news=[[News alloc]initWithDataDic:obj];
        [changary addObject:news];
    }
    return changary;
    
}
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView;
{
   [self performSelector:@selector(refresh) withObject:nil afterDelay:3.0];
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView;
{
    [self performSelector:@selector(loadMore) withObject:nil afterDelay:3.0];
}
-(void)refresh
{
    page_index=0;
    NSString *page=[NSString stringWithFormat:@"%i",page_index*20];
    [self getNewsData:page];
    table.pullLastRefreshDate=[NSDate date];
    table.pullTableIsRefreshing=NO;

    
}
-(void)loadMore
{
    page_index++;
    NSString *page=[NSString stringWithFormat:@"%i",page_index*20];
    [self getNewsData:page];
    table.pullTableIsLoadingMore=NO;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0) {
        News *mondel=tablesource[indexPath.row-1];
        DetailView  *detailview=[DetailView sharedManager];
        detailview.htmlurl=mondel.url;
        [[QHSliderViewController sharedSliderController].navigationController pushViewController:detailview animated:YES];
    }
}

@end
