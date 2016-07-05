//
//  HostTitle.h
//  MonkeyFM
//
//  Created by 郑淮予  on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostTitle : NSObject

@property (nonatomic, assign)NSInteger contentType;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSArray *dataList;
@property (nonatomic, strong)NSString *relatedValue;
@property (nonatomic, strong)NSString *pic;
@property (nonatomic, strong)NSString *Id;

@end
