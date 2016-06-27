//
//  DetailClassificationController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetailClassificationController.h"
#import <UIParameter.h>
#import <NinaPagerView.h>
#import "MFM_URL.h"
#import <AFNetworking.h>
#import "DetailSegment.h"
#import "HZSigmentView.h"
@interface DetailClassificationController ()<HZSigmentViewDelegate>
@property (nonatomic, strong) HZSigmentView * sigment;


@property (nonatomic,strong) NSMutableArray *segmentArray;

@property (nonatomic,strong) NSMutableArray *allArray;

@end

@implementation DetailClassificationController

// 懒加载
- (NSMutableArray *)segmentArray
{
    if (!_segmentArray) {
        _segmentArray = [NSMutableArray array];
    }
    return _segmentArray;
}
- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.sigment = [[HZSigmentView alloc] initWithOrgin:CGPointMake(0, 0) andHeight:44];
    self.sigment.delegate = self;
//    self.sigment.titleArry = @[@"核桃",@"苹果", @"我在人民广场", @"吃着炸鸡", @"啊哈哈哈", @"afsdf"];
    self.sigment.titleLineColor = [UIColor grayColor];
    [self.view addSubview:self.sigment];
    
    
    [self requstData];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(backView:)];
}

- (void)backView:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)requstData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:classification_NEWS_Segment parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 请求成功，解析数据
//        NSLog(@"%@", responseObject);
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
//        NSLog(@"===%@", dic);
        NSDictionary *resultDict = dictionary[@"result"];
        
        NSArray *dataListArray = resultDict[@"dataList"];
        
        for (NSDictionary *lastDict in dataListArray) {
            
            DetailSegment *segmentModel = [[DetailSegment alloc] init];
            [segmentModel setValuesForKeysWithDictionary:lastDict];
            [self.segmentArray addObject:segmentModel.categoryName];
            [self.allArray addObject:segmentModel];
        }
        self.sigment.titleArry = _segmentArray;
//        NSArray *vcsArray = @[
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController",
//                              @"NewsViewController"
//                              ];
//        NSArray *colorArray = @[
//                                [UIColor brownColor], /**< 选中的标题颜色 Title SelectColor  **/
//                                [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
//                                [UIColor redColor], /**< 下划线颜色 Underline Color   **/
//                                ];
//        NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithNinaPagerStyle:NinaPagerStyleBottomLine WithTitles:_segmentArray WithVCs:vcsArray WithColorArrays:colorArray];
//        [self.view addSubview:ninaPagerView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
