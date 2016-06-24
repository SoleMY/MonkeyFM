//
//  shuffingNetRequest.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "shuffingNetRequest.h"
#import "shufflingModel.h"


@implementation shuffingNetRequest

- (void)requestDataWithString:(NSString *)URL Block:(Block)block{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     if (block) {
         block(responseObject);
     }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

@end
