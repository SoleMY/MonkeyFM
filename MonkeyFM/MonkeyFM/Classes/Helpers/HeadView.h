//
//  HeadView.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseView.h"

@interface HeadView : BaseView <UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame URLArray:(NSMutableArray *)URLArray;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong)NSTimer *timer;

@end
