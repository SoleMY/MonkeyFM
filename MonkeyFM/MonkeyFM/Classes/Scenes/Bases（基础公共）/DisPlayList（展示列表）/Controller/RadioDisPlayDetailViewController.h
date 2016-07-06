//
//  RadioDisPlayDetailViewController.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"

@interface RadioDisPlayDetailViewController : BaseViewController

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger classifyid;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger area;

@property (nonatomic, strong) NSIndexPath *scrollIndexPath;

@end
