//
//  ViewController.m
//  table
//
//  Created by 黃柏鈞 on 2016/3/11.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "sleepQualityViewController.h"
#import "UIDefine.h"

#import "doneViewController.h"

//宣告全域變數
@interface sleepQualityViewController (){
    UILabel *title;
    UILabel *profession;
    UILabel *personName;
    UILabel *phone;
    UILabel *phoneNumber;
    NSString *professionTxt;
    NSString *personNameTxt;
    NSString *phoneNumberTxt;
    NSString *labelpic;
    UIButton *chooseBtn;
    UIButton *chooseBtn2;
    UIButton * _nextStep;
    UIImageView *listchoose1;
    UIImageView *listchoose2;
    UIImageView *listchoose3;
    UIImageView *listchoose4;
    UIImageView *listchoose5;
    UILabel *listchooseb1;
    UILabel *listchooseb2;
    UILabel *listchooseb3;
    UILabel *listchooseb4;
    UILabel *listchooseb5;
    
    UIButton *listchooseb1_F;
    UIButton *listchooseb2_F;
    UIButton *listchooseb3_F;
    UIButton *listchooseb4_F;
    UIButton *listchooseb5_F;
    
    
    NSMutableArray *testData;
}

//
@property (strong, nonatomic) UITableView *userDataList;
@end

@implementation sleepQualityViewController


- (void)viewDidLoad {
    // [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //testDaTA
    testData = [[NSMutableArray alloc]init];
    
    for (int i=0; i<5; i++) {
        NSMutableDictionary *dct = [[NSMutableDictionary alloc]init];
        if (i==0) [dct setValue:[NSString stringWithFormat:@"有靠藥物但睡得很好"] forKey:@"menu"];
        if (i==1) [dct setValue:[NSString stringWithFormat:@"沒靠藥物且睡得很好"] forKey:@"menu"];
        if (i==2) [dct setValue:[NSString stringWithFormat:@"有靠藥物但睡得很差"] forKey:@"menu"];
        if (i==3) [dct setValue:[NSString stringWithFormat:@"沒靠藥物且睡得很差"] forKey:@"menu"];
        if (i==4) [dct setValue:[NSString stringWithFormat:@"還可以"] forKey:@"menu"];
        [dct setValue:@"0" forKey:@"switch"];
        [testData addObject:dct];
        
    }
    
    
    
    //取得螢幕資料
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    _userDataList = [[UITableView alloc] init];
    
    
    //上頭的註解
    CGRect labelFrame = CGRectMake(0, 20 , 500, 20);
    UILabel *titleback = [[UILabel alloc] initWithFrame:labelFrame];
    [titleback setTextColor:[UIColor blackColor]];
    UIColor *bg = RGBACOLOR(237, 237, 237, 1);
    [titleback setBackgroundColor:bg];
    [self.view addSubview:titleback];
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 500, 20)];
    title.textColor = RGBACOLOR(150, 150, 150, 1);
    title.text = @"【單選】昨晚睡眠品質狀況";
    [title setFont:[UIFont fontWithName:@"Helvetica" size:9]];
    [self.view addSubview:title];
    
    self.tabBarController.title = @" 睡眠品質";
    
    
    //table參數設定
    [_userDataList setFrame:CGRectMake(0, 65, aScreenRect.size.width-0, aScreenRect.size.height-150)];
    [_userDataList setDataSource:self];
    [_userDataList setDelegate:self];
    //將物件顯示出來
    [self.view addSubview:_userDataList];
    //禁止頁面滑動
    _userDataList.scrollEnabled = NO;
    //清除TABLE的框
    _userDataList.separatorColor = [UIColor clearColor];
    
    //make line
    UIBezierPath *tableLine =[UIBezierPath bezierPath];
    //make line layer
    CAShapeLayer *layer=[CAShapeLayer layer];
    for(int i=0;i<=4;i++){
        [tableLine moveToPoint:CGPointMake(0, 90+(45*i)+20)];
        [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 90+(45*i)+20)];
        layer.path=[tableLine CGPath];
        layer.strokeColor=[[UIColor grayColor]CGColor];
        layer.lineWidth=0.25;
        layer.fillColor=[[UIColor clearColor]CGColor];
        
    }
    //show line
    [self.view.layer addSublayer:layer];
    //BGCOLOR
    _userDataList.backgroundColor=RGBACOLOR(245, 245, 245, 1);
}

#pragma mark - TableViewDelegate & TableViewDatasource

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
        // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //cell.editing = YES;
        
        
    }
    NSLog(@"reload");
    
    
    
    
    if (indexPath.row == 5) {
        [[cell.contentView viewWithTag:333]removeFromSuperview];
        
        _nextStep=[[UIButton alloc] init];
        _nextStep=[UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStep setFrame:CGRectMake(10, 10, self.view.frame.size.width-20, 40)];
        [_nextStep setTitle:@"儲存" forState:UIControlStateNormal];
        _nextStep.layer.cornerRadius = 5;
        [_nextStep setBackgroundColor:RGBACOLOR(249, 193, 6, 1)];
        [_nextStep addTarget:self action:@selector(toNext) forControlEvents:UIControlEventTouchUpInside];
        cell.tag = 333;
        [cell.contentView addSubview:_nextStep];
        NSLog(@"cell");
        return cell;
    }
    
    
    
    
    [[cell.contentView viewWithTag:222]removeFromSuperview];
    
    listchooseb1_F = [UIButton buttonWithType:UIButtonTypeCustom];
    listchooseb1_F.frame = CGRectMake(10, 6, 25, 25);
    [listchooseb1_F setTitle:@"" forState:UIControlStateNormal];
    listchooseb1_F.backgroundColor = RGBACOLOR(0, 170, 201, 0);
    //UIControlEventTouchUpInside
    [listchooseb1_F addTarget:self action:@selector(switchButtonTapped:event:) forControlEvents:UIControlEventTouchDown];
    
    
    if ([[[testData objectAtIndex:indexPath.row] objectForKey:@"switch"] boolValue]) {
        [listchooseb1_F setImage:[UIImage imageNamed:@"redyes"] forState:UIControlStateNormal];
    }else{
        [listchooseb1_F setImage:[UIImage imageNamed:@"empty"] forState:UIControlStateNormal];
    }
    
    listchooseb1_F.tag=222;
    //    [listchooseb1_F setImage:[UIImage imageNamed:@"empty"]
    //            forState:UIControlStateNormal];
    //    [listchooseb1_F setImage:[UIImage imageNamed:@"redyes"]
    //            forState:UIControlStateSelected];
    
    //    [tableView addSubview:listchooseb1_F];
    
    [cell.contentView addSubview:listchooseb1_F];
    
    
    [[cell.contentView viewWithTag:111]removeFromSuperview];
    //名稱
    personName = [[UILabel alloc] initWithFrame:CGRectMake(50, -10, 500, 60)];
    personName.tag = 111;
    personName.font=[UIFont fontWithName:@"Helvetica" size:16];
    personName.textColor=RGBACOLOR(108, 108, 108, 1);
    personName.text = [[testData objectAtIndex:indexPath.row] objectForKey:@"menu"];
    [cell.contentView addSubview:personName];
    
    return cell;
}










//choose1234




//欄位數量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  testData.count+1;
}

//欄寬 ＊６０
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 5) {
        return 60;
    }
    return 45;
}

//狀態
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
}

//設定只能有一個開啟
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    NSLog(@"onSwipe");
    return YES;
}

-(void)toNext{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:9 forKey:@"ggg"];
    [defaults synchronize];
    
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    
    NSLog(@"toNext");
    doneViewController  *nVC = [[doneViewController alloc]init];
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


- (void)switchButtonTapped:(id)sender event:(id)event{
    
    NSLog(@"switch");
    [(UIButton *)sender setSelected:![(UIButton *)sender isSelected]];
    //UIButton *btn=sender;
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:_userDataList];
    NSIndexPath *indexPath = [_userDataList indexPathForRowAtPoint: currentTouchPosition];
    for (int i=0; i<testData.count; i++) {
        //重新init，洗白
        //setObject:@"0" -> unselect
        [[testData objectAtIndex:i] setObject:@"0" forKey:@"switch"];
        NSIndexPath *ipt = [NSIndexPath indexPathForRow:i inSection:0];
        UITableViewCell *cell = [_userDataList cellForRowAtIndexPath:ipt];
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    //上色
    //setObject:@"1" -> select
    [[testData objectAtIndex:indexPath.row] setObject:@"1" forKey:@"switch"];
    UITableViewCell *cell = [_userDataList cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    
    
    [_userDataList reloadData];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
