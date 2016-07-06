//
//  RadioDisPlayCollectionViewCell.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioDisplayModel;
@class RadioDisplayPlayModel;
@interface RadioDisPlayCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSTimer *timer;

- (void)bindModel:(RadioDisplayModel *)model;

- (void)bindPlayModel:(RadioDisplayPlayModel *)playModel;



@end
