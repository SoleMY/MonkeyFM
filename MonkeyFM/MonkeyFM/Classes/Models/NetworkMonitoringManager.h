//
//  NetworkMonitoringManager.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ReachabilityStatus) {
    UnKnow,
    NotReachable,
    WiFi,
    WWAN,
};

@interface NetworkMonitoringManager : NSObject

@property (nonatomic, assign) ReachabilityStatus status;

singleton_interface(NetworkMonitoringManager)

- (void)openMonioring;
- (void)closeMonioring;
- (void)networkMonitoringAction;

@end
