//
//  hurtHandleViewController.h
//  shitbar
//
//  Created by 黃柏鈞 on 2016/3/29.
//  Copyright © 2016年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"


@interface hurtHandleViewController: UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,SWTableViewCellDelegate,UITextViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) NSString *Paincurve_value;//公共属性,用于传值
@property (nonatomic, strong) NSString *hurtPlace_value;//公共属性,用于传值
@property (nonatomic, strong) NSString *hurtType_value;
@property (nonatomic, strong) NSString *hurtCycle_value;
@end
