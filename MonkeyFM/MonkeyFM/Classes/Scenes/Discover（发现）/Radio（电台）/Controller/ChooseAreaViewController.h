//
//  ChooseAreaViewController.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"


typedef void(^Block)(NSInteger, NSString *);
@interface ChooseAreaViewController : BaseViewController

@property (nonatomic, copy) Block block;

@end
