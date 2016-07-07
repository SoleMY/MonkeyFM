//
//  RadioViewController.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^pushBackBlock)();
@interface RadioViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, copy) pushBackBlock pushBack;


@end
