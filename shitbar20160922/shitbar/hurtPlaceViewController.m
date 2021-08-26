//
//  ViewController.m
//  getColor
//
//  Created by 胡陞銘 on 2016/3/24.
//  Copyright (c) 2016年 Sheng,Ming. All rights reserved.
//

#import "hurtPlaceViewController.h"
#import "UIDefine.h"
#import "hurtTypeViewController.h"
//#import "ColorPickerImageView.h"

@interface hurtPlaceViewController (){
    UIImageView *bodyView;
    UIImageView *addImgView;
    UIButton *switchBody;
    
    int itemCount;
    
    CGPoint pointRecord[200];
    int pointRecordCount;
    
    CGPoint pointRecord2[200];
    int pointRecordCount2;
    bool clearCheck;
    
    NSUserDefaults *defaults;
    
}
@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIButton *cleanCross;
@property (strong, nonatomic) UIButton *allHurt;

@end

@implementation hurtPlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Paincurve_value:%@",self.Paincurve_value);
    
    [self setUpBar];
    self.view.backgroundColor=[UIColor whiteColor];
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    //    self.navigationItem.leftBarButtonItem = left;
    //
    //
    //    self.title = @"aslfhalghewli";
    //
    itemCount = 0;
    pointRecordCount=0;
    pointRecordCount2=0;
    clearCheck=false;
    
    // Do any additional setup after loading the view, typically from a nib.
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGRect body=[self autoImageSize:@"grayboyp" withsecond:0.5];
    
    bodyView = [[UIImageView alloc]initWithFrame:CGRectMake(aScreenRect.size.width/2-body.size.width/2, 90, body.size.width, body.size.height)];
    [bodyView setImage:[UIImage imageNamed:@"grayboyp"]];
    bodyView.userInteractionEnabled = YES;
    
    [self.view addSubview:bodyView];
    
    
    

    //    UITapGestureRecognizer *oneFingerTwoTaps = [[UITapGestureRecognizer alloc]initWithTarget:self action:nil];
    //
    //    //    UITapGestureRecognizer *oneFingerTwoTaps = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerTwoTaps)] autorelease];
    //    oneFingerTwoTaps.delegate=self;
    //    // Set required taps and number of touches
    //    [oneFingerTwoTaps setNumberOfTapsRequired:1];
    //    [oneFingerTwoTaps setNumberOfTouchesRequired:1];
    //    [[self view] addGestureRecognizer:oneFingerTwoTaps];
    
    //觸碰
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //    [bodyView addGestureRecognizer:tap];
    //tap.delegate = self;
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    
    [bodyView addGestureRecognizer:tap];
    
    
    //***nextStep***
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-(95/2)+100, 97+aScreenRect.size.height*0.6+3+20, 95, 40)];
    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 100)];
    [self.view addSubview:_nextStep];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    _cleanCross=[[UIButton alloc] init];
    _cleanCross=[UIButton buttonWithType:UIButtonTypeCustom];
    [_cleanCross setFrame:CGRectMake(aScreenRect.size.width/2-(95/2), 97+aScreenRect.size.height*0.6+3+20, 95, 40)];
    [_cleanCross setTitle:@"正面全身痛" forState:UIControlStateNormal];
    [_cleanCross setBackgroundColor:RGBACOLOR(255, 90, 144, 100)];
    _cleanCross.tag=3;
    [_cleanCross addTarget:self
                   action:@selector(chkBtnHandler:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cleanCross];
    
    
    _allHurt=[[UIButton alloc] init];
    _allHurt=[UIButton buttonWithType:UIButtonTypeCustom];
    [_allHurt setFrame:CGRectMake(aScreenRect.size.width/2-(95/2)-100, 97+aScreenRect.size.height*0.6+3+20, 95, 40)];
    [_allHurt setTitle:@"清除記號" forState:UIControlStateNormal];
    [_allHurt setBackgroundColor:RGBACOLOR(102, 102, 102, 1)];
    [self.view addSubview:_allHurt];
    _allHurt.tag=4;
    [_allHurt addTarget:self action:@selector(chkBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
    //[_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *img =[[UIImageView alloc]init];
    CGRect imgwh=[self autoImageSize:@"box" withsecond:0.3];
    [img setFrame:CGRectMake(20, 95, imgwh.size.width, imgwh.size.height)];
    [img setImage:[UIImage imageNamed:@"box"]];
    [self.view addSubview:img];
    
    
    switchBody=[[UIButton alloc]init];
    [switchBody setFrame:CGRectMake(aScreenRect.size.width-90+7, aScreenRect.size.height/2-85, 65, 65)];
   
    switchBody.tag=2;
    [switchBody setImage:[UIImage imageNamed:@"circle"]
              forState:UIControlStateNormal];
    [switchBody addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:switchBody];
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    
}
bool allhurt=false;
- (void)chkBtnHandler:(id)sender {
    UIButton *btn =sender;
    NSLog(@"tag:%ld",(long)btn.tag);
   
    switch (btn.tag) {
        case 1:
            if(!allhurt){
                
                self.tabBarController.title = @" 疼痛部位-正面";
                
                [switchBody setImage:[UIImage imageNamed:@"circle"]
                        forState:UIControlStateNormal];
                [bodyView setImage:[UIImage imageNamed:@"grayboyp"]];
                switchBody.tag=2;
                [self clearX];
                for (int i=0;i<pointRecordCount2;i++) {
                [self getPixelColorAtLocation:pointRecord2[i]];
                }
            }
            else {
                
                
                [switchBody setImage:[UIImage imageNamed:@"circle"]
                            forState:UIControlStateNormal];
                [bodyView setImage:[UIImage imageNamed:@"boybody"]];
                switchBody.tag=2;
                [self clearX];
                for (int i=0;i<pointRecordCount2;i++) {
                    [self getPixelColorAtLocation:pointRecord2[i]];
                    
                }

            }
            
            
            [defaults setInteger:21 forKey:@"ggg"];
            [defaults synchronize];

            break;
            
        case 2:
            
            self.tabBarController.title = @" 疼痛部位-背面";
            
            [switchBody setImage:[UIImage imageNamed:@"positivecircle"]
                        forState:UIControlStateNormal];
            [bodyView setImage:[UIImage imageNamed:@"boybackbody"]];
            switchBody.tag=1;
            [self clearX];
            for (int i=0;i<pointRecordCount;i++) {
                [self getPixelColorAtLocation:pointRecord[i]];
                
            }
            
            
            [defaults setInteger:22 forKey:@"ggg"];
            [defaults synchronize];
            
            break;
        case 3:
            if (allhurt) {
                allhurt=false;
                [bodyView setImage:[UIImage imageNamed:@"grayboyp"]];
                [switchBody setImage:[UIImage imageNamed:@"circle"]
                            forState:UIControlStateNormal];
                //switchBody.selected=NO;
                switchBody.tag=2;
                [self clearX];

            }
            else {
                allhurt=true;
                [bodyView setImage:[UIImage imageNamed:@"boybody"]];
                [switchBody setImage:[UIImage imageNamed:@"circle"]
                            forState:UIControlStateNormal];
                switchBody.selected=NO;
                switchBody.tag=2;
                pointRecordCount2=0;
                [self clearX];
            
            }
            break;
        case 4:
            clearCheck=true;
            [self clearX];
            break;


        default:
            break;
    }
    
}


-(void)clearX{
    //    [addImgView removeFromSuperview];
    while (itemCount!=0) {
           NSLog(@"%d",itemCount);
    
    if (itemCount == 0) {
        return;
    }
    
    [[bodyView viewWithTag:itemCount]removeFromSuperview];
    itemCount--;
    }
    
    if(clearCheck){
        pointRecordCount=0;
        pointRecordCount2=0;
        clearCheck=false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpBar{
    self.tabBarController.title = @" 疼痛部位-正面";
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.tabBarController.navigationItem.leftBarButtonItem = left;
}


-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //    self.navigationItem.leftBarButtonItem = left;
    self.tabBarController.navigationItem.leftBarButtonItem = left;
}


-(void)next{
    
    
    [defaults setInteger:2 forKey:@"ggg"];
    [defaults synchronize];
    
    NSLog(@"catch");
    hurtTypeViewController *nVC = [[hurtTypeViewController alloc]init];
    nVC.Paincurve_value=self.Paincurve_value;
    nVC.hurtPlace_value=NULL;
    [self.navigationController pushViewController:nVC animated:YES];
     
}


-(BOOL)hidesBottomBarWhenPushed{
    return NO;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)handleTap:(id)sender{
    NSLog(@"touch");
    
    CGPoint point = [sender locationInView:bodyView];
    
    
    //    [_colorPicker touchesEnded:[sender allTouches] withEvent:UIEventTypeTouches];
    //    [_colorPicker sentTouch:];
    
    //    UIColor *getColor = [_colorPicker getPixelColorAtLocation:point];
    
    [self getPixelColorAtLocation:point];
    
    switch (switchBody.tag) {
        case 1:
            pointRecordCount++;
            
            
            break;
        case 2:
            pointRecordCount2++;
            
            break;
            
        default:
            break;
    }

    
    //    NSLog(@"%f , %f",point.x,point.y);
}
-(void) getPixelColorAtLocation:(CGPoint)point
{
    if(switchBody.tag==2 & allhurt==true){}
    else{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    //    [self.layer renderInContext:context];
    
    [bodyView.layer renderInContext:context];
    
    NSLog(@"x- %f  y- %f",point.x,point.y);
    
    
    switch (switchBody.tag) {
        case 1:
            pointRecord[pointRecordCount]=point;
        
            break;
        case 2:
            pointRecord2[pointRecordCount2]=point;
          
            break;
            
        default:
            break;
    }
    
    
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSLog(@"RGB Color code %d  %d  %d",pixel[0],pixel[1],pixel[2]);
    
    if (pixel[0] == 0)return;
    
    addImgView = [[UIImageView alloc]initWithFrame:CGRectMake(point.x-10, point.y-10, 20, 20)];
    [addImgView setImage:[UIImage imageNamed:@"xmark"]];
    
    itemCount++;
    
    addImgView.tag = itemCount;
    
    
    
    
    [bodyView addSubview:addImgView];
    
    
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
    
    CGRect mytest=[self autoImageSize:@"painselfmanagement" withsecond:0.55];
    NSLog(@"Width:%f",mytest.size.width);
    NSLog(@"Height:%f",mytest.size.height);
    
    
}




//-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
//    //UIGraphicsBeginImageContext(newSize);
//    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
//    // Pass 1.0 to force exact pixel size.
//    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
//    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newImage;
//}

@end
