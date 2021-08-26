//
//  CareteamListViewController.m
//  Loading
//
//  Created by user on 2016/3/13.
//  Copyright © 2016年 user. All rights reserved.
//

#import "CareteamListViewController.h"
#import "UIDefine.h"
#import "Webservice.h"

//宣告全域變數
@interface CareteamListViewController (){
    UILabel *profession;
    UILabel *personName;
    UILabel *phone;
    UILabel *phoneNumber;
    NSString *professionTxt;
    NSString *personNameTxt;
    NSString *phoneNumberTxt;
    NSString *labelpic;
    
    //json
    NSString *j_success;
    NSString *j_items;//資料數量
    NSArray *j_careTeam1;
    NSMutableArray *j_careTeam2;
}

//
@property (strong, nonatomic) UITableView *userDataList;

@end

@implementation CareteamListViewController

-(void)logoinCheck:(NSDictionary *)dic{
    
    dic=[dic objectForKey:@"data"];
    j_success=[dic objectForKey:@"success"];
    
    if ([j_success isEqualToString:@"true"]) {//檢查狀態
        j_items=[dic objectForKey:@"items"];
        
        j_careTeam1=[dic objectForKey:@"item"];//載入item
        j_careTeam2=[[NSMutableArray alloc]init];//初始化
        
        //write
        for (int i=0; i<[j_items intValue]; i++) {
             [j_careTeam2 addObject:[j_careTeam1 objectAtIndex:i]];
            NSLog(@"J2:%@",[j_careTeam2 objectAtIndex:i]);
        }

    }
   
    [self setTable];
//    NSLog(@"%@",dic);
//    NSLog(@"%@",j_items);
//    NSLog(@"%@",j_success);
//    NSLog(@"J1:%@",j_careTeam1);
    

}

-(void)setTable{
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    _userDataList = [[UITableView alloc] init];
    //table參數設定
    [_userDataList setFrame:CGRectMake(0, 64, aScreenRect.size.width-0, aScreenRect.size.height)];
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
    for(int i=0;i<=[j_items intValue];i++){
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

-(void)viewWillAppear:(BOOL)animated{
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    [_userDataList setFrame:CGRectMake(0, 0, aScreenRect.size.width-0, aScreenRect.size.height)];
}

- (void)viewDidLoad {
        //json data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *personInfo = [userDefaults dictionaryForKey:@"personInfo"];
    personInfo=[personInfo objectForKey:@"data"];
    
    NSArray*personInfo_ary;
    personInfo_ary=[personInfo objectForKey:@"item"];
    personInfo=[personInfo_ary objectAtIndex:0];
    NSString *mrn=[personInfo objectForKey:@"medical_record_number"];
    NSLog(@"MRN:%@",mrn);
    
    NSDictionary *dictParam = @{@"mrn":mrn};
    //    NSDictionary *result=[[NSDictionary alloc]init];
    
    [Webservice requestPostUrl:@"http://220.132.42.54:8888/dsl2501Stu/careTeam.php" parameters:dictParam success:^(NSDictionary *responce) {
        //Success
        NSLog(@"responce:%@",responce);
        
        [self logoinCheck:responce];
        
        
    } failure:^(NSError *error) {
        //error
        NSLog(@"ERROR");
    }];

    
    
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
    
    NSDictionary *info=[[NSDictionary alloc]init];
    info=[j_careTeam2 objectAtIndex:indexPath.row];
    NSLog(@"INFO:%@",info);
    
    //第一行
    professionTxt=[NSString stringWithFormat:@"%@:%@",[info objectForKey:@"position"],[info objectForKey:@"name"]];
    NSLog(@"%@",professionTxt);
    //第二行
    phoneNumberTxt=[NSString stringWithFormat:@"%@",[info objectForKey:@"phone_number"]];
    NSLog(@"%@",phoneNumberTxt);
    
    //NOUSE
    personNameTxt=@"";
    labelpic=@"soso";
    
    //文字圖片內容
//    switch (indexPath.row) {
//        case 0:
//            professionTxt=@"臨床心理師/個館師： ";
//            personNameTxt=@"胡阿水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        case 1:
//            professionTxt=@"藥學部藥師： ";
//            personNameTxt=@"胡二水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        case 2:
//            professionTxt=@"物理治療師： ";
//            personNameTxt=@"胡三水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        case 3:
//            professionTxt=@"營養師： ";
//            personNameTxt=@"胡四水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        case 4:
//            professionTxt=@"社工師： ";
//            personNameTxt=@"胡五水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        case 5:
//            professionTxt=@"院牧部關懷師： ";
//            personNameTxt=@"胡六水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        case 6:
//            professionTxt=@"學長： ";
//            personNameTxt=@"胡大水";
//            phoneNumberTxt=@"0123456789 #1234";
//            labelpic=@"soso";
//            break;
//        default:
//            professionTxt=@"error";
//            personNameTxt=@"error";
//            phoneNumberTxt=@"error";
//            labelpic=@"soso";
//            break;
//    }
    //TABLE圖片
    // [cell.imageView setImage:[UIImage imageNamed:labelpic] ];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 35, 35)];
    imageView.backgroundColor = [UIColor clearColor];
    [imageView.layer setCornerRadius:8.0f];
    [imageView.layer setMasksToBounds:YES];
    [imageView setImage:[UIImage imageNamed:labelpic]];
    [cell.contentView addSubview:imageView];
    
    
    
    //[[cell.contentView viewWithTag:111]removeFromSuperview];
    //職稱
    profession = [[UILabel alloc] initWithFrame:CGRectMake(55, -16, 175, 60)];
    profession.tag = 111;
    profession.font = [UIFont fontWithName:@"Helvetica" size:10];
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
    personName = [[UILabel alloc] initWithFrame:CGRectMake(51+professionwidthIs, -16, 175, 60)];
    personName.tag = 111;
    personName.font=[UIFont fontWithName:@"Helvetica" size:10];
    personName.textColor=RGBACOLOR(0, 147, 147, 100);
    personName.text = [NSString stringWithFormat:personNameTxt];
    [cell.contentView addSubview:personName];
    
    //電話
    phone=[[UILabel alloc] initWithFrame:CGRectMake(55, -1, 175, 60)];
    phone.tag=111;
    phone.font=[UIFont fontWithName:@"Helvetica" size:10];
    phone.textColor=RGBACOLOR(108, 108, 108, 100);
    phone.text=[NSString stringWithFormat:@"電話： "];
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
    
    return cell;
}



//欄位數量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"有 %lu 筆",(unsigned long)[list_data count]);
    int value=[j_items intValue];
    NSLog(@"%d",value);
    return  value;
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
