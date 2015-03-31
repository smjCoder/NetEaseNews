//
//  TempView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "TempView.h"
#import "LocationView.h"
#import "Base64.h"
#import "UIImageView+WebCache.h"
#import "Temputer.h"
#import "AFNetworking.h"
#import "AFnetworkingHelper.h"

@interface TempView ()
{
    LocationView *locationview;
    Temputer *tem1;
    Temputer *tem2;
    Temputer *tem3;

}

@end

@implementation TempView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tem1=[Temputer temputer];
    tem2=[Temputer temputer];
    tem3=[Temputer temputer];
     NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    locationview=[LocationView new];
    if ([defa objectForKey:@"province_city"]==nil) {
        _city.text=@"北京";
        [self getjson:@"北京|北京"];
    }
    else
    {
        _city.text=[defa objectForKey:@"c_name"];
        [self getjson:[defa objectForKey:@"province_city"]];
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changcityname) name:@"cityname" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushToLocationview:(UIButton *)sender {
    
    [self.navigationController pushViewController:locationview animated:YES];
    
}
-(void)changcityname
{
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    _city.text=[defa objectForKey:@"c_name"];
    [self getjson:[defa objectForKey:@"province_city"]];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"cityname"];
    
}
-(void)getjson:(NSString *)citystr
{
    
    NSString *urlStr=[NSString stringWithFormat:@"http://c.3g.163.com/nc/weather/%@.html" ,[Base64 ChangeStringIntoBASE64:citystr]];
  
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
      manager.responseSerializer=[AFHTTPResponseSerializer serializer];
     [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         [self getcitytemp:dict cityname:citystr];
         
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error %@",error);
        }];

}
- (IBAction)popback:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)getcitytemp:(NSDictionary *)dict cityname:(NSString *)citystr
{
    
    NSArray *weatherA=[dict objectForKey:citystr];
    _temp.text=[weatherA[0] objectForKey:@"temperature"];
    _wetherlab.text=[weatherA[0] objectForKey:@"climate"];
    _wind.text=[weatherA[0] objectForKey:@"wind"];
    NSDateFormatter *fom=[NSDateFormatter new];
    fom.dateFormat=@"MM月dd日";
    NSString *date=[fom stringFromDate:[NSDate date]];
    
    _week.text=[NSString stringWithFormat:@"%@ %@",date,[weatherA[0] objectForKey:@"week"]];
    NSURL *strurl=[NSURL URLWithString:[[dict objectForKey:@"pm2d5"] objectForKey:@"nbg2"]];
    [_weatherblackgound sd_setImageWithURL:strurl];
    tem1.temdic=weatherA[1];
    tem2.temdic=weatherA[2];
    tem3.temdic=weatherA[3];
    tem1.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, _wetherdayview.frame.size.height);
    tem2.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/3, 0, [UIScreen mainScreen].bounds.size.width/3, _wetherdayview.frame.size.height);
    tem3.frame=CGRectMake(2*([UIScreen mainScreen].bounds.size.width/3), 0, [UIScreen mainScreen].bounds.size.width/3, _wetherdayview.frame.size.height);
    [_wetherdayview addSubview:tem1];
    [_wetherdayview addSubview:tem2];
    [_wetherdayview addSubview:tem3];
    
    NSArray *arry1=@[@"晴",@"晴转多云",@"阵雨",@"阵雪",@"雾",@"雨夹雪",@"雷阵雨",@"小雨",@"大雨",@"雨",@"暴雨",@"大雪",@"小雪",@"雪",@"冰雹",@"多云",@"阴"];
    NSArray *arry2=@[@"sun",@"sun_and_cloud",@"sun_and_rain",@"sun_and_snow",@"fog",@"rain_and_snow",@"thunder",@"rain_little",@"rain_heavy",@"rain",@"rain_heavyx",@"snow_heavy",@"snow_little",@"snow",@"thunder_hailstone",@"sun_and_cloud",@"cloud"];
    for (int i=0; i<arry1.count; i++)
    {
        if ([[weatherA[0] objectForKey:@"climate"]isEqualToString:arry1[i]])
        {
            NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:arry2[i] ofType:@"bundle"]];
            NSArray *ary=[bund pathsForResourcesOfType:@"png" inDirectory:nil];
            NSMutableArray *imgAry=[NSMutableArray array];
            for (int j=0; j<ary.count;j++) {
                [imgAry addObject:[UIImage imageNamed:ary[j]]];
            }
            _wetherimg.animationImages=imgAry;
            _wetherimg.image=[imgAry lastObject];
            _wetherimg.animationDuration=0.04*imgAry.count;
            _wetherimg.animationRepeatCount=1;
            [_wetherimg startAnimating];
            
            
            
            
            
        }
    }

}


@end
