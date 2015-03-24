//
//  SubjectView.m
//  网易新闻
//
//  Created by jerehedu on 15-3-20.
//  Copyright (c) 2015年 jerei. All rights reserved.
//

#import "SubjectView.h"
#import "ThemeUse.h"
#define MainScreenHeight [UIScreen mainScreen].bounds.size.height
#define MainScreenWidth [UIScreen mainScreen].bounds.size.width
@interface SubjectView ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGPoint startPoint;
    UIImageView *lastScreenShotView;
    NSArray *arry;
    NSArray *name;

}
@property (nonatomic, assign) BOOL isMoving;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) NSMutableArray *screenShotList;
@end
static CGFloat offset_float = 0.65;// 拉伸参数
static CGFloat min_distance = 100;
@implementation SubjectView

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableTheme.delegate=self;
    _tableTheme.dataSource=self;
    arry=@[@"theme_default",@"theme_attitude",@"theme_4.0",@"theme_springFestival"];
    name=@[@"高级黑（默认）",@"态度红",@"4.0特别版",@"春节版"];
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [recognizer delaysTouchesBegan];
    [self.view addGestureRecognizer:recognizer];
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    [defa setObject:[defa objectForKey:@"theme"] forKey:@"change"];
    [defa synchronize];
    
    
    

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return arry.count;
    }
    else
    {
        return 1;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ThemeUse *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=[ThemeUse themeuse];
        }
        NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:arry[indexPath.row] ofType:@"bundle"]];
        NSString *str=[bund pathForResource:@"thumb@2x" ofType:@"png"];
        cell.useImg.image=[UIImage imageWithContentsOfFile:str];
        cell.useLab.text=name[indexPath.row];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.useBtn addTarget:self action:@selector(beUsed:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.useBtn setImage:[UIImage imageNamed:@"theme_setting_normal@2x.png"] forState:UIControlStateNormal];
//        [cell.useBtn setTitle:@"使用中" forState:UIControlStateSelected];
//        [cell.useBtn setTitle:@"使用" forState:UIControlStateNormal];
        cell.useBtn.tag=20+indexPath.row;
       
        return cell;

    }
    else
    {
        ThemeUse *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell==nil) {
            cell=[ThemeUse themeimg];
        
        }
        NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
        if ([[defa objectForKey:@"theme"] intValue]==[[defa objectForKey:@"change"]intValue])
        {
            NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:arry[[[defa objectForKey:@"change"]intValue]] ofType:@"bundle"]];
            NSArray *ary=[bund pathsForResourcesOfType:@"jpg" inDirectory:nil];
            cell.themeimg1.image=[UIImage imageWithContentsOfFile:ary[0]];
            cell.themeimg2.image=[UIImage imageWithContentsOfFile:ary[1]];
            NSLog(@"%@",cell.themeimg1);
            return cell;

        }
        else
        {
            
            NSBundle *bund=[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:arry[[[defa objectForKey:@"change"]intValue]] ofType:@"bundle"]];
            NSArray *ary=[bund pathsForResourcesOfType:@"jpg" inDirectory:nil];
            
            cell.themeimg1.image=[UIImage imageWithContentsOfFile:ary[0]];
            cell.themeimg2.image=[UIImage imageWithContentsOfFile:ary[1]];
            NSLog(@"%@",cell.themeimg1);
            return cell;

            
        }
        
            }
    
    
}
-(void)beUsed:(UIButton *)sender
{
    
        NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
        [defa setObject:@(sender.tag-20) forKey:@"theme"];
        [defa synchronize];
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    [defa setObject:@(indexPath.row) forKey:@"change"];
    [defa synchronize];
    [_tableTheme reloadData];
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 45;
    }
    else
    {
        return 300;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popback:(UIButton *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSMutableArray *)screenShotList {
    if (!_screenShotList) {
        _screenShotList = [NSMutableArray array];
    }
    return _screenShotList;
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    // 有动画用自己的动画
    if (animated) {
        [self popAnimation];
        return nil;
    } else {
        return [self.navigationController popViewControllerAnimated:animated];
    }
}

- (void) popAnimation {
    if (!self.backGroundView) {
        CGRect frame = self.view.frame;
        
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
        
        _backGroundView.backgroundColor = [UIColor blueColor];
        
    }
    
    [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
    
    _backGroundView.hidden = NO;
    
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    
    UIImage *lastScreenShot = [self.screenShotList lastObject];
    NSLog(@"%@",lastScreenShot);
    
    lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
    
    lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float),0,320,MainScreenHeight};
    
    [self.backGroundView addSubview:lastScreenShotView];
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self moveViewWithX:320];
        
    } completion:^(BOOL finished) {
        [self gestureAnimation:NO];
        
        CGRect frame = self.view.frame;
        
        frame.origin.x = 0;
        
        self.view.frame = frame;
        
        _isMoving = NO;
        
        self.backGroundView.hidden = YES;
    }];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self.screenShotList addObject:[self capture]];
//   [super pushViewController:viewController animated:animated];
}


#pragma mark - Utility Methods -
// get the current view screen shot
- (UIImage *)capture
{
    UIGraphicsBeginImageContextWithOptions(self.view.window.bounds.size, NO, 1.0);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// set lastScreenShotView 's position when paning
- (void)moveViewWithX:(float)x
{
    x = x>320?320:x;
    
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    // TODO
    lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float)+x*offset_float,0,320,MainScreenHeight};
}

- (void)gestureAnimation:(BOOL)animated {
    [self.screenShotList removeLastObject];
    [self.navigationController popViewControllerAnimated:animated];
}

#pragma mark - Gesture Recognizer -
- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer
{
    // If the viewControllers has only one vc or disable the interaction, then return.
    
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:self.view];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        
        startPoint = touchPoint;
        
        if (!self.backGroundView) {
            CGRect frame = self.view.frame;
            
            _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            
            _backGroundView.backgroundColor = [UIColor blackColor];
            
        }
        [self.view.superview insertSubview:self.backGroundView belowSubview:self.view];
        
        _backGroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        NSLog(@"%@",lastScreenShotView);
        
        UIImage *lastScreenShot = [self.screenShotList lastObject];
        
        lastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
        
        lastScreenShotView.frame = (CGRect){-(MainScreenWidth*offset_float),0,320,MainScreenHeight};
        
        [self.backGroundView addSubview:lastScreenShotView];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startPoint.x > min_distance)
        {
            [UIView animateWithDuration:0.3 animations:^{
                
                [self moveViewWithX:MainScreenWidth];
                
            } completion:^(BOOL finished) {
                [self gestureAnimation:NO];
                
                CGRect frame = self.view.frame;
                
                frame.origin.x = 0;
                
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                
                self.backGroundView.hidden = YES;
            }];
            
        }
        return;
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            
            self.backGroundView.hidden = YES;
        }];
        
        return;
    }
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startPoint.x];
    }
}



@end
