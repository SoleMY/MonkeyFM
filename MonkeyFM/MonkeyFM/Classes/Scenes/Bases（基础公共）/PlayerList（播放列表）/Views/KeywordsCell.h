//
//  KeywordsCell.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseCell.h"

@interface KeywordsCell : BaseCell

@property (nonatomic, strong)UILabel *keywordLabel;

@property (nonatomic, strong)NSMutableArray *buttonArray;

@property (nonatomic, strong)NSMutableArray *arr;

@property (nonatomic, assign)CGFloat allWidth;

@property (nonatomic, assign)NSInteger numberOfButton;

@end
