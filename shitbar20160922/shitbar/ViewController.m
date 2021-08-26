//
//  ViewController.m
//  shitbar
//
//  Created by user on 2016/3/14.
//  Copyright © 2016年 user. All rights reserved.
//

#import "ViewController.h"
#import "UIDefine.h"
#import "MainViewController.h"
#import "Webservice.h"

@interface ViewController (){
    NSString *c_mrn; //病歷號
    NSString *c_idn; //身分證字號
    NSString *c_brd; //生日

}
@end

@implementation ViewController


- (void)viewDidLoad {
    
    
    
    
    [self agree];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)clauseView{
    
    /*CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    UIImageView *bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, height-64, width, 64)];
    bottom.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    bottom.userInteractionEnabled = YES;
    [self.view addSubview:bottom];
    
    UIButton *agreeBtn,*refuseBtn;
    refuseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    refuseBtn.frame = CGRectMake(5, 5, (width-15)/2, 54);
    [refuseBtn setTitle:@"拒絕" forState:UIControlStateNormal];
    refuseBtn.backgroundColor = RGBACOLOR(51, 51, 51, 1);
    [refuseBtn addTarget:self action:@selector(refuse) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:refuseBtn];
    
    agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(width/2+2.5, 5, (width-15)/2, 54);
    [agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
    agreeBtn.backgroundColor = RGBACOLOR(0, 170, 201, 1);
    [agreeBtn addTarget:self action:@selector(agree) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:agreeBtn];*/
    
    
    
}

-(void)checkLogin{
    c_idn=idField.text;// 身分證
    c_mrn=passField.text;// 病歷號
    c_brd=dateField.text;// 生日
    [self login:c_mrn idn:c_idn brd:c_brd];
}


-(bool)login:(NSString*)mrn idn:(NSString*)idn brd:(NSString *)brd{
    NSLog(@"%@,%@,%@",mrn,idn,brd);
    
    
    
    //
    NSDictionary *dictParam = @{@"mrn":mrn,@"idn":idn,@"brd":brd};
//    NSDictionary *result=[[NSDictionary alloc]init];
    
    [Webservice requestPostUrl:@"http://220.132.42.54:8888/dsl2501Stu/login.php" parameters:dictParam success:^(NSDictionary *responce) {
        //Success
        NSLog(@"responce:%@",responce);
        
        [self logoinCheck:responce];
        
    } failure:^(NSError *error) {
        //error
        NSLog(@"ERROR");
    }];
    
    
    

    return true;
}

-(void)logoinCheck:(NSDictionary *)dic{
    
    //存入userdefault
    
    NSDictionary *personInfo=dic;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:personInfo forKey:@"personInfo"];
    [userDefaults synchronize];
//    NSLog(@"PPP:%@",personInfo);
    
    
    
    dic=[dic objectForKey:@"data"];
    dic=[dic objectForKey:@"status"];
    NSLog(@"%@",dic);
    NSString *sta;
    sta=[NSString stringWithFormat:@"%@",dic];
    
    if([sta isEqualToString:@"true"]){
        NSLog(@"OK");
        
        
    
         [self.navigationController setNavigationBarHidden:NO];
         MainViewController *main = [[MainViewController alloc] init];
         [self.navigationController setViewControllers:[NSArray arrayWithObject:main] animated:NO];
         
    }
   
    
    
}

-(void)agree{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    CGFloat width = aScreenRect.size.width;
    CGFloat height = aScreenRect.size.height;
    
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UIImageView *mainView = [[UIImageView alloc] init];
    [mainView setImage:[UIImage imageNamed:@"background"]];
    [mainView setFrame:CGRectMake(0, 0, width, height)];
    mainView.userInteractionEnabled = YES;
    [self.view addSubview:mainView];
    
    
    //APP logo
    
    UIImage *img = [UIImage imageNamed:@"painselfmanagement"];
    //CGFloat mul = img.size.width/(width-100);
    
    UIImageView *logoImage = [[UIImageView alloc] init];
    
    
    CGRect APP_logo=[self autoImageSize:@"painselfmanagement" withsecond:0.75];
    
    
    [logoImage setImage:[UIImage imageNamed:@"painselfmanagement"]];
    [logoImage setFrame:CGRectMake(aScreenRect.size.width/2-APP_logo.size.width/2, aScreenRect.size.height*0.1, APP_logo.size.width, APP_logo.size.height)];
    [mainView addSubview:logoImage];
    
    //bottom logo
    
    //UIImage *img2 = [UIImage imageNamed:@"zhangji"];
    //CGFloat mul2 = img2.size.width/(width-100);
    
    UIImageView *logoImage2 = [[UIImageView alloc] init];
    [logoImage2 setImage:[UIImage imageNamed:@"zhangji"]];
    /*
    float imageRate=width/height*0.55;//screenWidth/screenHeight*rate
    float bottomImageWidth=imageRate*[[UIImage imageNamed:@"zhangji"] size].width;
    float bottomImageHeight=imageRate*[[UIImage imageNamed:@"zhangji"] size].height;
    */
    
  
    
    CGRect bottom_logo =[self autoImageSize:@"zhangji" withsecond:0.5];
    
    [logoImage2 setFrame:CGRectMake(aScreenRect.size.width/2-bottom_logo.size.width/2, aScreenRect.size.height*0.85, bottom_logo.size.width,bottom_logo.size.height )];
    [mainView addSubview:logoImage2];
    
    //身分證字號

    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView.backgroundColor = [UIColor clearColor];
    
    idField = [[UITextField alloc] initWithFrame:CGRectMake(50, logoImage.frame.origin.y+logoImage.frame.size.height+10, width-100, 35)];
    idField.keyboardType = UIKeyboardTypeDefault;
    idField.layer.cornerRadius = 5;
    idField.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    [idField setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    idField.placeholder = @" 身分證字號";
    idField.delegate = self;
    idField.returnKeyType = UIReturnKeyDone;
    idField.leftView = leftView;
    idField.leftViewMode = UITextFieldViewModeAlways;
    idField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    idField.text=@"F123456789";
    [mainView addSubview:idField];
    
    //病歷號碼
    
    UILabel * leftView2 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView2.backgroundColor = [UIColor clearColor];
    
    passField = [[UITextField alloc] initWithFrame:CGRectMake(50, idField.frame.size.height+idField.frame.origin.y+5, width-100, 35)];
    passField.keyboardType = UIKeyboardTypeDefault;
    passField.secureTextEntry = YES;
    [passField setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    passField.placeholder = @" 病歷號碼";
    passField.layer.cornerRadius = 5;
    passField.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    passField.delegate = self;
    passField.returnKeyType = UIReturnKeyDone;
    passField.leftView = leftView2;
    passField.leftViewMode = UITextFieldViewModeAlways;
    passField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    passField.text=@"0936330117";
    [mainView addSubview:passField];
    
    //生日
    
    UILabel * leftView3 = [[UILabel alloc] initWithFrame:CGRectMake(10,0,7,26)];
    leftView3.backgroundColor = [UIColor clearColor];
    
    dateField = [[UITextField alloc] initWithFrame:CGRectMake(50, passField.frame.size.height+passField.frame.origin.y+5, width-100, 35)];
    dateField.keyboardType = UIKeyboardTypeDefault;
    dateField.secureTextEntry = YES;
    [dateField setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    dateField.placeholder = @" 生日(例:10311)";
    dateField.layer.cornerRadius = 5;
    dateField.backgroundColor = RGBACOLOR(245, 245, 245, 1);
    dateField.delegate = self;
    dateField.returnKeyType = UIReturnKeyDone;
    dateField.leftView = leftView3;
    dateField.leftViewMode = UITextFieldViewModeAlways;
    dateField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    dateField.text=@"19890904";
    [mainView addSubview:dateField];
    
    //////////
    
    /*UIImageView *recordidImage = [[UIImageView alloc] init];
    [recordidImage setImage:[UIImage imageNamed:@"no"]];
    [recordidImage setFrame:CGRectMake(35, dateField.frame.size.height+dateField.frame.origin.y, width-270, 50)];
    [mainView addSubview:recordidImage];*/
    
    /*UIButton *recordid = [UIButton buttonWithType:UIButtonTypeCustom];
    recordid.frame = CGRectMake(50, dateField.frame.size.height+dateField.frame.origin.y+15, width-300, 20);
    recordid.layer.cornerRadius = 5;
    recordid.backgroundColor = RGBACOLOR(255, 203, 101, 0);
    [recordid setTitle:@"" forState:UIControlStateNormal];
    [recordid addTarget:self action:@selector(recordidb) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:recordid];*/
    
    //check box 1
    UIButton *recordid = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordid setFrame:CGRectMake(35, dateField.frame.size.height+dateField.frame.origin.y, 50, 50)];
    
    [recordid setImage:[UIImage imageNamed:@"no"]
            forState:UIControlStateNormal];
    [recordid setImage:[UIImage imageNamed:@"yes"]
            forState:UIControlStateSelected];
    [recordid addTarget:self
               action:@selector(chkBtnHandler:)
     forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:recordid];
    
    //check box txt 1
    CGRect labelFrame = CGRectMake(recordid.frame.origin.x+40, recordid.frame.origin.y-1 , 100, recordid.frame.size.height);
    UILabel *recordidl = [[UILabel alloc] initWithFrame:labelFrame];
    [recordidl setTextColor:[UIColor  whiteColor]];
    [recordidl setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    recordidl.text = @"記住身分證字號";
    [mainView addSubview:recordidl];
    
    
    
    
    
    /*UIImageView *recordnoImage = [[UIImageView alloc] init];
    [recordnoImage setImage:[UIImage imageNamed:@"no"]];
    [recordnoImage setFrame:CGRectMake(recordidl.frame.origin.x+85, recordidl.frame.origin.y-15, width-270, 50)];
    [mainView addSubview:recordnoImage];*/
    
    /*UIButton *recordno = [UIButton buttonWithType:UIButtonTypeCustom];
    recordno.frame = CGRectMake(recordidl.frame.origin.x+100, recordidl.frame.origin.y, width-300, 20);
    recordno.layer.cornerRadius = 5;
    recordno.backgroundColor = RGBACOLOR(255, 203, 101, 0);
    [recordno setTitle:@"" forState:UIControlStateNormal];
    [recordno addTarget:self action:@selector(recordnob) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:recordno];*/
    
    //check box 2
    UIButton *recordno = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordno setFrame:CGRectMake(recordidl.frame.origin.x+95, recordidl.frame.origin.y, 50, 50)];
    
    [recordno setImage:[UIImage imageNamed:@"no"]
              forState:UIControlStateNormal];
    [recordno setImage:[UIImage imageNamed:@"yes"]
              forState:UIControlStateSelected];
    [recordno addTarget:self
                 action:@selector(chkBtnHandler2:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:recordno];
    
    //check box txt 2
    CGRect labelFrame2 = CGRectMake(recordno.frame.origin.x+40, recordno.frame.origin.y-1 , 100, recordno.frame.size.height);
    UILabel *recordnol = [[UILabel alloc] initWithFrame:labelFrame2];
    [recordnol setTextColor:[UIColor  whiteColor]];
    [recordnol setFont:[UIFont fontWithName:@"Helvetica" size:10]];
    recordnol.text = @"記住病歷號碼";
    [mainView addSubview:recordnol];

    
    //////////
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(50, recordid.frame.size.height+recordid.frame.origin.y+15, width-100, 35);
    loginBtn.layer.cornerRadius = 5;
    loginBtn.backgroundColor = RGBACOLOR(255, 203, 101, 1);
    [loginBtn setTitle:@"登入" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(checkLogin) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:loginBtn];
    
    
    
    
    
    
    
    
}



-(void)recordidb
{
    NSLog(@"記住身分");
    
}

-(void)recordnob
{
    NSLog(@"記住病歷");
}

- (void)chkBtnHandler:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    NSLog(@"記住身分");
}

- (void)chkBtnHandler2:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    NSLog(@"記住病歷");
    
    
    
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

@end
