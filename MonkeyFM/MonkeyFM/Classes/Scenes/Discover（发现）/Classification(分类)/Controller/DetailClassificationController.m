//
//  DetailClassificationController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetailClassificationController.h"
#import "SegmentView.h"
@interface DetailClassificationController ()<TouchLabelDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SegmentView *segmentView;

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation DetailClassificationController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50)];
    self.segmentView.titleArray = @[@"综合",@"深度评论",@"新闻脱口秀",@"军事",@"财经", @"科技", @"体育明星"];
    [self.segmentView.scrollLine setBackgroundColor:[UIColor greenColor]];
    self.segmentView.titleSelectedColor = [UIColor brownColor];
    
    self.segmentView.touchDelegate = self;
    
    [self.view addSubview:self.segmentView];
#pragma mark - ..
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 114, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 114)];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.segmentView.titleArray.count, 0);
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.delegate = self;
}


- (void)touchLabelWithIndex:(NSInteger)index{
    NSLog(@"我是第%ld个label",index);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * index, 0);
}


// 已经结束滚动的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"滚完了");
    // 获取当前显示的位置
    CGFloat x = self.scrollView.contentOffset.x;
    NSInteger index = x / self.view.frame.size.width;
    [self.segmentView selectLabelWithIndex:index];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
