//
//  UIDefine.h
//  newMM
//
//  Created by 胡陞銘 on 2016/2/17.
//  Copyright (c) 2016年 Sheng,Ming. All rights reserved.
//

#ifndef newMM_UIDefine_h
#define newMM_UIDefine_h

#import "MBProgressHUD.h"

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define HEXCOLOR(hex) [UIColor UIColorFromRGB(hex)]


#define DebugLog(message, ...) NSLog(@"%s: " message, __PRETTY_FUNCTION__, ##__VA_ARGS__)

#endif
