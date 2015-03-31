//
//  Temputer.m
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "Temputer.h"

@implementation Temputer

+(id)temputer
{
    return [[NSBundle mainBundle]loadNibNamed:@"Temputer" owner:nil options:nil][0];
    
}
-(void)setTemdic:(NSDictionary *)temdic{
    NSArray *arry1=@[@"晴",@"晴转多云",@"阵雨",@"阵雪",@"雾",@"雨夹雪",@"雷阵雨",@"小雨",@"大雨",@"雨",@"暴雨",@"大雪",@"小雪",@"雪",@"冰雹",@"多云",@"阴"];
    NSArray *arry2=@[@"sun",@"sun_and_cloud",@"sun_and_rain",@"sun_and_snow",@"fog",@"rain_and_snow",@"thunder",@"rain_little",@"rain_heavy",@"rain",@"rain_heavyx",@"snow_heavy",@"snow_little",@"snow",@"thunder_hailstone",@"sun_and_cloud",@"cloud"];
    for (int i=0; i<arry1.count; i++)
    {
    if ([[temdic objectForKey:@"climate"]isEqualToString:arry1[i]])
    {
        NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:arry2[i] ofType:@"bundle"]];
        NSArray *ary=[bund pathsForResourcesOfType:@"png" inDirectory:nil];
        _temp.image=[UIImage imageNamed:[ary lastObject]];
        }
    }
    
    _week.text=[temdic objectForKey:@"week"];
    _weather.text=[temdic objectForKey:@"temperature"];
    _wetherlab.text=[temdic objectForKey:@"climate"];
    _wind.text=[temdic objectForKey:@"wind"];
    self.backgroundColor=[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.2];

    
}

@end
