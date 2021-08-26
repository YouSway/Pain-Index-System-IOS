//
//  PaincurveListViewController.m
//  hurtPointBar
//
//  Created by 黃柏鈞 on 2016/3/13.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "PaincurveListViewController.h"
#import "UIDefine.h"

#import "PaincurveListViewController.h"
#import "PainrecordListViewController.h"
#import "PersonalinformationListViewController.h"
#import "CareteamListViewController.h"
#import "hurtPlaceViewController.h"
#import "UIDefine.h"

#import "CareteamListViewController.h"

#import "Webservice.h"
@interface PaincurveListViewController (){
     UIScrollView *mainScroll;
    PersonalinformationListViewController *Person;
    float point;

}
@property (strong, nonatomic) UISlider *hurtSlider;
@property (strong, nonatomic) UIImageView *pointImage;
@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIImageView *trackImage;


@end

@implementation PaincurveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //get screen info
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    point=0;
    
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -60, self.view.frame.size.width, self.view.frame.size.height-40-80+40)];
    mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 600);
    mainScroll.bounces = YES;
    mainScroll.scrollEnabled=NO;
    [self.view addSubview:mainScroll];

    
    
    //***pointImage***
    _pointImage=[[UIImageView alloc] init];
     _pointImage.image=[UIImage imageNamed:@"zeroten"];
    float h=[[UIImage imageNamed:@"zeroten"] size].height;
    float w=[[UIImage imageNamed:@"zeroten"] size].width;
    float hvsw=h/w;
    NSLog(@"HVSW:%f",hvsw);
    float autow=(aScreenRect.size.height*0.6+3-60)/hvsw;
    [_pointImage setFrame:CGRectMake(aScreenRect.size.width/3.2, 97, autow, aScreenRect.size.height*0.6+3-60 )];
   
    [mainScroll addSubview:_pointImage];

    
    //***slider***
    _hurtSlider=[[UISlider alloc] init];
    //convert to vertical
    self.hurtSlider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [_hurtSlider setFrame:CGRectMake(_pointImage.frame.size.width+_pointImage.frame.origin.x+20, 97, 20,aScreenRect.size.height*0.6+3-60 )];
    //position x,y,y,height
    
    //slider dot
    [_hurtSlider setThumbTintColor:RGBACOLOR(0,174,174,100)];
    [_hurtSlider setMinimumTrackTintColor:[UIColor grayColor]];
    
    //slide track
//    UIImage *sliderImage=[[UIImage imageNamed:@"nill"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
//    sliderTrack = [sliderImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 17, 0, 0)];
    
   [_hurtSlider setMinimumTrackTintColor:[UIColor clearColor]];
   [_hurtSlider setMaximumTrackTintColor:[UIColor clearColor]];
    
    _trackImage=[[UIImageView alloc]init];
    [_trackImage setFrame:CGRectMake(_pointImage.frame.size.width+_pointImage.frame.origin.x+20, 97, 20,aScreenRect.size.height*0.6+3 -60)];
    _trackImage.image=[UIImage imageNamed:@"line"];
    

    NSLog(@"%f , %f , %f , %f",_hurtSlider.frame.origin.x,_hurtSlider.frame.origin.y,_hurtSlider.frame.size.width,_hurtSlider.frame.size.height);
    
    //view
    [mainScroll addSubview:_trackImage];
    [mainScroll addSubview:_hurtSlider];
  
    
    //when sliderValueChanged
    [_hurtSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
     [_hurtSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpOutside];
    

    
    
    
    //***nextStep***
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-110,mainScroll.frame.size.height-40 ,220,40 )];
    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 100)];
    [self.view addSubview:_nextStep];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
}





-(IBAction)sliderValueChanged:(UISlider *)sender{
    
     if(sender.value<=0.05){sender.value=0;}
     else if (sender.value>0.05 & sender.value <=0.15) {sender.value=0.1;}
     else if (sender.value>0.15 & sender.value <=0.25) {sender.value=0.2;}
     else if (sender.value>0.25 & sender.value <=0.35) {sender.value=0.3;}
     else if (sender.value>0.35 & sender.value <=0.45) {sender.value=0.4;}
     else if (sender.value>0.45 & sender.value <=0.55) {sender.value=0.5;}
     else if (sender.value>0.55 & sender.value <=0.65) {sender.value=0.6;}
     else if (sender.value>0.65 & sender.value <=0.75) {sender.value=0.7;}
     else if (sender.value>0.75 & sender.value <=0.85) {sender.value=0.8;}
     else if (sender.value>0.85 & sender.value <=0.95) {sender.value=0.9;}
     else if (sender.value>0.95 & sender.value <=1) {sender.value=1;}
     else{sender.value=0;}
    point=sender.value;
    NSLog(@"slider value = %f",sender.value);
    NSLog(@"%@",[NSString stringWithFormat:@"%f",point*10]);
}


-(void)next{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:1 forKey:@"ggg"];
    [defaults synchronize];
    
    //
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-M-d";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date=[dateFormatter stringFromDate:now];
    NSLog(@"The Current Time is %@",date);
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *personInfo = [userDefaults dictionaryForKey:@"personInfo"];
    personInfo=[personInfo objectForKey:@"data"];
    
    NSArray*personInfo_ary;
    personInfo_ary=[personInfo objectForKey:@"item"];
    personInfo=[personInfo_ary objectAtIndex:0];
    NSString *mrn=[personInfo objectForKey:@"medical_record_number"];
    NSLog(@"%@",mrn);
    
    
        NSDictionary *dictParam = @{@"mrn":mrn,@"date":date,@"point":[NSString stringWithFormat:@"%f",point*10]};
        //    NSDictionary *result=[[NSDictionary alloc]init];
    
        [Webservice requestPostUrl:@"http://220.132.42.54:8888/dsl2501Stu/recordUpload.php" parameters:dictParam success:^(NSDictionary *responce) {
            //Success
            NSLog(@"responce:%@",responce);

        } failure:^(NSError *error) {
            //error
            NSLog(@"ERROR");
        }];
    

    
    //
    
    
    
    hurtPlaceViewController *nVC = [[hurtPlaceViewController alloc]init];
    //nVC.hidesBottomBarWhenPushed = NO;
    NSString *myString = [NSString stringWithFormat:@"%d", (int)(_hurtSlider.value*10)];
    nVC.Paincurve_value=myString;
    [self.navigationController pushViewController:nVC animated:YES];
    NSLog(@"catch");
    
   
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.title = @" 疼痛分數";
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
}
-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
