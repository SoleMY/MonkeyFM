//
//  NetWorking.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "NetWorking.h"
#import <AFNetworking.h>
#import "MFM_URL.h"
#import "HostTitle.h"
#import "Host.h"
@implementation NetWorking

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

- (NSMutableArray *)hostArray {
    if (!_hostArray) {
        _hostArray = [NSMutableArray array];
    }
    return _hostArray;
}


- (void)requestWithURL:(NSString *)URL Bolck:(Block)block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)request {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:shuffing_host_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *resultDic = responseObject[@"result"];
//        NSArray *dataListArray = [resultDic objectForKey:@"dataList"];
//        for (NSDictionary *dict in dataListArray) {
//            HostTitle *title = [[HostTitle alloc] init];
//            [title setValuesForKeysWithDictionary:dict];
//            [self.titleArray addObject:title];
//            if (title.contentType == 4) {
//                for (NSDictionary *dic in title.dataList) {
//                    Host *host = [[Host alloc] init];
//                    [host setValuesForKeysWithDictionary:dic];
//                    [self.hostArray addObject:host];
//                }
//            }
//        }
//        NSLog(@"%@", self.titleArray);
////        nsl
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
    
}


@end
