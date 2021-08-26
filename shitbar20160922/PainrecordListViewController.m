//
//  PainrecordListViewController.m
//  Loading
//
//  Created by user on 2016/3/13.
//  Copyright © 2016年 user. All rights reserved.
//

#import "PainrecordListViewController.h"
#import "Webservice.h"
#import "PNLineChartView.h"
#import "MBProgressHUD.h"
#import "PNPlot.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HEXCOLOR(hex) [UIColor UIColorFromRGB(hex)]
#define DebugLog(message, ...) NSLog(@"%s: " message, __PRETTY_FUNCTION__, ##__VA_ARGS__)

@interface PainrecordListViewController (){
    //UIScrollView *mainScroll;
    float linew;
    int hhh;
    int www;
    int dhh;
    int dww;
    int dhh2;
    int dww2;
    int ds;
    
    
    NSString *c_mrn; //病歷號

    
}

@property (strong, nonatomic) PNLineChartView *lineChartView;


@end

@implementation PainrecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取得螢幕資料
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    if(aScreenRect.size.height >= 736)
    {
        dhh = -5;
        dww = 270;
        dhh2 = 32;
        dww2 = 350;
        ds = 10;
    }else if(aScreenRect.size.height >= 667)
    {
        dhh = -5;
        dww = 220;
        dhh2 = 30;
        dww2 = 297;
        ds = 10;
    }
    else if (aScreenRect.size.height < 667)
    {
        dhh = -5;
        dww = 150;
        dhh2 = 25;
        dww2 = 222;
        ds = 9;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:aScreenRect.size.height forKey:@"HighScore"];
    [defaults setInteger:aScreenRect.size.width forKey:@"WidthScore"];
    [defaults synchronize];
    // Do any additional setup after loading the view, typically from a nib.
    
    //_lineChartView = [[PNLineChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, self.view.frame.size.height-100)];
    
    
    
    /*mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, aScreenRect.size.height-60)];
     mainScroll.backgroundColor = [UIColor whiteColor];
     mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 600);
     mainScroll.bounces = YES;
     [self.view addSubview:mainScroll];*/
    
    c_mrn = @"0936330116";
    
    NSDictionary *dictParam = @{@"mrn":c_mrn};
    //    NSDictionary *result=[[NSDictionary alloc]init];
    

    [Webservice requestPostUrl:@"http://220.132.42.54:8888/dsl2501Stu/record.php" parameters:dictParam success:^(NSDictionary *responce) {
        //Success
        NSDictionary *record_info = [responce objectForKey:@"data"];
        NSString *suc = [record_info objectForKey:@"success"];
        
        
        if([suc isEqualToString:@"true"]){
        

            NSDictionary *record = [record_info objectForKey:@"record"];
            NSUInteger *record_c = record.count;
            NSLog(@"record:%@",record);
            NSLog(@"record_c:%d",record_c);
            
            

            NSArray *day7[7];
            NSArray *point[7];
            
            
            
            
            
            
            for(int i=0;i<7;i++)
            {
                
                NSDate *now = [[NSDate alloc] initWithTimeInterval:-86400*i sinceDate:[NSDate date]];;
                NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                [outputFormatter setDateFormat:@"MM/dd"];
                NSString *newDateString = [outputFormatter stringFromDate:now];
                
                day7[i] = newDateString;
                

                for(int j=0;j<record_c;j++){
                    
                    NSArray *record_d = record;
                    NSDictionary *record_d_info = record_d[j];
                    NSString *newDateString_d = [[record_d_info objectForKey:@"record_date"] substringWithRange:NSMakeRange(5, 2)];
                    NSString *newDateString_d2 = [[record_d_info objectForKey:@"record_date"] substringWithRange:NSMakeRange(8, 2)];
                    
                    NSString *newDateString_d3 = [newDateString_d stringByAppendingString:@"/"];
                    NSString *newDateString_d4 = [newDateString_d3 stringByAppendingString:newDateString_d2];
                    NSLog(@"record_d:%@",newDateString_d4);

           
                    if([newDateString isEqualToString:newDateString_d4]){
                        
                        point[i] = @[[record_d_info objectForKey:@"pain_point"]];
                        
                    }
                    
                    
                }
                
            }
            
            
            
            _lineChartView = [[PNLineChartView alloc]init];
            _lineChartView.frame = CGRectMake(-40-(aScreenRect.size.height-568)*0.2, 170, 390+(aScreenRect.size.height-568), 250+(aScreenRect.size.height-568)*0.8);
            _lineChartView.backgroundColor = [UIColor whiteColor];
            _lineChartView.transform = CGAffineTransformMakeRotation(M_PI_2 * 1);
            _lineChartView.userInteractionEnabled = YES;
            
            NSDictionary *dct = @{@"data":@"helloworld"};
            _lineChartView.hurtData = dct;
            
            
            // test line chart
            NSArray* plottingDataValues1 = point[0];
            NSArray* plottingDataValues2 = point[1];
            NSArray* plottingDataValues3 = point[2];
            NSArray* plottingDataValues4 = point[3];
            NSArray* plottingDataValues5 = point[4];
            NSArray* plottingDataValues6 = point[5];
            NSArray* plottingDataValues7 = point[6];
            
            self.lineChartView.max = 10;
            self.lineChartView.min = 0;
            
            
            self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/10;
            
            NSMutableArray* yAxisValues = [@[] mutableCopy];
            
            for (int i=0; i<11; i++) {
                NSString* str = [NSString stringWithFormat:@"%i", self.lineChartView.min+self.lineChartView.interval*i];
                [yAxisValues addObject:str];
            }
            
            self.lineChartView.xAxisValues = @[ day7[6], day7[5], day7[4],day7[3], day7[2], day7[1], day7[0]];
            self.lineChartView.yAxisValues = yAxisValues;
            self.lineChartView.axisLeftLineWidth = aScreenRect.size.height/14.5;
            
            
            PNPlot *plot1 = [[PNPlot alloc] init];
            plot1.plottingValues = plottingDataValues1;
            plot1.plottingValues2 = plottingDataValues2;
            plot1.plottingValues3 = plottingDataValues3;
            plot1.plottingValues4 = plottingDataValues4;
            plot1.plottingValues5 = plottingDataValues5;
            plot1.plottingValues6 = plottingDataValues6;
            plot1.plottingValues7 = plottingDataValues7;
            
            plot1.lineColor = RGBACOLOR(0, 170, 201, 1);
            
            if(aScreenRect.size.height > 600)
            {
                linew = 0.8;
            }else{
                linew = 0.5;
            }
            plot1.lineWidth = linew;
            
            [self.lineChartView addPlot:plot1];
            
            
            ////////////
            
            
            
            //上頭的註解
            CGRect labelFrame = CGRectMake(0, 64 , 500, 20);
            UILabel *titleback = [[UILabel alloc] initWithFrame:labelFrame];
            [titleback setTextColor:[UIColor blackColor]];
            UIColor *bg = RGBACOLOR(237, 237, 237, 1);
            [titleback setBackgroundColor:bg];
            [self.view addSubview:titleback];
            
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, 500, 20)];
            title.textColor = RGBACOLOR(150, 150, 150, 1);
            title.text = @"以下為過去七天內疼痛狀況曲線圖表";
            [title setFont:[UIFont fontWithName:@"Helvetica" size:9]];
            [self.view addSubview:title];
            
            
            UITextView *label = [[UITextView alloc] init];
            [label setFrame:CGRectMake(dhh, dww, 20, 100)];
            [label setFont:[UIFont fontWithName:@"Helvetica" size:ds]];
            [label setText:@"疼\n痛\n指\n數\n︵\n分\n︶\n"];
            
            UILabel *label2 = [[UITextView alloc] init];
            [label2 setFrame:CGRectMake(dhh2, dww2, 40, 20)];
            [label2 setFont:[UIFont fontWithName:@"Helvetica" size:ds]];
            [label2 setText:@"日期"];
            
            
            [self.view addSubview:_lineChartView];
            [_lineChartView addSubview:label2];
            [_lineChartView addSubview:label];
            

        
        }else{
            NSLog(@"ERROR");
        }
        
        
        
    } failure:^(NSError *error) {
        //error
        NSLog(@"ERROR");
    }];

    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
