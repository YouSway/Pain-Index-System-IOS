//
//  PersonalinformationListViewController.m
//  Loading
//
//  Created by user on 2016/3/13.
//  Copyright © 2016年 user. All rights reserved.
//


#import "PersonalinformationListViewController.h"
#import "UIDefine.h"

//宣告全域變數
@interface PersonalinformationListViewController (){
    UILabel *dataLabel;
    UILabel *userDataLabel;
    NSString *dataLabelTxt;
    NSString *userDataLabelTxt;
    NSString *labelpic;
}

//
@property (strong, nonatomic) UITableView *userDataList;

@end

@implementation PersonalinformationListViewController


- (void)viewDidLoad {
    // [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //取得螢幕資料
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    _userDataList = [[UITableView alloc] init];
    //table參數設定
    [_userDataList setFrame:CGRectMake(0, 0, aScreenRect.size.width-0, aScreenRect.size.height)];
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
    for(int i=0;i<=6;i++){
        [tableLine moveToPoint:CGPointMake(0, 64+(45*i))];
        [tableLine addLineToPoint:CGPointMake(aScreenRect.size.width, 64+(45*i))];
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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *personInfo = [userDefaults dictionaryForKey:@"personInfo"];
    personInfo=[personInfo objectForKey:@"data"];
    
    NSArray*personInfo_ary;
    personInfo_ary=[personInfo objectForKey:@"item"];
    personInfo=[personInfo_ary objectAtIndex:0];
    NSLog(@"%@",personInfo);
    
    
    
    
    //文字圖片內容
    switch (indexPath.row) {
        case 0:
            dataLabelTxt=@"身分證號";
            userDataLabelTxt=@"F123456789";
            labelpic=@"id";
            break;
        case 1:
            dataLabelTxt=@"姓名";
            userDataLabelTxt=@"胡阿水";
            labelpic=@"name";
            break;
        case 2:
            dataLabelTxt=@"生日";
            userDataLabelTxt=@"19900101";
            labelpic=@"birthday";
            break;
        case 3:
            dataLabelTxt=@"性別";
            userDataLabelTxt=@"男";
            labelpic=@"sexy";
            break;
        case 4:
            dataLabelTxt=@"病例號碼";
            userDataLabelTxt=@"123456789";
            labelpic=@"number";
            break;
        case 5:
            dataLabelTxt=@"電話";
            userDataLabelTxt=@"0123456789";
            labelpic=@"phone";
            break;
        case 6:
            dataLabelTxt=@"收案日";
            userDataLabelTxt=@"20160312";
            labelpic=@"day";
            break;
        default:
            dataLabelTxt=@"error";
            userDataLabelTxt=@"error";
            labelpic=@"accountset";
            break;
    }
    //TABLE圖片
    // [cell.imageView setImage:[UIImage imageNamed:labelpic] ];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 32, 32)];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView.layer setCornerRadius:8.0f];
    [imageView.layer setMasksToBounds:YES];
    [imageView setImage:[UIImage imageNamed:labelpic]];
    [cell.contentView addSubview:imageView];
    
    
    
    //[[cell.contentView viewWithTag:111]removeFromSuperview];
    //文字1
    dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, -10, 175, 60)];
    dataLabel.tag = 111;
    dataLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    dataLabel.textColor=RGBACOLOR(108, 108, 108, 100);
    dataLabel.text = [NSString stringWithFormat:dataLabelTxt];
    [cell.contentView addSubview:dataLabel];
    //文字2
    userDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, -10, 175, 60)];
    userDataLabel.tag = 111;
    userDataLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    userDataLabel.text = [NSString stringWithFormat:userDataLabelTxt];
    //NSLog(@"%ld",indexPath.row);
    [cell.contentView addSubview:userDataLabel];
    return cell;
}



//欄位數量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"有 %lu 筆",(unsigned long)[list_data count]);
    return  7;
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
