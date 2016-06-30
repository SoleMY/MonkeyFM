//
//  DetailClassificationViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "DetailClassificationViewController.h"
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
#import "DetailSegment.h"



@interface DetailClassificationViewController ()
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *allTitleArray;
@end

@implementation DetailClassificationViewController

- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

- (NSMutableArray *)allTitleArray
{
    if (!_allTitleArray) {
        _allTitleArray = [NSMutableArray array];
    }
    return _allTitleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 请求数据
    [self requstData];
    self.title = @"详情";
}

- (void)addDemo
{
    self.menuArray = self.allTitleArray;
    self.tableArray = [NSMutableArray arrayWithCapacity:self.allArray.count];
    for (DetailSegment *model in self.allArray) {
        MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.string = [NSString stringWithFormat:@"%@%@%@", kBaseURL, model.categoryId, kAppendingURL];
        [self.menuArray addObject:model.categoryName];
        [self.tableArray addObject:table];
    }
    //设置控件位置y
    self.menuframe = CGRectMake(0, 64, ScreenW, 40);
    self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), ScreenW, ScreenH - CGRectGetMaxY(self.menuframe));
    
    //调用父类方法加载控件
    [super viewDidLoad]; //最后执行
}

- (void)requstData
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@", classification_Base_URL, self.classificationModel.categoryId, classification_Appending_URL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        
        NSDictionary *resultDict = dictionary[@"result"];
        
        NSArray *dataListArray = resultDict[@"dataList"];
        
        for (NSDictionary *lastDict in dataListArray) {
            
            DetailSegment *segmentModel = [[DetailSegment alloc] init];
            [segmentModel setValuesForKeysWithDictionary:lastDict];
            [self.allArray addObject:segmentModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addDemo];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
