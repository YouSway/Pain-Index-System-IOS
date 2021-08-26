//
//  ViewController.m
//  table
//
//  Created by 黃柏鈞 on 2016/3/11.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "hurtCycle2ViewController.h"
#import "UIDefine.h"
#import "sideEffectViewController.h"


//宣告全域變數
@interface hurtCycle2ViewController (){
    UILabel *title;
    UILabel *profession;
    UILabel *personName;
    UILabel *phone;
    UILabel *phoneNumber;
    UILabel *test;
    UILabel *test2;
    UILabel *test3;
    UILabel *test4;
    UILabel *test5;
    UILabel *test6;
    NSString *professionTxt;
    NSString *personNameTxt;
    NSString *phoneNumberTxt;
    NSString *labelpic;
    UIButton * testb;
    UIButton * testb2;
    UIButton * testb3;
    UIButton * testb4;
    UIButton * testb5;
    UIButton * testb6;
    UIPickerView *myPickerView;
    UIPickerView *myPickerView2;
    NSMutableArray *strings;
    NSMutableArray *strings2;
    NSMutableArray *strings3;
    NSMutableArray *strings4;
    NSMutableArray *strings5;
    NSMutableArray *strings6;
    NSMutableArray *stringsok;
    UIButton *chooseBtn;
    UIButton *chooseBtn2;
    UIButton *_nextStep;
    UIImageView *listchoose1;
    UIImageView *listchoose2;
    UIImageView *listchoose3;
    UIImageView *listchoose4;
    
    
    
    //make line
    UIBezierPath *tableLine;
    int selecter2;
    CAShapeLayer *layer2;
    
}

//
@property (strong, nonatomic) UITableView *userDataList;
@end

@implementation hurtCycle2ViewController


- (void)viewDidLoad {
    // [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    //
    NSLog(@"Paincurve_value:%@",self.Paincurve_value);
    NSLog(@"hurtPlace_value:%@",self.hurtPlace_value);
    NSLog(@"hurtType_value:%@",self.hurtType_value);
    NSLog(@"hurtType_value:%@",self.hurtCycle_value);
    //
    
    //取得螢幕資料
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    _userDataList = [[UITableView alloc] init];
    
    self.view.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    
    
    //上頭的註解
    CGRect labelFrame = CGRectMake(0, 65 , 500, 20);
    UILabel *titleback = [[UILabel alloc] initWithFrame:labelFrame];
    [titleback setTextColor:[UIColor blackColor]];
    UIColor *bg = RGBACOLOR(237, 237, 237, 1);
    [titleback setBackgroundColor:bg];
    [self.view addSubview:titleback];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 500, 20)];
    title.textColor = RGBACOLOR(150, 150, 150, 1);
    title.text = @"請選擇疼痛感的週期時間";
    [title setFont:[UIFont fontWithName:@"Helvetica" size:9]];
    [self.view addSubview:title];
    
    self.tabBarController.title = @" 疼痛周期";
    
    
    //table參數設定
    [_userDataList setFrame:CGRectMake(0, 85, aScreenRect.size.width-0, aScreenRect.size.height-145)];
    [_userDataList setDataSource:self];
    [_userDataList setDelegate:self];
    //將物件顯示出來
    [self.view addSubview:_userDataList];
    //禁止頁面滑動
    _userDataList.scrollEnabled = NO;
    //清除TABLE的框
    _userDataList.separatorColor = [UIColor clearColor];
    
    tableLine =[UIBezierPath bezierPath];
    //make line layer
    CAShapeLayer *layer=[CAShapeLayer layer];
    for(int i=0;i<=1;i++){
        [tableLine moveToPoint:CGPointMake(0, 85+(45*i))];
        [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 85+(45*i))];
        layer.path=[tableLine CGPath];
        layer.strokeColor=[[UIColor grayColor]CGColor];
        layer.lineWidth=0.25;
        layer.fillColor=[[UIColor clearColor]CGColor];
        
    }
    //show line
    [self.view.layer addSublayer:layer];
    //BGCOLOR
    _userDataList.backgroundColor=RGBACOLOR(224, 224, 224, 100);
}

#pragma mark - TableViewDelegate & TableViewDatasource


- (void)chkBtnHandler:(id)sender
{
    
    
    _nextStep.hidden = YES;
    
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseIdentifier = @"cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    //NSLog(@"%@",[[list_data objectAtIndex:indexPath.row] objectForKey:@"sprice"]);
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        //右箭頭
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.editing = YES;
        
    }
    
    
    //文字圖片內容
    switch (indexPath.row) {
        case 0:
            professionTxt=@"陣痛週期";
            personNameTxt=@"                      每";
            phoneNumberTxt=@"";
            labelpic=@"cycle";
            
            
            
            
            //每？分鐘
            test = [[UILabel alloc] initWithFrame:CGRectMake(147, 7.9, 43, 25)];
            test.textColor = RGBACOLOR(89, 89, 89, 1);
            test.layer.cornerRadius = 2;
            test.layer.borderColor = [UIColor grayColor].CGColor;
            test.layer.borderWidth = 0.4;
            test.text = @"  1";
            [test setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            [tableView addSubview:test];
            
            
            //每？分鐘
            testb = [UIButton buttonWithType:UIButtonTypeCustom];
            testb.tag = 0;
            testb.frame = CGRectMake(147, 8, 43, 25);
            [testb setTitle:@"" forState:UIControlStateNormal];
            testb.backgroundColor = RGBACOLOR(0, 170, 201, 0);
            [testb addTarget:self action:@selector(chkBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
            [tableView addSubview:testb];
            
            
            //痛？次
            test2 = [[UILabel alloc] initWithFrame:CGRectMake(197, 7.9, 43, 25)];
            test2.textColor = RGBACOLOR(89, 89, 89, 1);
            test2.layer.cornerRadius = 2;
            test2.layer.borderColor = [UIColor grayColor].CGColor;
            test2.layer.borderWidth = 0.4;
            test2.text = @" 分鐘";
            [test2 setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [tableView addSubview:test2];
            
            
            //痛？次
            testb2 = [UIButton buttonWithType:UIButtonTypeCustom];
            testb.tag = 1;
            testb2.frame = CGRectMake(197, 8, 43, 25);
            [testb2 setTitle:@"" forState:UIControlStateNormal];
            testb2.backgroundColor = RGBACOLOR(0, 170, 201, 0);
            [testb2 addTarget:self action:@selector(chkBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
            [tableView addSubview:testb2];
            
            
            break;
        case 1:
            
            professionTxt=@"持續時間";
            personNameTxt=@"                      每次持續";
            phoneNumberTxt=@"";
            labelpic=@"time";
            
            
            //每次持續？分鐘
            test3 = [[UILabel alloc] initWithFrame:CGRectMake(183, 53.9, 43, 25)];
            test3.textColor = RGBACOLOR(89, 89, 89, 1);
            test3.layer.cornerRadius = 2;
            test3.layer.borderColor = [UIColor grayColor].CGColor;
            test3.layer.borderWidth = 0.4;
            test3.text = @"  1";
            [test3 setFont:[UIFont fontWithName:@"Helvetica" size:20]];
            [tableView addSubview:test3];
            
            
            //每次持續？分鐘
            testb3 = [UIButton buttonWithType:UIButtonTypeCustom];
            testb3.tag = 2;
            testb3.frame = CGRectMake(183, 54, 43, 25);
            [testb3 setTitle:@"" forState:UIControlStateNormal];
            testb3.backgroundColor = RGBACOLOR(0, 0, 0, 0);
            [testb3 addTarget:self action:@selector(chkBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
            [tableView addSubview:testb3];
            
            
            //每次持續？分鐘
            test4 = [[UILabel alloc] initWithFrame:CGRectMake(233, 53.9, 43, 25)];
            test4.textColor = RGBACOLOR(89, 89, 89, 1);
            test4.layer.cornerRadius = 2;
            test4.layer.borderColor = [UIColor grayColor].CGColor;
            test4.layer.borderWidth = 0.4;
            test4.text = @" 分鐘";
            [test4 setFont:[UIFont fontWithName:@"Helvetica" size:13]];
            [tableView addSubview:test4];
            
            
            //每次持續？分鐘
            testb4 = [UIButton buttonWithType:UIButtonTypeCustom];
            testb4.tag = 3;
            testb4.frame = CGRectMake(233, 54, 43, 25);
            [testb4 setTitle:@"" forState:UIControlStateNormal];
            testb4.backgroundColor = RGBACOLOR(0, 170, 201, 0);
            [testb4 addTarget:self action:@selector(chkBtnHandler:) forControlEvents:UIControlEventTouchUpInside];
            [tableView addSubview:testb4];
            
            
            
            break;
        default:
            professionTxt=@"error";
            personNameTxt=@"error";
            phoneNumberTxt=@"error";
            labelpic=@"accountset";
            break;
    }
    
    //每？分鐘
    UIImageView *imaget1 = [[UIImageView alloc]initWithFrame:CGRectMake(177, 4.6, 15, 30)];
    imaget1.backgroundColor = [UIColor clearColor];
    [imaget1 setImage:[UIImage imageNamed:@"tbutton"]];
    [tableView addSubview:imaget1];
    
    
    //痛？次
    UIImageView *imaget2 = [[UIImageView alloc]initWithFrame:CGRectMake(227, 4.6, 15, 30)];
    imaget2.backgroundColor = [UIColor clearColor];
    [imaget2 setImage:[UIImage imageNamed:@"tbutton"]];
    [tableView addSubview:imaget2];
    
    
    //每？分鐘
    UIImageView *imaget3 = [[UIImageView alloc]initWithFrame:CGRectMake(213, 50.6, 15, 30)];
    imaget3.backgroundColor = [UIColor clearColor];
    [imaget3 setImage:[UIImage imageNamed:@"tbutton"]];
    [tableView addSubview:imaget3];
    
    
    //痛？次
    UIImageView *imaget4 = [[UIImageView alloc]initWithFrame:CGRectMake(263, 50.6, 15, 30)];
    imaget4.backgroundColor = [UIColor clearColor];
    [imaget4 setImage:[UIImage imageNamed:@"tbutton"]];
    [tableView addSubview:imaget4];
    
    
    
    
    
    
    
    //TABLE圖片
    // [cell.imageView setImage:[UIImage imageNamed:labelpic] ];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(13, 4, 35, 35)];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView.layer setCornerRadius:8.0f];
    [imageView.layer setMasksToBounds:YES];
    [imageView setImage:[UIImage imageNamed:labelpic]];
    [cell.contentView addSubview:imageView];
    
    
    
    //[[cell.contentView viewWithTag:111]removeFromSuperview];
    //職稱
    profession = [[UILabel alloc] initWithFrame:CGRectMake(53, -8, 500, 60)];
    profession.tag = 111;
    profession.font = [UIFont fontWithName:@"Helvetica" size:14];
    profession.textColor=RGBACOLOR(108, 108, 108, 100);
    profession.text = [NSString stringWithFormat:professionTxt];
    [cell.contentView addSubview:profession];
    
    //get profession table width
    float professionwidthIs =[profession.text
                              boundingRectWithSize:profession.frame.size
                              options:NSStringDrawingUsesLineFragmentOrigin
                              attributes:@{ NSFontAttributeName:profession.font }
                              context:nil]
    .size.width;
    NSLog(@"the width of yourLabel is %f", professionwidthIs);
    
    //名稱
    personName = [[UILabel alloc] initWithFrame:CGRectMake(55, -8, 500, 60)];
    personName.tag = 111;
    personName.font=[UIFont fontWithName:@"Helvetica" size:12];
    personName.textColor=RGBACOLOR(108, 108, 108, 100);
    personName.text = [NSString stringWithFormat:personNameTxt];
    [cell.contentView addSubview:personName];
    
    //電話
    phone=[[UILabel alloc] initWithFrame:CGRectMake(55, -1, 175, 60)];
    phone.tag=111;
    phone.font=[UIFont fontWithName:@"Helvetica" size:10];
    phone.textColor=RGBACOLOR(108, 108, 108, 100);
    phone.text=[NSString stringWithFormat:@""];
    [cell.contentView addSubview:phone];
    
    //get phone table width
    float phonewidthIs =[phone.text
                         boundingRectWithSize:phone.frame.size
                         options:NSStringDrawingUsesLineFragmentOrigin
                         attributes:@{ NSFontAttributeName:phone.font }
                         context:nil]
    .size.width;
    NSLog(@"the width of yourLabel is %f", phonewidthIs);
    
    //電話號碼
    phoneNumber=[[UILabel alloc] initWithFrame:CGRectMake(51+phonewidthIs, -1, 175, 60)];
    phoneNumber.tag=111;
    phoneNumber.font=[UIFont fontWithName:@"Helvetica" size:10];
    phoneNumber.textColor=RGBACOLOR(108, 108, 108, 100);
    phoneNumber.text=[NSString stringWithFormat:phoneNumberTxt];
    [cell.contentView addSubview:phoneNumber];
    
    
    _nextStep=[[UIButton alloc] init];
    _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
    [_nextStep setFrame:CGRectMake(70, 360, 180, 40)];
    [_nextStep setTitle:@"下一步" forState:UIControlStateNormal];
    _nextStep.layer.cornerRadius = 5;
    [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 1)];
    [_nextStep addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [tableView addSubview:_nextStep];
    
    
    return cell;
}


//pick1
-(void)agree:(long)sender{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    
    strings = [NSMutableArray arrayWithCapacity:2];
    strings2 = [NSMutableArray arrayWithCapacity:59];
    strings3 = [NSMutableArray arrayWithCapacity:59];
    strings4 = [NSMutableArray arrayWithCapacity:2];
    strings5 = [NSMutableArray arrayWithCapacity:10];
    strings6 = [NSMutableArray arrayWithCapacity:10];
    long selecter = sender;
    NSLog(@"%ld",selecter);
    switch (selecter) {
        case 0:
            strings =[[NSArray alloc] initWithObjects:@" 分鐘",@" 小時", nil];
            stringsok = strings;
            selecter2 = 0;
            
            break;
        case 1:
            strings2 =[[NSArray alloc] initWithObjects:@"  1",@"  2",@"  3",@"  4",@"  5",@"  6",@"  7",@"  8",@"  9",@" 10",@" 11",@" 12",@" 13",@" 14",@" 15",@" 16",@" 17",@" 18",@" 19",@" 20",@" 21",@" 22",@" 23",@" 24",@" 25",@" 26",@" 27",@" 28",@" 29",@" 30",@" 31",@" 32",@" 33",@" 34",@" 35",@" 36",@" 37",@" 38",@" 39",@" 40",@" 41",@" 42",@" 43",@" 44",@" 45",@" 46",@" 47",@" 48",@" 49",@" 50",@" 51",@" 52",@" 53",@" 54",@" 55",@" 56",@" 57",@" 58",@" 59", nil];
            stringsok = strings2;
            selecter2 = 1;
            break;
        case 2:
            strings3 =[[NSArray alloc] initWithObjects:@"  1",@"  2",@"  3",@"  4",@"  5",@"  6",@"  7",@"  8",@"  9",@" 10",@" 11",@" 12",@" 13",@" 14",@" 15",@" 16",@" 17",@" 18",@" 19",@" 20",@" 21",@" 22",@" 23",@" 24",@" 25",@" 26",@" 27",@" 28",@" 29",@" 30",@" 31",@" 32",@" 33",@" 34",@" 35",@" 36",@" 37",@" 38",@" 39",@" 40",@" 41",@" 42",@" 43",@" 44",@" 45",@" 46",@" 47",@" 48",@" 49",@" 50",@" 51",@" 52",@" 53",@" 54",@" 55",@" 56",@" 57",@" 58",@" 59", nil];
            stringsok = strings3;
            selecter2 = 2;
            break;
        case 3:
            strings4 =[[NSArray alloc] initWithObjects:@" 分鐘",@" 小時", nil];
            stringsok = strings4;
            selecter2 = 3;
            break;
        case 4:
            strings5 =[[NSArray alloc] initWithObjects:@"  5",@"  2",@"  3",@"  4",@"  5",@"  6",@"  7",@"  8",@"  9",@" 10", nil];
            stringsok = strings5;
            selecter2 = 4;
            break;
        case 5:
            strings6 =[[NSArray alloc] initWithObjects:@"  6",@"  2",@"  3",@"  4",@"  5",@"  6",@"  7",@"  8",@"  9",@" 10", nil];
            stringsok = strings6;
            selecter2 = 5;
            break;
            
    }
    
    
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(-10, aScreenRect.size.height-180, 330, 120)];
    myPickerView.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    myPickerView.delegate = self;
    [self.view addSubview:myPickerView];
    
    chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor = [UIColor clearColor];
    chooseBtn.frame = CGRectMake(275, aScreenRect.size.height-180, 40, 35);
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    chooseBtn.layer.cornerRadius = 2;
    chooseBtn.layer.masksToBounds = YES;
    [chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chooseBtn setTitle:@"確定" forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(doneClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseBtn];
    
    
    

    tableLine =[UIBezierPath bezierPath];
    //make line layer
    layer2=[CAShapeLayer layer];
    
    [tableLine moveToPoint:CGPointMake(0, aScreenRect.size.height-110)];
    [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, aScreenRect.size.height-110)];
    layer2.path=[tableLine CGPath];
    layer2.strokeColor=[[UIColor blackColor]CGColor];
    layer2.lineWidth=0.2;
    layer2.fillColor=[[UIColor clearColor]CGColor];
    
    
    //show line
    [self.view.layer addSublayer:layer2];
    
    
    
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSUInteger)row forComponent:(NSUInteger)component; {
    
    int ggggg;
    switch (selecter2) {
        case 0:
            ggggg = 2;
            break;
        case 1:
            ggggg = 59;
            break;
        case 2:
            ggggg = 59;
            break;
        case 3:
            ggggg = 2;
            break;
        case 4:
            break;
        case 5:
            break;
            
    }
    
    
    
    return [stringsok objectAtIndex:(row%ggggg)];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSUInteger)row inComponent:(NSUInteger)component {
    
    
    
    switch (selecter2) {
        case 0:
            test2.text = [strings objectAtIndex:row%2];
            break;
        case 1:
            test.text = [strings2 objectAtIndex:row%59];
            break;
        case 2:
            test3.text = [strings3 objectAtIndex:row%59];
            break;
        case 3:
            test4.text = [strings4 objectAtIndex:row%2];
            break;
        case 4:
            test5.text = [strings5 objectAtIndex:row%10];
            break;
        case 5:
            test6.text = [strings6 objectAtIndex:row%10];
            break;
            
    }
    
    
    
    
    
    
    
}

- (NSUInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSUInteger)component {
    
    
    int ggggg;
    switch (selecter2) {
        case 0:
            ggggg = 2;
            break;
        case 1:
            ggggg = 16384;
            break;
        case 2:
            ggggg = 16384;
            break;
        case 3:
            ggggg = 2;
            break;
        case 4:
            break;
        case 5:
            break;
            
    }
    
    
    return ggggg;
}

- (NSUInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(void)doneClick
{
    [layer2 removeFromSuperlayer];
    [myPickerView removeFromSuperview];
    [myPickerView2 removeFromSuperview];
    [chooseBtn removeFromSuperview];
    _nextStep.hidden = NO;
    
}








-(void)next
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:5 forKey:@"ggg"];
    [defaults synchronize];
    
    
    sideEffectViewController *nVC = [[sideEffectViewController  alloc]init];
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


//欄位數量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"有 %lu 筆",(unsigned long)[list_data count]);
    return  2;
}

//欄寬 ＊６０
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//狀態
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
}

//設定只能有一個開啟
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
