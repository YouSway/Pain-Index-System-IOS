//
//  ViewController.m
//  hurtHandle_LTS
//
//  Created by 黃柏鈞 on 2016/4/23.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "hurtHandleViewController.h"
#import "UIDefine.h"
#import "CHTTextView.h"
#import "sideEffectViewController.h"
@interface hurtHandleViewController (){
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
    //CHTTextView *typeSpace;
    UITextView *typeSpace;
    
}
@property (strong, nonatomic) UIButton *nextStep;

@end

@implementation hurtHandleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    NSLog(@"Paincurve_value:%@",self.Paincurve_value);
    NSLog(@"hurtPlace_value:%@",self.hurtPlace_value);
    NSLog(@"hurtType_value:%@",self.hurtType_value);
    NSLog(@"hurtType_value:%@",self.hurtCycle_value);

    
    
    //
    
    
    //get screen infromation
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    /*------frame------*/
    
    //scroll view
    mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height-40-80)];
    mainScroll.contentSize = CGSizeMake(aScreenRect.size.width, 600);
    mainScroll.bounces = YES;
    
    //
    mainScroll.delegate=self;
    // 滑動到position的位置
    CGPoint position = CGPointMake(0, 0);
    [mainScroll setContentOffset:position animated:YES];

    
    //bgcolor
    //self.view.backgroundColor=[UIColor redColor];
    self.view.backgroundColor=RGBACOLOR(248, 248, 248, 1);
    mainScroll.backgroundColor=RGBACOLOR(248, 248, 248, 1);
    [self.view addSubview:mainScroll];
    
    //tableDrugHandleLabel
    tableDrugHandleLabel=[[UILabel alloc]init];
    [tableDrugHandleLabel setFrame:CGRectMake(0,20, aScreenRect.size.width,35)];
    tableDrugHandleLabel.text=@"  【是否有使用】藥物處理";
    tableDrugHandleLabel.textColor=RGBACOLOR(132, 132, 132, 1);
    tableDrugHandleLabel.backgroundColor=RGBACOLOR(238, 238, 238, 1);
    [mainScroll addSubview:tableDrugHandleLabel];
    
    //tableDrugHandleLabel
    tableDrugHandle=[[UILabel alloc] init];
    [tableDrugHandle setFrame:CGRectMake(0, tableDrugHandleLabel.frame.origin.y+tableDrugHandleLabel.frame.size.height, aScreenRect.size.width, 70)];
    tableDrugHandle.text=@"             有使用止痛藥物處理疼痛";
    tableDrugHandle.textColor=RGBACOLOR(132, 132, 132, 1);
    tableDrugHandle.backgroundColor=RGBACOLOR(255, 255, 255, 1);
    [mainScroll addSubview:tableDrugHandle];
    
    //notableDrugHandleLabel
    noDrugHandleLable=[[UILabel alloc]init];
    [noDrugHandleLable setFrame:CGRectMake(0,tableDrugHandle.frame.origin.y+tableDrugHandle.frame.size.height,aScreenRect.size.width,35)];
    noDrugHandleLable.text=@"  【可複選】非藥物處理方式";
    noDrugHandleLable.textColor=RGBACOLOR(132, 132, 132, 1);
    noDrugHandleLable.backgroundColor=RGBACOLOR(238, 238, 238, 1);
    [mainScroll addSubview:noDrugHandleLable];
    
    
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
    [tableLine moveToPoint:CGPointMake(0, 55.5+70+35)];
    [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 55.5+70+35)];
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
    UIButton *recordid = [UIButton buttonWithType:UIButtonTypeCustom];
    [recordid setFrame:CGRectMake(20, tableDrugHandle.frame.origin.y+40/2, 30, 30)];
    [recordid setImage:[UIImage imageNamed:@"empty"]
              forState:UIControlStateNormal];
    [recordid setImage:[UIImage imageNamed:@"redyes"]
              forState:UIControlStateSelected];
    [recordid addTarget:self
                 action:@selector(chkBtnHandler:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:recordid];
    
    
    //第一列
    chkBtn11 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn11.tag = 0;
    [chkBtn11 setFrame:CGRectMake(aScreenRect.size.width/2-80/2-100, noDrugHandleLable.frame.origin.y+noDrugHandleLable.frame.size.height+20, 80, 80)];
    [chkBtn11 setImage:[UIImage imageNamed:@"psychotherapy"]
              forState:UIControlStateNormal];
    [chkBtn11 setImage:[UIImage imageNamed:@"redpsychotherapy"]
              forState:UIControlStateSelected];
    [chkBtn11 addTarget:self
                 action:@selector(chkBtnHandler2:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn11];
    
    
    chkBtn12 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn12.tag = 1;
    [chkBtn12 setFrame:CGRectMake(aScreenRect.size.width/2-80/2, chkBtn11.frame.origin.y, 80, 80)];
    [chkBtn12 setImage:[UIImage imageNamed:@"garymassage"]
              forState:UIControlStateNormal];
    [chkBtn12 setImage:[UIImage imageNamed:@"massage"]
              forState:UIControlStateSelected];
    [chkBtn12 addTarget:self
                 action:@selector(chkBtnHandler2:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn12];
    
    
    chkBtn13 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn13.tag = 2;
    [chkBtn13 setFrame:CGRectMake(chkBtn12.frame.origin.x+100, chkBtn12.frame.origin.y, 80, 80)];
    [chkBtn13 setImage:[UIImage imageNamed:@"transfernote"]
              forState:UIControlStateNormal];
    [chkBtn13 setImage:[UIImage imageNamed:@"redtransfernote"]
              forState:UIControlStateSelected];
    [chkBtn13 addTarget:self
                 action:@selector(chkBtnHandler2:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn13];
    
    //第二列
    chkBtn21 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn21.tag = 3;
    [chkBtn21 setFrame:CGRectMake(chkBtn11.frame.origin.x, chkBtn11.frame.origin.y+100, 80, 80)];
    [chkBtn21 setImage:[UIImage imageNamed:@"garycoldfomentation"]
              forState:UIControlStateNormal];
    [chkBtn21 setImage:[UIImage imageNamed:@"coldfomentation"]
              forState:UIControlStateSelected];
    [chkBtn21 addTarget:self
                 action:@selector(chkBtnHandler2:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn21];
    
    
    chkBtn22 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn22.tag = 4;
    [chkBtn22 setFrame:CGRectMake(chkBtn21.frame.origin.x+100, chkBtn21.frame.origin.y, 80, 80)];
    [chkBtn22 setImage:[UIImage imageNamed:@"electrotherapy"]
              forState:UIControlStateNormal];
    [chkBtn22 setImage:[UIImage imageNamed:@"redelectrotherapy"]
              forState:UIControlStateSelected];
    [chkBtn22 addTarget:self
                 action:@selector(chkBtnHandler2:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn22];
    
    
    chkBtn23 = [UIButton buttonWithType:UIButtonTypeCustom];
    chkBtn23.tag = 5;
    [chkBtn23 setFrame:CGRectMake(chkBtn22.frame.origin.x+100, chkBtn22.frame.origin.y, 80, 80)];
    [chkBtn23 setImage:[UIImage imageNamed:@"garyother"]
              forState:UIControlStateNormal];
    [chkBtn23 setImage:[UIImage imageNamed:@"other"]
              forState:UIControlStateSelected];
    [chkBtn23 addTarget:self
                 action:@selector(chkBtnHandlerOther:)
       forControlEvents:UIControlEventTouchUpInside];
    [mainScroll addSubview:chkBtn23];
    
    
    CGRect blockTmp=[self autoImageSize:@"block" withsecond:0.75];
    block=[[UIImageView alloc]init];
    [block setFrame:CGRectMake(aScreenRect.size.width/2-blockTmp.size.width/2, 350+20, blockTmp.size.width, blockTmp.size.height)];
    [block setImage:[UIImage imageNamed:@"block"]];
    block.hidden=YES;
    [mainScroll addSubview:block];
    
    //text
    
    typeSpace=[[CHTTextView alloc]init];
    [typeSpace setFrame:CGRectMake((aScreenRect.size.width/2-blockTmp.size.width/2)+20, 310+20+40+20, blockTmp.size.width-40, blockTmp.size.height-35)];
    //typeSpace.backgroundColor=[UIColor whiteColor];
    typeSpace.layer.borderColor=[[UIColor whiteColor]CGColor];
    typeSpace.layer.borderWidth=5.0f;
    typeSpace.font= [UIFont fontWithName:@"Helvetica" size:13];
    //typeSpace.placeholder=@"請描述其他非藥物處理疼痛方式......";
    typeSpace.hidden=YES;
    typeSpace.delegate=self;
    [typeSpace setBackgroundColor:[UIColor whiteColor]];
    typeSpace.layer.borderColor=[[UIColor whiteColor]CGColor];
    //自訂return ->done
    typeSpace.returnKeyType=UIReturnKeyDone;

    [mainScroll addSubview:typeSpace];
    
    chkBtn11.tag=1;
    chkBtn12.tag=2;
    chkBtn13.tag=3;
    chkBtn21.tag=4;
    chkBtn22.tag=5;
    chkBtn23.tag=6;

    
    
}


int rec2[13]={0,0,0,0,0,0,0,0,0,0,0,0,0};
NSString *output2;

-(void)next{
    
    sideEffectViewController *nVC = [[sideEffectViewController  alloc]init];
    [self.navigationController pushViewController:nVC animated:YES];
    
}



-(void)viewWillAppear:(BOOL)animated{
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    //    self.navigationItem.leftBarButtonItem = left;
    self.tabBarController.navigationItem.leftBarButtonItem = left;
}

-(void)viewWillAppear{
    //重新洗白
    for(int i=0; i<=12; i++){
        rec2[i]=0;
    }
}



- (void)chkBtnHandler:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    
    UIButton *btn=sender;
    if (btn.selected==YES){
        NSLog(@"selected");
        tableDrugHandle.backgroundColor=RGBACOLOR(248, 248, 248, 1);
    }
    else{
        tableDrugHandle.backgroundColor=RGBACOLOR(255, 255, 255, 1);
    }
    
}

- (void)chkBtnHandler2:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    UIButton *btn=sender;
    if (btn.selected==YES) {
        rec2[btn.tag]=1;
        NSLog(@"Y");
    }
    else{
        rec2[btn.tag]=0;
        NSLog(@"N");
    }
    
    NSString *intToString;
    output2=@"v";
    for (int i=1; i<=12; i++) {
        //NSLog(@"%d",rec[i]);
        intToString = [NSString stringWithFormat:@"%d", rec2[i]];
        
        output2 = [output2 stringByAppendingString:intToString];
        
    }
    NSLog(@"%@",output2);

}

- (void)chkBtnHandlerOther:(id)sender {
    // If checked, uncheck and visa versa
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    UIButton *btn=sender;
    if (btn.selected==YES) {
        block.hidden=NO;
        typeSpace.hidden=NO;
    }
    else{
        block.hidden=YES;
        typeSpace.hidden=YES;
    }
    
    if(rec2[6]==0){rec2[6]=1;}
    else{rec2[6]=0;}
    
    NSString *intToString;
    output2=@"v";
    for (int i=1; i<=12; i++) {
        //NSLog(@"%d",rec[i]);
        intToString = [NSString stringWithFormat:@"%d", rec2[i]];
        
        output2 = [output2 stringByAppendingString:intToString];
        
    }

    NSLog(@"%@",output2);

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
    mainScroll.scrollEnabled=NO;
    
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
    
    CGPoint position = CGPointMake(0, 150);
    [mainScroll setContentOffset:position animated:YES];
    
    //CGRect frame = self.view.frame;
    //frame.size.height=100;

    //[self.view setFrame:CGRectMake(0, 200, 100, 100)];
    
    
    [UIView commitAnimations];
}


- (void)textViewDidEndEditing:(UITextView*)textField {
    NSLog(@"END EDIT");
    textField.layer.borderColor=[[UIColor whiteColor]CGColor];
    textField.layer.borderWidth=1.0f;
    mainScroll.scrollEnabled=YES;
    
    
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
