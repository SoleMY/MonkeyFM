//
//  shuffingNetRequest.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

typedef void(^Block)(id array);

@interface shuffingNetRequest : NSObject
- (void)requestDataWithString:(NSString *)URL Block:(Block)block;
@property (nonatomic, strong)NSMutableArray *allImageArray;
@end
