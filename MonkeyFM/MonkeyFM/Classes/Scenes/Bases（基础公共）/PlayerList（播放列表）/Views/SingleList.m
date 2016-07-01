//
//  SingleList.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SingleList.h"

@implementation SingleList

static SingleList *list;
+ (instancetype)shareSingleList {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = [[[self class] alloc] init];
        if (!list.dict) {
            list.dict = [NSMutableDictionary dictionary];
        }
    });
    return list;
}

@end
