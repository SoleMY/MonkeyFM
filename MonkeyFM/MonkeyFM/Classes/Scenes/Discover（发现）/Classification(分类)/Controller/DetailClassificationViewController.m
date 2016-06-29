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

#define kBaseURL @"http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid="
#define kAppendingURL @"&installid=00034w5l&appid=0&operator=2&playid=85C6753E388745BBADB885EFC5C8076F&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598913&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

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

    // 设置控件
//    [self addDemo];
    // 请求数据
    [self requstData];

    
}

- (void)addDemo
{
    self.menuArray = self.allTitleArray;
    NSLog(@"%@", self.allArray);
    self.tableArray = [NSMutableArray arrayWithCapacity:self.allArray.count];
    for (DetailSegment *model in self.allArray) {
        MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.string = [NSString stringWithFormat:@"%@%@%@", kBaseURL, model.categoryId, kAppendingURL];
//        table.categroyId = model.categoryId;
        NSLog(@" ===== %@, ====== %@", table.title, table.categroyId);
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
    NSLog(@"%@", urlString);
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
//            [self.allTitleArray addObject:segmentModel.categoryName];
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
