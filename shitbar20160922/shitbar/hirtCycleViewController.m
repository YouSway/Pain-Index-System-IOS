//
//  ViewController.m
//  hurtHandle_LTS
//
//  Created by 黃柏鈞 on 2016/4/23.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "hirtCycleViewController.h"
#import "UIDefine.h"
#import "CHTTextView.h"
#import "hurtHandleViewController.h"
#import "hurtCycle2ViewController.h""
@interface hirtCycleViewController (){
    UIScrollView *mainScroll;
    UILabel *tableDrugHandleLabel;
    UILabel *tableDrugHandle;
    UILabel *noDrugHandleLable;
    UIButton *chkBtn11;
    UIButton *chkBtn12;
    UIButton *chkBtn13;
    UIButton *chkBtn21;
    UIButton *chkBtn22;
    UIButton *chkBtn23;
    
    UIImageView *block;
    CHTTextView *typeSpace;
    
    UIButton *recordid;
    UIButton *recordid2;
    int selectPage;
    
    NSUserDefaults *defaults;
    
}
@property (strong, nonatomic) UIButton *nextStep;

@end

@implementation hirtCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //get screen infromation
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    
    //
    NSLog(@"Paincurve_value:%@",self.Paincurve_value);
    NSLog(@"hurtPlace_value:%@",self.hurtPlace_value);
    NSLog(@"hurtType_value:%@",self.hurtType_value);
    
    
    
    /*------frame------*/
    
    //scroll view
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height-40-80)];
    mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 600);
    mainScroll.bounces = YES;
    mainScroll.scrollEnabled=NO;
    
    //bgcolor
    //self.view.backgroundColor=[UIColor redColor];
    self.view.backgroundColor=RGBACOLOR(248, 248, 248, 1);
    mainScroll.backgroundColor=RGBACOLOR(248, 248, 248, 1);
    [self.view addSubview:mainScroll];
    
    //tableDrugHandleLabel
    tableDrugHandleLabel=[[UILabel alloc]init];
    [tableDrugHandleLabel setFrame:CGRectMake(0,20, aScreenRect.size.width,35)];
    tableDrugHandleLabel.text=@"  【單選】整天或間歇性疼痛";
    tableDrugHandleLabel.textColor=RGBACOLOR(132, 132, 132, 1);
    tableDrugHandleLabel.backgroundColor=RGBACOLOR(238, 238, 238, 1);
    [mainScroll addSubview:tableDrugHandleLabel];
    
    //tableDrugHandleLabel
    tableDrugHandle=[[UILabel alloc] init];
    [tableDrugHandle setFrame:CGRectMake(0, tableDrugHandleLabel.frame.origin.y+tableDrugHandleLabel.frame.size.height, aScreenRect.size.width, 70)];
    tableDrugHandle.text=@"             整天持續性疼痛";
    tableDrugHandle.textColor=RGBACOLOR(132, 132, 132, 1);
    tableDrugHandle.backgroundColor=RGBACOLOR(255, 255, 255, 1);
    [mainScroll addSubview:tableDrugHandle];
    
    //notableDrugHandleLabel
    noDrugHandleLable=[[UILabel alloc]init];
    [noDrugHandleLable setFrame:CGRectMake(0,tableDrugHandle.frame.origin.y+tableDrugHandle.frame.size.height,aScreenRect.size.width,70)];
    noDrugHandleLable.text=@"             間歇性疼痛";
    noDrugHandleLable.textColor=RGBACOLOR(132, 132, 132, 1);
    noDrugHandleLable.backgroundColor=RGBACOLOR(255, 255, 255, 1);
    [mainScroll addSubview:noDrugHandleLable];
    
    self.tabBarController.title = @" 疼痛周期";
    
    //make line
    UIBezierPath *tableLine =[UIBezierPath bezierPath];
    //make line layer
    CAShapeLayer *layer=[CAShapeLayer layer];
    [tableLine moveToPoint:CGPointMake(0, 55.5-35)];
    [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 55.5-35)];
    [tableLine moveToPoint:CGPointMake(0, 55.5)];
    [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 55.5)];
    [tableLine moveToPoint:CGPointMake(0, 55.5+70)];
    [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 55.5+70)];
    [tableLine moveToPoint:CGPointMake(0, 55.5+70+70)];
    [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 55.5+70+70)];
    layer.path=[tableLine CGPath];
    layer.strokeColor=[[UIColor grayColor]CGColor];
    layer.lineWidth=0.25;
    //layer.fillColor=[[UIColor blackColor]CGColor];
    //show line
    [mainScroll.layer addSublayer:layer];
    
    /*------obj------*/
    
    //next step
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-110,mainScroll.frame.size.height ,220,40 )];
    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 100)];
    [self.view addSubview:_nextStep];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    //chk btn
    recordid = [UIButton buttonWithType:UIButtonTypeCustom];
    recordid.tag=1;
    [recordid setFrame:CGRectMake(20, tableDrugHandle.frame.origin.y+40/2, 30, 30)];
    [recordid setImage:[UIImage imageNamed:@"empty"]
              forState:UIControlStateNormal];
    [recordid setImage:[UIImage imageNamed:@"redyes"]
              forState:UIControlStateSelected];
    [recordid addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:recordid];
    
    //chk btnㄉ
    recordid2 = [UIButton buttonWithType:UIButtonTypeCustom];
    recordid.tag=2;
    [recordid2 setFrame:CGRectMake(20, tableDrugHandle.frame.origin.y+40/2+70, 30, 30)];
    [recordid2 setImage:[UIImage imageNamed:@"empty"]
               forState:UIControlStateNormal];
    [recordid2 setImage:[UIImage imageNamed:@"redyes"]
               forState:UIControlStateSelected];
    [recordid2 addTarget:self
                  action:@selector(chkBtnHandler2:)
        forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:recordid2];
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    
    
    
}

-(void)next{
        NSLog(@"selectPage:%d",selectPage);
    
    
    
    
    hurtHandleViewController *nVC = [[hurtHandleViewController  alloc]init];
    //[self.navigationController pushViewController:nVC animated:YES];
    hurtCycle2ViewController *nVC2 = [[hurtCycle2ViewController  alloc]init];
    //[self.navigationController pushViewController:nVC2 animated:YES];
    

    
    switch (selectPage) {
        case 1:
            

            [defaults setInteger:4 forKey:@"ggg"];
            [defaults synchronize];
            
            nVC.Paincurve_value=self.Paincurve_value;
            nVC.hurtPlace_value=self.hurtPlace_value;
            nVC.hurtType_value=self.hurtType_value;
            nVC.hurtCycle_value=@"1";
            
            
            [self.navigationController pushViewController:nVC animated:YES];
            break;
        
        case 2:
            

            [defaults setInteger:6 forKey:@"ggg"];
            [defaults synchronize];
            
            
            nVC2.Paincurve_value=self.Paincurve_value;
            nVC2.hurtPlace_value=self.hurtPlace_value;
            nVC2.hurtType_value=self.hurtType_value;
            nVC2.hurtCycle_value=@"2";
            
            [self.navigationController pushViewController:nVC2 animated:YES];
            break;
            
        default:
            NSLog(@"no select");
            break;
    }
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //    self.navigationItem.leftBarButtonItem = left;
    self.tabBarController.navigationItem.leftBarButtonItem = left;
}


- (void)chkBtnHandler:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    
    UIButton *btn=sender;
    if (btn.selected==YES){
        NSLog(@"selected");
        tableDrugHandle.backgroundColor=RGBACOLOR(248, 248, 248, 1);
        noDrugHandleLable.backgroundColor=RGBACOLOR(255, 255, 255, 1);
        recordid2.selected=NO;
        selectPage=1;
    }
    else{
        tableDrugHandle.backgroundColor=RGBACOLOR(255, 255, 255, 1);
        selectPage=3;

    }
    
    
    
}

- (void)chkBtnHandler2:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    
    UIButton *btn=sender;
    if (btn.selected==YES){
        NSLog(@"selected");
        noDrugHandleLable.backgroundColor=RGBACOLOR(248, 248, 248, 1);
        tableDrugHandle.backgroundColor=RGBACOLOR(255, 255, 255, 1);
        recordid.selected=NO;
        selectPage=2;
    }
    else{
        noDrugHandleLable.backgroundColor=RGBACOLOR(255, 255, 255, 1);
        selectPage=3;

    }
    
}




-(CGRect)autoImageSize:(NSString*)imageName withsecond: (float)rate{
    //get screen info
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    //CGFloat height = aScreenRect.size.height;
    
    //使用圖片需佔畫面多少百分比計算（用寬）(百分比已知)
    //image_W*rate
    
    //用得出的寬去推高
    //imageRate=image_W/image_H
    //imageRate=imagew/image_h
    //W:H=w:h
    //Hw=Wh
    //H/W=h/w
    //H/W*w=h
    
    
    //define image size
    float theNewWidth=width*rate;//screenWidth/screenHeight*rate
    float ImageWidth=[[UIImage imageNamed:imageName] size].width;
    float ImageHeight=[[UIImage imageNamed:imageName] size].height;
    
    //find image_w height
    float theNewHeight=ImageHeight/ImageWidth*theNewWidth;
    
    //save in a CGrect
    CGRect rsCGRect=CGRectMake(0,0,theNewWidth,theNewHeight);
    return rsCGRect;
    
    //call:
    /*
     CGRect mytest=[self autoImageSize:@"painselfmanagement" withsecond:0.55];
     NSLog(@"Width:%f",mytest.size.width);
     NSLog(@"Height:%f",mytest.size.height);
     */
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
