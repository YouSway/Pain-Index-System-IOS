//
//  ViewController.h
//  table
//
//  Created by 黃柏鈞 on 2016/3/11.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface hurtCycle2ViewController :UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>

@property (nonatomic, retain) UIPickerView *myPickerView;
@property (nonatomic, strong) NSString *Paincurve_value;//公共属性,用于传值
@property (nonatomic, strong) NSString *hurtPlace_value;//公共属性,用于传值
@property (nonatomic, strong) NSString *hurtType_value;
@property (nonatomic, strong) NSString *hurtCycle_value;
@end

