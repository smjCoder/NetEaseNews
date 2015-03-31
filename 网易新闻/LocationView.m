//
//  LocationView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-25.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "LocationView.h"
#import "AFNetworking.h"
#import "ChineseString.h"
@interface LocationView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *indexArray;
    NSMutableArray  *LetterResultArr;
    NSMutableArray *usualAry;
    NSString *cityName;
    NSMutableArray *useAry;
    NSMutableString *province_city;
}

@end

@implementation LocationView

- (void)viewDidLoad {
    [super viewDidLoad];
    indexArray=[NSMutableArray array];
    LetterResultArr=[NSMutableArray array];
    usualAry=[NSMutableArray array];
    useAry =[NSMutableArray array];
    _table.delegate=self;
    _table.dataSource=self;
    [self getjson];
    [usualAry addObjectsFromArray: @[@"烟台",@"北京",@"上海",@"深圳"]];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popback:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexArray;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [indexArray objectAtIndex:section+1];
    return key;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    lab.backgroundColor = [UIColor lightGrayColor];
    if (section==0) {
        lab.text=@"您当前的位置可能是";
    }
    else if ([[indexArray objectAtIndex:section-1]isEqualToString:@"＃"])
    {
        lab.text=@"经常使用的城市";
    }
    else{
        lab.text = [indexArray objectAtIndex:section-1];}
    lab.textColor = [UIColor grayColor];
    lab.font=[UIFont systemFontOfSize:15];
    return lab;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSLog(@"title===%@",title);
    return index;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [indexArray count]+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if (section==1)
    {
        return 4;
    }
    else{
        return [[LetterResultArr objectAtIndex:section-2] count];}
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0) {
        cell.textLabel.text=@"定位";
        return cell;
    }
    else if (indexPath.section==1)
    {
        cell.textLabel.text=usualAry[indexPath.row];
        return cell;
    }
    else{
    cell.textLabel.text=[[LetterResultArr objectAtIndex:indexPath.section-2] objectAtIndex:indexPath.row];
        return cell;}
}

-(void)getjson
{
    NSData *returndata=[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"weather_city_code" ofType:@"json"]];
    NSDictionary *dict= [NSJSONSerialization JSONObjectWithData:returndata options:kNilOptions error:nil];
    NSMutableArray *cityAry=[NSMutableArray array];
    NSArray *arry=[dict objectForKey:@"城市代码"];
    
    for (int i=0; i<arry.count; i++) {
        NSArray *arycontry=[arry[i] objectForKey:@"市"];
        for (int j=0; j<[arycontry count]; j++) {
            province_city=[NSMutableString new];
            [province_city appendString:[arry[i] objectForKey:@"省" ]];
            [province_city appendString:@"|"];
            [province_city appendString:[arycontry[j] objectForKey:@"市名"]];
            [useAry addObject:province_city];
            [cityAry addObject:[arycontry[j] objectForKey:@"市名"]];
        }
    }
    indexArray=[ChineseString IndexArray:cityAry];
    [indexArray insertObject:@"＃" atIndex:0];
    LetterResultArr = [ChineseString LetterSortArray:cityAry];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        cityName=@"北京" ;
    }
    
    else if (indexPath.section==1) {
       
        cityName=[usualAry objectAtIndex:indexPath.row];
    }
    else
    {
        cityName=[[LetterResultArr objectAtIndex:indexPath.section-2]objectAtIndex:indexPath.row];
        NSLog(@"---->%@",[[LetterResultArr objectAtIndex:indexPath.section-2]objectAtIndex:indexPath.row]);
            if ( [usualAry containsObject:[[LetterResultArr objectAtIndex:indexPath.section-2]objectAtIndex:indexPath.row]]==NO ) {
                                [usualAry insertObject:[[LetterResultArr objectAtIndex:indexPath.section-2]objectAtIndex:indexPath.row] atIndex:0];
                
                [usualAry removeLastObject];
                [_table reloadData];
        }
        else
        {
            
            
            
        }
        
    }
    _cityname.text=[NSString stringWithFormat:@"当前城市－%@",cityName];
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    [defa setObject:cityName forKey:@"c_name"];
    for (int i=0; i<useAry.count; i++ ) {
        if ([[useAry[i] componentsSeparatedByString:@"|"][1] isEqualToString:cityName]) {
            [defa setObject:useAry[i] forKey:@"province_city"];
        }
        
    }
    [defa synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cityname" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
//                                                    message:[[LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
//    [alert show];
}

@end
