//
//  Webservice.m
//  cocoa2
//
//  Created by 黃柏鈞 on 2016/9/11.
//  Copyright © 2016年 黃柏鈞. All rights reserved.
//

#import "Webservice.h"
#import <AFNetworking.h>

@implementation Webservice
+  (void)requestPostUrl:(NSString *)strURL parameters:(NSDictionary *)dictParams success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    
    [manager POST:strURL parameters:dictParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            if(success) {
                success(responseObject);
            }
        }
        else {
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            if(success) {
                success(response);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure) {
            failure(error);
        }
        
    }];
}
@end
