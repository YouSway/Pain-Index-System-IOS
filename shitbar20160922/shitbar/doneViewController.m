//
//  ViewController.m
//  hurtPointBar
//
//  Created by 黃柏鈞 on 2016/3/13.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "doneViewController.h"
#import "UIDefine.h"

@interface doneViewController (){
    
    
}
@property (strong, nonatomic) UISlider *hurtSlider;
@property (strong, nonatomic) UIImageView *pointImage;
@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIImageView *trackImage;

@end

@implementation doneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *logoImage = [[UIImageView alloc] init];
    [logoImage setImage:[UIImage imageNamed:@"congratulation"]];
    [logoImage setFrame:CGRectMake(aScreenRect.size.width/2-(aScreenRect.size.width-20)/2, 65, aScreenRect.size.width-20, 170)];
    [self.view addSubview:logoImage];
    
    
    
    //***nextStep***
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-180/2, logoImage.frame.origin.y+200, 180, 40)];
    [_nextStep setTitle:@"觀看疼痛曲線圖" forState:UIControlStateNormal];
    _nextStep.layer.cornerRadius = 5;
    [_nextStep setBackgroundColor:RGBACOLOR(255, 70, 101, 1)];
    [_nextStep addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_nextStep];
    
    self.tabBarController.title = @" 填寫完成";
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(hasDone) //接收到該Notification時要call的function
     name:@"hasDone"
     object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jump{
    NSLog(@"jump");
//
    self.tabBarController.title = @" 疼痛曲線";
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    
    self.tabBarController.selectedIndex = 3;
}

-(void)hasDone{
    NSLog(@"FFFFF");
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:@"hasDone"
     object:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
