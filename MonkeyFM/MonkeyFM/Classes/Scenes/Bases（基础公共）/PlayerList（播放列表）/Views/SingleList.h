//
//  SingleList.h
//  MonkeyFM
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleList : NSObject

@property (nonatomic, strong)NSMutableDictionary *dict;
@property (nonatomic, strong)NSMutableDictionary *objectIDdic;
@property (nonatomic, strong)NSMutableDictionary *subscribeIDdic;
+ (instancetype)shareSingleList;

@end
