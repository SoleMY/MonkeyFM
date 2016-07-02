//
//  NetWorking.h
//  MonkeyFM
//
//  Created by 郑淮予  on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(id array);
@interface NetWorking : NSObject

@property (nonatomic, strong)NSMutableArray *titleArray;

@property (nonatomic, strong)NSMutableArray *hostArray;
- (void)requestWithURL:(NSString *)URL Bolck:(Block)block;

@end
