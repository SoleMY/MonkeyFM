//
//  Request.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Request : NSObject
@property (nonatomic,strong)NSMutableArray *marray;
- (void)requestWithURL:(NSString *)URL view:(UIView *)view frame:(CGRect)frame;
@end
