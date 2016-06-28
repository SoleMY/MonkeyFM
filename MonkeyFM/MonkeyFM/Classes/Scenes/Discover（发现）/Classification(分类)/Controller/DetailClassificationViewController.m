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
@end

@implementation DetailClassificationViewController

- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonClick)];
    
    // 请求数据
    [self requstData];
    
    self.menuArray = [NSMutableArray array];
    
}

//- (void)backBarButtonClick {
//    [self.navigationController popViewControllerAnimated:YES];
//}

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
                        [self.menuArray addObject:segmentModel.categoryName];
                        [self.allArray addObject:segmentModel];
        }
       
        
               
        self.tableArray = [NSMutableArray arrayWithCapacity:self.menuArray.count];
        for (NSString *title in self.menuArray) {
            MryPageTable *table = [[MryPageTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            table.title = title;
            [self.tableArray addObject:table];
        }
        
#pragma mark - demo
        //设置控件位置
        self.menuframe = CGRectMake(0, 64, ScreenW, 40);
        self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), ScreenW, ScreenH - CGRectGetMaxY(self.menuframe));
        
        //调用父类方法加载控件
        [super viewDidLoad]; //最后执行
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
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
