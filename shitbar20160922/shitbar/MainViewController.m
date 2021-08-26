//
//  MainViewController.m
//  Loading
//
//  Created by user on 2016/3/13.
//  Copyright © 2016年 user. All rights reserved.
//

#import "MainViewController.h"

#import "PaincurveListViewController.h"
#import "PainrecordListViewController.h"
#import "PersonalinformationListViewController.h"
#import "CareteamListViewController.h"
#import "UIDefine.h"



@interface MainViewController(){
    
    PersonalinformationListViewController *Person;
    CareteamListViewController *Care;
    PainrecordListViewController *Painr;
    PaincurveListViewController *Painc;
    
    
}

@end



@implementation MainViewController

-(void)viewDidLoad{
  
    
    
    CGRect aScreenRect = [[UIScreen mainScreen] bounds];
    //選擇時bar背景圖片
    UIImage *image = [self imageWithImage:[UIImage imageNamed:@"tabbarselect"] scaledToSize:CGSizeMake(aScreenRect.size.width/4, 60)];
    self.tabBar.selectionIndicatorImage = image;
    //選擇時bar前景圖片顏色
    self.tabBar.tintColor = [UIColor whiteColor];
    
    [self setupSubviews];
    [self.navigationController setNavigationBarHidden:NO];
    self.selectedIndex = 0;
    self.title = @"個人資料";
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:0 forKey:@"ggg"];
    [defaults synchronize];
    
    
    
    
}


//tabbar高度控制
- (void)viewWillLayoutSubviews
{
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = 60;
    tabFrame.origin.y = self.view.frame.size.height - 60;
    self.tabBar.frame = tabFrame;
}


- (void)setupSubviews
{
    self.tabBar.backgroundColor = RGBACOLOR(238, 238, 238, 1);
    //個人資料
    Person = [[PersonalinformationListViewController alloc] init];
    UIImage *personalinformationIcon = [self imageWithImage:[UIImage imageNamed:@"personalinformation"] scaledToSize:CGSizeMake(50, 50)];
    Person.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                         image:personalinformationIcon
                                                           tag:0];
    Person.tabBarItem.imageInsets = UIEdgeInsetsMake(6,0,-6,0);
    [self unSelectedTapTabBarItems:Person.tabBarItem];
    [self selectedTapTabBarItems:Person.tabBarItem];
    //UINavigationController *ncPerson = [[UINavigationController alloc] initWithRootViewController:Person];
    //UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(homeLeftClick:)];
    //UIBarButtonItem *FriendAddButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Friend_Add)];
    
    
    
    
    /*UIImage *friendAddIcon = [self imageWithImage:[UIImage imageNamed:@"friend_add"] scaledToSize:CGSizeMake(50, 50)];
    UIBarButtonItem *FriendAddButton = [[UIBarButtonItem alloc] initWithImage:friendAddIcon style:UIBarButtonItemStylePlain target:self action:@selector(Friend_Add)];
    self.navigationItem.rightBarButtonItem = FriendAddButton;*/
    
    //照護團隊
    Care = [[CareteamListViewController alloc] init];
    Care.tabBarItem = [[UITabBarItem alloc] init];
    UIImage *careteamIcon = [self imageWithImage:[UIImage imageNamed:@"careteam"] scaledToSize:CGSizeMake(65, 50)];
    Care.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                        image:careteamIcon
                                                          tag:1];
    Care.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self unSelectedTapTabBarItems:Care.tabBarItem];
    [self selectedTapTabBarItems:Care.tabBarItem];
    //UINavigationController *ncCare = [[UINavigationController alloc] initWithRootViewController:Care];
    
     /*UIViewController *vc3 = [[UIViewController alloc] init];
     vc3.title = @"vc3";
     vc3.view.backgroundColor = [UIColor purpleColor];
     UINavigationController *nc3 = [[UINavigationController alloc] initWithRootViewController:vc3];
     [vc3 release];*/
    
    //疼痛曲線
    Painc = [[PaincurveListViewController alloc] init];
    UIImage *paincurveIcon = [self imageWithImage:[UIImage imageNamed:@"painrecord"] scaledToSize:CGSizeMake(55, 55)];
    Painc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                     image:paincurveIcon
                                                       tag:2];
    Painc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self unSelectedTapTabBarItems:Painc.tabBarItem];
    [self selectedTapTabBarItems:Painc.tabBarItem];
    UINavigationController *ncPainc = [[UINavigationController alloc] initWithRootViewController:Painc];
    
    
    //疼痛紀錄
    Painr = [[PainrecordListViewController alloc] init];
    UIImage *painrecordIcon = [self imageWithImage:[UIImage imageNamed:@"paincurve"] scaledToSize:CGSizeMake(50, 50)];
    Painr.tabBarItem = [[UITabBarItem alloc] initWithTitle:@""
                                                      image:painrecordIcon
                                                        tag:3];
    Painr.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    [self unSelectedTapTabBarItems:Painr.tabBarItem];
    [self selectedTapTabBarItems:Painr.tabBarItem];
    //UINavigationController *ncPainr = [[UINavigationController alloc] initWithRootViewController:Painr];
    

    
    
    
    self.viewControllers = @[Person, Care, ncPainc, Painr];
    [self selectedTapTabBarItems:Person.tabBarItem];
    
    //Painc.tabBarItem.badgeValue = @"10";
    
}



-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    
    if (item.tag == 0)
    {
            //self.title = NSLocalizedString(@"title.conversation", @"Conversations");
            self.title = @"個人資料";
        self.navigationItem.leftBarButtonItem = nil;
        
        
        
    }else if (item.tag == 1){
            //        self.title = NSLocalizedString(@"title.addressbook", @"AddressBook");
            self.title = @"照護團隊";
        self.navigationItem.leftBarButtonItem = nil;
        
        }else if (item.tag == 2){
            //        self.title = NSLocalizedString(@"title.addressbook", @"AddressBook");

//            UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
//            self.navigationItem.leftBarButtonItem = left;
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            int ccc = [defaults integerForKey:@"ggg"];
            NSLog(@"%d",ccc);
            
            switch (ccc) {
                case 0:
                    self.title = @"疼痛分數";
                    break;
                case 1:
                    self.title = @"疼痛部位-正面";
                    //self.tabBarController.navigationItem = left;
                    break;
                case 2:
                    self.title = @"疼痛性質";
                    //    self.tabBarController.navigationItem.leftBarButtonItem = left;
                    break;
                case 21:
                    self.title = @"疼痛部位-正面";
                    //    self.tabBarController.navigationItem.leftBarButtonItem = left;
                    break;
                case 22:
                    self.title = @"疼痛部位-背面";
                    //    self.tabBarController.navigationItem.leftBarButtonItem = left;
                    break;
                case 3:
                    self.title = @"疼痛周期";
                    break;
                case 4:
                    self.title = @"疼痛處理";
                    break;
                case 5:
                    self.title = @"副作用";
                    break;
                case 6:
                    self.title = @"疼痛周期";
                    break;
                case 7:
                    self.title = @"目前心情";
                    break;
                case 8:
                    self.title = @"睡眠品質";
                    break;
                case 9:
                    self.title = @"填寫完成";
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"hasDone" //Notification以一個字串(Name)下去辨別
                     object:self
                     userInfo:nil];
                    break;
                default:
                    break;
            }
        }else if (item.tag == 3){
            //        self.title = NSLocalizedString(@"title.addressbook", @"AddressBook");
            self.title = @"疼痛曲線";
            self.navigationItem.leftBarButtonItem = nil;
    }
    
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    //    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                        [UIFont systemFontOfSize:14], UITextAttributeFont,[UIColor whiteColor],UITextAttributeTextColor,
    //                                        nil] forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    //    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
    //                                        [UIFont systemFontOfSize:14],
    //                                        UITextAttributeFont,RGBACOLOR(0x00, 0xac, 0xff, 1),UITextAttributeTextColor,
    //                                        nil] forState:UIControlStateSelected];
    
}

-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)personalinformation{
    //FriendAddViewController *friendadd = [[FriendAddViewController alloc]init];
    //[self.navigationController pushViewController:friendadd animated:nil];
}

-(void)careteam{
    //DebugLog(@"groupAdd");
}
-(void)painrecord{
    //FriendAddViewController *friendadd = [[FriendAddViewController alloc]init];
    //[self.navigationController pushViewController:friendadd animated:nil];
}

-(void)paincurve{
    //DebugLog(@"groupAdd");
}


@end
