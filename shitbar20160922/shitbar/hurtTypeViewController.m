//
//  ViewController.m
//  hurtPointBar
//
//  Created by 黃柏鈞 on 2016/3/13.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "hurtTypeViewController.h"
#import "hirtCycleViewController.h"
#import "UIDefine.h"

@interface hurtTypeViewController (){
    UIScrollView *mainScroll;
    
}
@property (strong, nonatomic) UISlider *hurtSlider;
@property (strong, nonatomic) UIImageView *pointImage;
@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIImageView *trackImage;

@end

@implementation hurtTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Paincurve_value:%@",self.Paincurve_value);
    NSLog(@"hurtPlace_value:%@",self.hurtPlace_value);

    self.view.backgroundColor=[UIColor whiteColor];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height-40-80)];
    mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 80*4+150);
    mainScroll.bounces = YES;
    //mainScroll.scrollEnabled=NO;
    [self.view addSubview:mainScroll];
    
    CGRect labelFrame = CGRectMake(0, 20 , 500, 20);
    UILabel *titleback = [[UILabel alloc] initWithFrame:labelFrame];
    [titleback setTextColor:[UIColor blackColor]];
    UIColor *bg = RGBACOLOR(237, 237, 237, 1);
    [titleback setBackgroundColor:bg];
    [mainScroll addSubview:titleback];
    
    
    CGRect labelFrame2 = CGRectMake(10, 20 , 500, 20);
    UILabel *titletext = [[UILabel alloc] initWithFrame:labelFrame2];
    titletext.textColor = RGBACOLOR(150, 150, 150, 1);
    titletext.text = @"【可複選】疼痛的性質狀況";
    [titletext setFont:[UIFont fontWithName:@"Helvetica" size:9]];
    [mainScroll addSubview:titletext];
    
    self.tabBarController.title = @" 疼痛性質";
    
    //int space=(aScreenRect.size.width-80*3)/4;
    int space=100;
    //第一列
    UIButton *chkBtn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn11 setFrame:CGRectMake(aScreenRect.size.width/2-80/2-space, 85-25, 80, 80)];
    [chkBtn11 setImage:[UIImage imageNamed:@"needlestick"]
              forState:UIControlStateNormal];
    [chkBtn11 setImage:[UIImage imageNamed:@"redneedlestick"]
              forState:UIControlStateSelected];
    [chkBtn11 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn11];
    
    
    UIButton *chkBtn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn12 setFrame:CGRectMake(aScreenRect.size.width/2-80/2, chkBtn11.frame.origin.y, 80, 80)];
    [chkBtn12 setImage:[UIImage imageNamed:@"stabwounds"]
              forState:UIControlStateNormal];
    [chkBtn12 setImage:[UIImage imageNamed:@"redstabwounds"]
              forState:UIControlStateSelected];
    [chkBtn12 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn12];
    
    
    UIButton *chkBtn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn13 setFrame:CGRectMake(chkBtn12.frame.origin.x+space, chkBtn12.frame.origin.y, 80, 80)];
    [chkBtn13 setImage:[UIImage imageNamed:@"burning"]
              forState:UIControlStateNormal];
    [chkBtn13 setImage:[UIImage imageNamed:@"redburning"]
              forState:UIControlStateSelected];
    [chkBtn13 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn13];
    
    
    
    //第二列
    UIButton *chkBtn21 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn21 setFrame:CGRectMake(chkBtn11.frame.origin.x, chkBtn11.frame.origin.y+space, 80, 80)];
    [chkBtn21 setImage:[UIImage imageNamed:@"garypresstenderness"]
              forState:UIControlStateNormal];
    [chkBtn21 setImage:[UIImage imageNamed:@"presstenderness"]
              forState:UIControlStateSelected];
    [chkBtn21 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn21];
    
    
    UIButton *chkBtn22 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn22 setFrame:CGRectMake(chkBtn21.frame.origin.x+space, chkBtn21.frame.origin.y, 80, 80)];
    [chkBtn22 setImage:[UIImage imageNamed:@"stuffypain"]
              forState:UIControlStateNormal];
    [chkBtn22 setImage:[UIImage imageNamed:@"redstuffypain"]
              forState:UIControlStateSelected];
    [chkBtn22 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn22];
    
    
    UIButton *chkBtn23 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn23 setFrame:CGRectMake(chkBtn22.frame.origin.x+space, chkBtn22.frame.origin.y, 80, 80)];
    [chkBtn23 setImage:[UIImage imageNamed:@"languid"]
              forState:UIControlStateNormal];
    [chkBtn23 setImage:[UIImage imageNamed:@"redlanguid"]
              forState:UIControlStateSelected];
    [chkBtn23 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn23];
    
    
    
    //第三列
    UIButton *chkBtn31 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn31 setFrame:CGRectMake(chkBtn21.frame.origin.x, chkBtn21.frame.origin.y+space, 80, 80)];
    [chkBtn31 setImage:[UIImage imageNamed:@"pain"]
              forState:UIControlStateNormal];
    [chkBtn31 setImage:[UIImage imageNamed:@"redpain"]
              forState:UIControlStateSelected];
    [chkBtn31 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn31];
    
    
    UIButton *chkBtn32 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn32 setFrame:CGRectMake(chkBtn31.frame.origin.x+space, chkBtn31.frame.origin.y, 80, 80)];
    [chkBtn32 setImage:[UIImage imageNamed:@"graylancinating"]
              forState:UIControlStateNormal];
    [chkBtn32 setImage:[UIImage imageNamed:@"lancinating"]
              forState:UIControlStateSelected];
    [chkBtn32 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn32];
    
    
    UIButton *chkBtn33 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn33 setFrame:CGRectMake(chkBtn32.frame.origin.x+space, chkBtn32.frame.origin.y, 80, 80)];
    [chkBtn33 setImage:[UIImage imageNamed:@"mama"]
              forState:UIControlStateNormal];
    [chkBtn33 setImage:[UIImage imageNamed:@"redmama"]
              forState:UIControlStateSelected];
    [chkBtn33 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn33];
    
    
    
    //第四列
    UIButton *chkBtn41 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn41 setFrame:CGRectMake(chkBtn31.frame.origin.x, chkBtn31.frame.origin.y+space, 80, 80)];
    [chkBtn41 setImage:[UIImage imageNamed:@"tickle"]
              forState:UIControlStateNormal];
    [chkBtn41 setImage:[UIImage imageNamed:@"redtickle"]
              forState:UIControlStateSelected];
    [chkBtn41 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn41];
    
    
    UIButton *chkBtn42 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn42 setFrame:CGRectMake(chkBtn41.frame.origin.x+space, chkBtn41.frame.origin.y, 80, 80)];
    [chkBtn42 setImage:[UIImage imageNamed:@"touchonlypain"]
              forState:UIControlStateNormal];
    [chkBtn42 setImage:[UIImage imageNamed:@"redtouchonlypain"]
              forState:UIControlStateSelected];
    [chkBtn42 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn42];
    
    
    UIButton *chkBtn43 = [UIButton buttonWithType:UIButtonTypeCustom];
    [chkBtn43 setFrame:CGRectMake(chkBtn42.frame.origin.x+space, chkBtn42.frame.origin.y, 80, 80)];
    [chkBtn43 setImage:[UIImage imageNamed:@"electricshock"]
              forState:UIControlStateNormal];
    [chkBtn43 setImage:[UIImage imageNamed:@"redelectricshock"]
              forState:UIControlStateSelected];
    [chkBtn43 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn43];
    
    //tag
    /*
    chkBtn11.tag=11;
    chkBtn12.tag=12;
    chkBtn13.tag=13;
    chkBtn21.tag=21;
    chkBtn22.tag=22;
    chkBtn23.tag=23;
    chkBtn31.tag=31;
    chkBtn32.tag=32;
    chkBtn33.tag=33;
    chkBtn41.tag=41;
    chkBtn42.tag=42;
    chkBtn43.tag=43;
    */
    chkBtn11.tag=1;
    chkBtn12.tag=2;
    chkBtn13.tag=3;
    chkBtn21.tag=4;
    chkBtn22.tag=5;
    chkBtn23.tag=6;
    chkBtn31.tag=7;
    chkBtn32.tag=8;
    chkBtn33.tag=9;
    chkBtn41.tag=10;
    chkBtn42.tag=11;
    chkBtn43.tag=12;

    
    
    //***nextStep***
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-110,mainScroll.frame.size.height ,220,40 )];

    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 100)];
    [self.view addSubview:_nextStep];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//    self.navigationItem.leftBarButtonItem = left;
    self.tabBarController.navigationItem.leftBarButtonItem = left;
}

NSString *output;
-(void)next{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:3 forKey:@"ggg"];
    [defaults synchronize];
    
    
    NSLog(@"catch");
    hirtCycleViewController *nVC = [[hirtCycleViewController  alloc]init];
    nVC.Paincurve_value=self.Paincurve_value;
    nVC.hurtPlace_value=self.hurtPlace_value;
    nVC.hurtType_value=output;
    
    [self.navigationController pushViewController:nVC animated:YES];
    
    
    
}
int rec[13]={0,0,0,0,0,0,0,0,0,0,0,0,0};
- (void)chkBtnHandler:(id)sender{
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    
    //REC INFO
     UIButton* btn = sender;
    //NSLog(@"TAG:%ld",(long)btn.tag);
  
    if (btn.selected==YES) {
        rec[btn.tag]=1;
    }
    else{
        rec[btn.tag]=0;
    }
    
    NSString *intToString;
    output=@"v";
    for (int i=1; i<=12; i++) {
        //NSLog(@"%d",rec[i]);
        intToString = [NSString stringWithFormat:@"%d", rec[i]];
        
        output = [output stringByAppendingString:intToString];
        
    }
    NSLog(@"%@",output);
    
    
}

-(void)viewWillAppear{
    //重新洗白
    for(int i=0; i<=12; i++){
        rec[i]=0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
