//
//
//
//  url:http://www.xiongcaichang.com
//  Created by bear on 16/3/31.
//  Copyright © 2016年 bear. All rights reserved.
//



#import "UIScrollView+ScalableCover.h"
#import <objc/runtime.h>

static NSString * const kContentOffset = @"contentOffset";
static NSString * const kScalableCover = @"scalableCover";

@implementation UIScrollView (ScalableCover)

- (void)setScalableCover:(ScalableCover *)scalableCover
{
    [self willChangeValueForKey:kScalableCover];
    objc_setAssociatedObject(self, @selector(scalableCover),
                             scalableCover,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kScalableCover];
}

- (ScalableCover *)scalableCover
{
    return objc_getAssociatedObject(self, &kScalableCover);
}

- (void)addScalableCoverWithImage:(UIImage *)image smallImageURL:(NSString *)imageviewURL
{
    ScalableCover *cover = [[ScalableCover alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, MaxHeight)];
#pragma mark 改动
    UIImageView *whiteImage = [[UIImageView alloc] init];
    whiteImage.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteImage];
    whiteImage.frame = CGRectMake(cover.frame.size.width / 2 - 50, 50, 105, 105);
    whiteImage.layer.cornerRadius = 52;
    whiteImage.layer.masksToBounds = YES;
    
    NSURL *url = [NSURL URLWithString:imageviewURL];
    UIImageView *imageView1 = [[UIImageView alloc] init];
    [imageView1 sd_setImageWithURL:url];
    cover.backgroundColor = [UIColor clearColor];
    cover.image = image;
    cover.scrollView = self;
    imageView1.frame = CGRectMake(cover.frame.size.width/2 - 48, 52, 100, 100);
    imageView1.layer.cornerRadius = 50;
    imageView1.layer.masksToBounds = YES;
    [self addSubview:imageView1];
    
    [self addSubview:cover];
    [self sendSubviewToBack:cover];
    
    self.scalableCover = cover;
}

- (void)addScalableCoverWithImage:(UIImage *)image {
    ScalableCover *cover = [[ScalableCover alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, MaxHeight)];
   
    cover.backgroundColor = [UIColor clearColor];
    cover.image = image;
    cover.scrollView = self;
    [self addSubview:cover];
    [self sendSubviewToBack:cover];
    
    self.scalableCover = cover;
}

- (void)removeScalableCover
{
    [self.scalableCover removeFromSuperview];
    self.scalableCover = nil;
}


@end




@interface ScalableCover (){

}



@end


@implementation ScalableCover

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;

    }

    return self;
}


- (void)setScrollView:(UIScrollView *)scrollView
{

    [_scrollView removeObserver:scrollView forKeyPath:kContentOffset];
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}




- (void)removeFromSuperview
{


    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];

    NSLog(@"😄----removeed");
    [super removeFromSuperview];
}




- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.scrollView.contentOffset.y < 0) {
        CGFloat offset = -self.scrollView.contentOffset.y;
        
        self.frame = CGRectMake(-offset, -offset, _scrollView.bounds.size.width + offset * 2, MaxHeight + offset);
    } else {
        self.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, MaxHeight);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsLayout];
}


@end
