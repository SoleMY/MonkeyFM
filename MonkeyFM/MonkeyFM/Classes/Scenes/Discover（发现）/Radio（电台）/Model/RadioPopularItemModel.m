//
//  RadioPopularItemModel.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioPopularItemModel.h"

@implementation RadioPopularItemModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
