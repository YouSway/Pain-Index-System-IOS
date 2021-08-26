//
//  Webservice.h
//  cocoa2
//
//  Created by 黃柏鈞 on 2016/9/11.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Webservice : NSObject
+  (void)requestPostUrl:(NSString *)strURL parameters:(NSDictionary *)dictParams success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure;
@end
