//
//  RadioAreaModel.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioAreaModel.h"

@implementation RadioAreaModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
