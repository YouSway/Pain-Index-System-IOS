//
//  ViewController.m
//  hurtPointBar
//
//  Created by 黃柏鈞 on 2016/3/13.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "currentlyMoodViewController.h"
#import "sleepQualityViewController.h"
#import "UIDefine.h"

@interface currentlyMoodViewController (){
    UIScrollView *mainScroll;
    
    
}
@property (strong, nonatomic) UISlider *hurtSlider;
@property (strong, nonatomic) UIImageView *pointImage;
@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIImageView *trackImage;

@end

@implementation currentlyMoodViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height-40-80)];
    mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 600);
    mainScroll.bounces = YES;
    mainScroll.scrollEnabled=NO;
    [self.view addSubview:mainScroll];

    
    
    CGRect labelFrame = CGRectMake(0, 20 , 500, 20);
    UILabel *titleback = [[UILabel alloc] initWithFrame:labelFrame];
    [titleback setTextColor:[UIColor blackColor]];
    UIColor *bg = RGBACOLOR(237, 237, 237, 1);
    [titleback setBackgroundColor:bg];
    [self.view addSubview:titleback];
    
    
    CGRect labelFrame2 = CGRectMake(10, 20 , 500, 20);
    UILabel *titletext = [[UILabel alloc] initWithFrame:labelFrame2];
    titletext.textColor = RGBACOLOR(150, 150, 150, 1);
    titletext.text = @"【可複選】您現在的心情狀況";
    [titletext setFont:[UIFont fontWithName:@"Helvetica" size:9]];
    [self.view addSubview:titletext];
    
    self.tabBarController.title = @" 目前心情";
    
    //第一列
    UIButton *chkBtn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn11 setFrame:CGRectMake(aScreenRect.size.width/2-80/2-100, 80, 80, 80)];
    [chkBtn11 setImage:[UIImage imageNamed:@"gloomy"]
              forState:UIControlStateNormal];
    [chkBtn11 setImage:[UIImage imageNamed:@"redgloomy"]
              forState:UIControlStateSelected];
    [chkBtn11 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chkBtn11];
    
    
    UIButton *chkBtn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn12 setFrame:CGRectMake(aScreenRect.size.width/2-80/2, chkBtn11.frame.origin.y, 80, 80)];
    [chkBtn12 setImage:[UIImage imageNamed:@"afraid"]
              forState:UIControlStateNormal];
    [chkBtn12 setImage:[UIImage imageNamed:@"redafraid"]
              forState:UIControlStateSelected];
    [chkBtn12 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chkBtn12];
    
    
    UIButton *chkBtn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn13 setFrame:CGRectMake(chkBtn12.frame.origin.x+100, chkBtn12.frame.origin.y, 80, 80)];
    [chkBtn13 setImage:[UIImage imageNamed:@"angry"]
              forState:UIControlStateNormal];
    [chkBtn13 setImage:[UIImage imageNamed:@"redangry"]
              forState:UIControlStateSelected];
    [chkBtn13 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chkBtn13];
    
    
    
    //第二列
    UIButton *chkBtn21 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn21 setFrame:CGRectMake(chkBtn11.frame.origin.x, chkBtn11.frame.origin.y+100, 80, 80)];
    [chkBtn21 setImage:[UIImage imageNamed:@"garyjoy"]
              forState:UIControlStateNormal];
    [chkBtn21 setImage:[UIImage imageNamed:@"joy"]
              forState:UIControlStateSelected];
    [chkBtn21 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chkBtn21];
    
    
    UIButton *chkBtn22 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn22 setFrame:CGRectMake(chkBtn21.frame.origin.x+100, chkBtn21.frame.origin.y, 80, 80)];
    [chkBtn22 setImage:[UIImage imageNamed:@"nervous"]
              forState:UIControlStateNormal];
    [chkBtn22 setImage:[UIImage imageNamed:@"rednervous"]
              forState:UIControlStateSelected];
    [chkBtn22 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chkBtn22];
    
    
    
    
    
    
    //***nextStep***
    //***nextStep***
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-110,mainScroll.frame.size.height,220,40 )];
    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 100)];
    [self.view addSubview:_nextStep];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    

    
}

-(void)next{
    NSLog(@"catch");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:8 forKey:@"ggg"];
    [defaults synchronize];
    
    
    sleepQualityViewController  *nVC = [[sleepQualityViewController alloc]init];
    [self.navigationController pushViewController:nVC animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //    self.navigationItem.leftBarButtonItem = left;
    self.tabBarController.navigationItem.leftBarButtonItem = left;
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)chkBtnHandler:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
