//
//  NetworkMonitoringManager.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "NetworkMonitoringManager.h"

@interface NetworkMonitoringManager ()

{
    BOOL isOpen;
}
/// 用于网络请求的session对象
@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation NetworkMonitoringManager

singletion_implementation(NetworkMonitoringManager)

- (void)openMonioring
{
    // 打开网络监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

}

- (void)closeMonioring
{
    // 关闭网络监测
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (void)networkMonitoringAction
{
    // 接下来会判断当前是wifi状态还是3G状态还是网络不可用状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.status = UnKnow;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.status = NotReachable;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.status = WWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.status = WiFi;
                break;
            default:
                break;
        }
    }];
}

@end
