//
//  hirtCycleViewController.h
//  shitbar
//
//  Created by 黃柏鈞 on 2016/3/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface hirtCycleViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate>

@property (nonatomic, retain) UIPickerView *myPickerView;
@property (nonatomic, retain) UIPickerView *myPickerView2;


@property (nonatomic, strong) NSString *Paincurve_value;//公共属性,用于传值
@property (nonatomic, strong) NSString *hurtPlace_value;//公共属性,用于传值
@property (nonatomic, strong) NSString *hurtType_value;
@end
