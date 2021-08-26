//
//  ViewController.m
//  hurtPointBar
//
//  Created by 黃柏鈞 on 2016/3/13.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "sideEffectViewController.h"
#import "UIDefine.h"
#import "CHTTextView.h"
#import "currentlyMoodViewController.h"
@interface sideEffectViewController (){
    
    UIScrollView *mainScroll;
    
    
    
    UIButton *chkBtn11;
    UIButton *chkBtn12;
    UIButton *chkBtn13;
    UIButton *chkBtn21;
    UIButton *chkBtn22;
    UIButton *chkBtn23;
    UIButton *chkBtn31;
    UIButton *chkBtn32;
    UIButton *chkBtn33;
    UIButton *chkBtn41;
    UIButton *chkBtn42;
    UIButton *chkBtn43;
    UIButton *chkBtn51;
    UIButton *chkBtn52;
    UIButton *chkBtn53;
    
    UITextView *leftView;
    
    
}
@property (strong, nonatomic) UISlider *hurtSlider;
@property (strong, nonatomic) UIImageView *pointImage;
@property (strong, nonatomic) UIButton *nextStep;
@property (strong, nonatomic) UIImageView *trackImage;

@end

@implementation sideEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height-40-40-40)];
    mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 600+50);
    mainScroll.bounces = YES;
    //mainScroll.scrollEnabled=NO;
    mainScroll.delegate=self;
    // 滑動到position的位置
    CGPoint position = CGPointMake(0, 0);
    [mainScroll setContentOffset:position animated:YES];

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
    titletext.text = @"【可複選】疼痛時所產生之副作用";
    [titletext setFont:[UIFont fontWithName:@"Helvetica" size:9]];
    [mainScroll addSubview:titletext];
    
    self.tabBarController.title = @" 副作用";
    
    //第一列
    chkBtn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn11.tag = 0;
    [chkBtn11 setFrame:CGRectMake(aScreenRect.size.width/2-80/2-100, 85-25, 80, 80)];
    [chkBtn11 setImage:[UIImage imageNamed:@"rednon"]
              forState:UIControlStateNormal];
    [chkBtn11 setImage:[UIImage imageNamed:@"non"]
              forState:UIControlStateSelected];
    [chkBtn11 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn11];
    
    
    chkBtn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn12.tag = 1;
   [chkBtn12 setFrame:CGRectMake(aScreenRect.size.width/2-80/2, chkBtn11.frame.origin.y, 80, 80)];
    [chkBtn12 setImage:[UIImage imageNamed:@"vomiting"]
              forState:UIControlStateNormal];
    [chkBtn12 setImage:[UIImage imageNamed:@"redvomiting"]
              forState:UIControlStateSelected];
    [chkBtn12 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn12];
    
    
    chkBtn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn13.tag = 2;
    [chkBtn13 setFrame:CGRectMake(chkBtn12.frame.origin.x+100, chkBtn12.frame.origin.y, 80, 80)];
    [chkBtn13 setImage:[UIImage imageNamed:@"dizziness"]
              forState:UIControlStateNormal];
    [chkBtn13 setImage:[UIImage imageNamed:@"reddizziness"]
              forState:UIControlStateSelected];
    [chkBtn13 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn13];
    
    
    
    //第二列
    chkBtn21 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn21.tag = 3;
    [chkBtn21 setFrame:CGRectMake(chkBtn11.frame.origin.x, chkBtn11.frame.origin.y+100, 80, 80)];
    [chkBtn21 setImage:[UIImage imageNamed:@"garydifficultybreathing"]
              forState:UIControlStateNormal];
    [chkBtn21 setImage:[UIImage imageNamed:@"difficultybreathing"]
              forState:UIControlStateSelected];
    [chkBtn21 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn21];
    
    
    chkBtn22 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn22.tag = 4;
    [chkBtn22 setFrame:CGRectMake(chkBtn21.frame.origin.x+100, chkBtn21.frame.origin.y, 80, 80)];
    [chkBtn22 setImage:[UIImage imageNamed:@"urinaryretention"]
              forState:UIControlStateNormal];
    [chkBtn22 setImage:[UIImage imageNamed:@"redurinaryretention"]
              forState:UIControlStateSelected];
    [chkBtn22 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn22];
    
    
    chkBtn23 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn23.tag = 5;
    [chkBtn23 setFrame:CGRectMake(chkBtn22.frame.origin.x+100, chkBtn22.frame.origin.y, 80, 80)];
    [chkBtn23 setImage:[UIImage imageNamed:@"constipation"]
              forState:UIControlStateNormal];
    [chkBtn23 setImage:[UIImage imageNamed:@"redconstipation"]
              forState:UIControlStateSelected];
    [chkBtn23 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn23];
    
    
    
    //第三列
    chkBtn31 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn31.tag = 6;
    [chkBtn31 setFrame:CGRectMake(chkBtn21.frame.origin.x, chkBtn21.frame.origin.y+100, 80, 80)];
    [chkBtn31 setImage:[UIImage imageNamed:@"skincondition"]
              forState:UIControlStateNormal];
    [chkBtn31 setImage:[UIImage imageNamed:@"redskincondition"]
              forState:UIControlStateSelected];
    [chkBtn31 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn31];
    
    
    chkBtn32 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn32.tag = 7;
    [chkBtn32 setFrame:CGRectMake(chkBtn31.frame.origin.x+100, chkBtn31.frame.origin.y, 80, 80)];
    [chkBtn32 setImage:[UIImage imageNamed:@"garysleepiness"]
              forState:UIControlStateNormal];
    [chkBtn32 setImage:[UIImage imageNamed:@"sleepiness"]
              forState:UIControlStateSelected];
    [chkBtn32 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn32];
    
    
    chkBtn33 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn33.tag = 8;
    [chkBtn33 setFrame:CGRectMake(chkBtn32.frame.origin.x+100, chkBtn32.frame.origin.y, 80, 80)];
    [chkBtn33 setImage:[UIImage imageNamed:@"stomachpain"]
              forState:UIControlStateNormal];
    [chkBtn33 setImage:[UIImage imageNamed:@"redstomachpain"]
              forState:UIControlStateSelected];
    [chkBtn33 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn33];
    
    
    
    //第四列
    chkBtn41 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn41.tag = 9;
    [chkBtn41 setFrame:CGRectMake(chkBtn31.frame.origin.x, chkBtn31.frame.origin.y+100, 80, 80)];
    [chkBtn41 setImage:[UIImage imageNamed:@"anxiety"]
              forState:UIControlStateNormal];
    [chkBtn41 setImage:[UIImage imageNamed:@"redanxiety"]
              forState:UIControlStateSelected];
    [chkBtn41 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn41];
    
    
    chkBtn42 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn42.tag = 10;
    [chkBtn42 setFrame:CGRectMake(chkBtn41.frame.origin.x+100, chkBtn41.frame.origin.y, 80, 80)];
    [chkBtn42 setImage:[UIImage imageNamed:@"excited"]
              forState:UIControlStateNormal];
    [chkBtn42 setImage:[UIImage imageNamed:@"redexcited"]
              forState:UIControlStateSelected];
    [chkBtn42 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn42];
    
    
    chkBtn43 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn43.tag = 11;
    [chkBtn43 setFrame:CGRectMake(chkBtn42.frame.origin.x+100, chkBtn42.frame.origin.y, 80, 80)];
    [chkBtn43 setImage:[UIImage imageNamed:@"nervoustension"]
              forState:UIControlStateNormal];
    [chkBtn43 setImage:[UIImage imageNamed:@"rednervoustension"]
              forState:UIControlStateSelected];
    [chkBtn43 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn43];
    
    
    //第五列
    chkBtn51 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn51.tag = 12;
    [chkBtn51 setFrame:CGRectMake(chkBtn31.frame.origin.x, chkBtn41.frame.origin.y+100, 80, 80)];
    [chkBtn51 setImage:[UIImage imageNamed:@"insomnia"]
              forState:UIControlStateNormal];
    [chkBtn51 setImage:[UIImage imageNamed:@"redinsomnia"]
              forState:UIControlStateSelected];
    [chkBtn51 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn51];
    
    
    
    chkBtn52 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn52.tag = 13;
    [chkBtn52 setFrame:CGRectMake(chkBtn51.frame.origin.x+100, chkBtn41.frame.origin.y+100, 80, 80)];
    [chkBtn52 setImage:[UIImage imageNamed:@"garyother"]
              forState:UIControlStateNormal];
    [chkBtn52 setImage:[UIImage imageNamed:@"other"]
              forState:UIControlStateSelected];
    [chkBtn52 addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn52];
    
    
    UIImageView *other = [[UIImageView alloc] initWithFrame:CGRectMake(chkBtn51.frame.origin.x+50,chkBtn51.frame.origin.y+10,180,315)];
    [other setImage:[UIImage imageNamed:@"whiteblock"]];
    other.transform = CGAffineTransformMakeRotation(-M_PI_2*3);
    [mainScroll addSubview:other];
    
    
    leftView =[[UITextView alloc]init];
    [leftView  setFrame:CGRectMake(chkBtn51.frame.origin.x,chkBtn51.frame.origin.y+110,285,130)];
    //typeSpace.backgroundColor=[UIColor whiteColor];
    leftView.layer.borderColor=[[UIColor whiteColor]CGColor];
    leftView.layer.borderWidth=5.0f;
    leftView.font= [UIFont fontWithName:@"Helvetica" size:13];
    leftView.delegate=self;
    //leftView.placeholder = @"請描述其他非藥物處理疼痛方式......";
    //leftView.hidden=YES;
    
    //自訂return ->done
    leftView.returnKeyType=UIReturnKeyDone;
    
    
    
    /*leftView = [[UITextField alloc] initWithFrame:CGRectMake(chkBtn51.frame.origin.x,chkBtn51.frame.origin.y+110,285,130)];
     leftView.keyboardType = UIKeyboardTypeDefault;
     leftView.layer.cornerRadius = 5;
     leftView.backgroundColor = RGBACOLOR(245, 245, 245, 0);
     [leftView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
     leftView.placeholder = @" 身分證字號";
     leftView.delegate = self;
     leftView.returnKeyType = UIReturnKeyDone;
     leftView.leftViewMode = UITextFieldViewModeAlways;
     leftView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;*/
    
    
    
    
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(aScreenRect.size.width/2-110,mainScroll.frame.size.height ,220,40 )];
    
    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 100)];
    [self.view addSubview:_nextStep];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)next
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:7 forKey:@"ggg"];
    [defaults synchronize];
    
    
    currentlyMoodViewController  *nVC = [[currentlyMoodViewController  alloc]init];
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
    //NSLog(@"%@",sender);
    //talBg.backgroundColor=[UIColor blueColor];
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    //建立一個BTN去接tag值
    UIButton *senderBtn = (UIButton*)sender;
    //取出值
    long btnTag=senderBtn.tag;
    [self agree:btnTag];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    NSLog(@"鍵盤收起");
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textField {
    NSLog(@"START EDIT");
    //textField.layer.borderColor=[[UIColor grayColor]CGColor];
    textField.layer.borderWidth=1.0f;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    
    //設定動畫開始時的狀態為目前畫面上的樣子
    [UIView setAnimationBeginsFromCurrentState:YES];
    /*
    textField.frame = CGRectMake(textField.frame.origin.x,
                                 textField.frame.origin.y - 210,
                                 textField.frame.size.width,
                                 textField.frame.size.height);
    */
    
    CGPoint position = CGPointMake(0, 350);
    [mainScroll setContentOffset:position animated:YES];

    [UIView commitAnimations];
}

- (void)textViewDidEndEditing:(UITextView*)textField {
    NSLog(@"END EDIT");
    textField.layer.borderColor=[[UIColor whiteColor]CGColor];
    textField.layer.borderWidth=1.0f;
    
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    
    //設定動畫開始時的狀態為目前畫面上的樣子
    [UIView setAnimationBeginsFromCurrentState:YES];
    /*
    textField.frame = CGRectMake(textField.frame.origin.x,
                                 textField.frame.origin.y + 210,
                                 textField.frame.size.width,
                                 textField.frame.size.height);
    */
    [UIView commitAnimations];
}



-(void)agree:(long)sender
{
    long selecter = sender;
    if(selecter == 0)
    {
        chkBtn12.selected = NO;
        chkBtn13.selected = NO;
        chkBtn21.selected = NO;
        chkBtn22.selected = NO;
        chkBtn23.selected = NO;
        chkBtn31.selected = NO;
        chkBtn32.selected = NO;
        chkBtn33.selected = NO;
        chkBtn41.selected = NO;
        chkBtn42.selected = NO;
        chkBtn43.selected = NO;
        chkBtn51.selected = NO;
        chkBtn52.selected = NO;
        leftView.removeFromSuperview;
        
    }else
    {
        chkBtn11.selected = YES;
    }
    
    
    if(selecter == 13)
    {
        
        [mainScroll addSubview:leftView];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
