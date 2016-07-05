//
//  ProgramViewController.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ProgramBlock)();
@interface ProgramViewController : BaseViewController

@property (nonatomic, strong)ProgramBlock blcok;

@property (nonatomic, strong)NSString *URLString;

@end
