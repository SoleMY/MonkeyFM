//
//  RadioDisplayModel.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/2.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioDisplayModel.h"

@implementation RadioDisplayModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
