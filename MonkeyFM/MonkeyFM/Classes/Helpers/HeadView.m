//
//  HeadView.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HeadView.h"
#import "shufflingModel.h"

#define kScrolleViewWidth self.frame.size.width * 8
#define kScrolleVieweHeight self.frame.size.height
#define kViewWidth self.frame.size.width 
#define kPageControlWidth self.frame.size.width
#define kPagecontrolHeigh 20

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame URLArray:(NSMutableArray *)URLArray {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayoutWithURLArray:URLArray];
    }
    return self;
}

- (void)initLayoutWithURLArray:(NSArray *)URLArray   {
    self.number = URLArray.count;
//    NSLog(@"%ld",(long)self.number);
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kScrolleVieweHeight)];
    self.scrollView.contentSize = CGSizeMake(kViewWidth *(URLArray.count + 2), 0);
    self.scrollView.contentOffset = CGPointMake(kViewWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
//    第一个图
    UIImageView *firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, kScrolleVieweHeight)];
    NSURL *url = [NSURL URLWithString:[URLArray objectAtIndex:URLArray.count - 1]];
    [firstImageView sd_setImageWithURL:url];
    [self.scrollView addSubview:firstImageView];
//    中间的6个图
    for (int i = 0; i < URLArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth * (i+1), 0, kViewWidth, kScrolleVieweHeight)];
        NSURL *url = [NSURL URLWithString:URLArray[i]];
        [imageView sd_setImageWithURL:url];
        [self.scrollView addSubview:imageView];
    }
//    第八个图
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kViewWidth * (URLArray.count + 1), 0, kViewWidth, kScrolleVieweHeight)];
    NSURL *lastImageURL = [NSURL URLWithString:[URLArray firstObject]];
    [lastImageView sd_setImageWithURL:lastImageURL];
    [self.scrollView addSubview:lastImageView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height - 20, kViewWidth, 20)];
    self.pageControl.numberOfPages = URLArray.count;
    [self addSubview:self.pageControl];
    self.scrollView.delegate = self;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentOffset = self.scrollView.contentOffset.x / kViewWidth;
    if (currentOffset == 0) {
        self.scrollView.contentOffset = CGPointMake(kViewWidth * self.number , 0);
    } else if(currentOffset == self.number + 1) {
        self.scrollView.contentOffset = CGPointMake(kViewWidth, 0);
    }
    NSInteger currentOffsetAgain = self.scrollView.contentOffset.x / kViewWidth;
    self.pageControl.currentPage = currentOffsetAgain - 1;
}

- (void)timerAction:(NSTimer *)timer {
    NSInteger currentOffset = self.scrollView.contentOffset.x / kViewWidth;
    if (currentOffset == self.number + 1) {
        self.scrollView.contentOffset = CGPointMake(kViewWidth, 0);
        currentOffset = 1;
    }
    [self.scrollView setContentOffset:CGPointMake(kViewWidth * (currentOffset + 1), 0) animated:YES];
    if (currentOffset == self.number ) {
        self.pageControl.currentPage = 0;
    } else {
        self.pageControl.currentPage = currentOffset;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

@end
