//
//  RadioPlayerListViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioPlayerListViewController.h"
#import "RadioStyleListTableView.h"
#import "RadioStyleSegmentedModel.h"
#import "RadioStyleModel.h"
#import "ChooseAreaViewController.h"
#import "BaseNavigationViewController.h"
#import "RadioDisPlayDetailViewController.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSUInteger, SegmentedStyle) {
    Type,
    Content,
};
@interface RadioPlayerListViewController ()

@property (nonatomic, strong) UISegmentedControl *navigationSegmented;

@property (nonatomic, assign) SegmentedStyle segmentedStyle;

@property (nonatomic, strong) NSMutableArray *allSegmentedInfoArray;

@property (nonatomic, assign) NSInteger area;

@end

@implementation RadioPlayerListViewController

- (NSMutableArray *)allSegmentedInfoArray
{
    if (!_allSegmentedInfoArray) {
        _allSegmentedInfoArray = [NSMutableArray array];
    }
    return _allSegmentedInfoArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = NO;
    
    [self setSegmented];
    [self setSmallSegmentedControl];
    // 请求数据
    [self requestData];
    

}

- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    
    
    [[AFHTTPSessionManager manager] GET:RADIO_CLASSIFY_SEGMENTED_URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject[@"result"];
        if (dict != nil) {
            NSArray *listArray = [dict objectForKey:@"dataList"];
            for (NSDictionary *dic in listArray) {
                RadioStyleSegmentedModel *model = [[RadioStyleSegmentedModel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [weakSelf.allSegmentedInfoArray addObject:model];
            }
            // 数据解析成功，返回主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf reloadDataAndShowUI];
            });
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)reloadDataAndShowUI
{
    [self setSegmented];
    [self setSmallSegmentedControl];
    [super setMenuAndScrollTableView];

    
}

- (void)setSmallSegmentedControl
{
    // 在改变显示的视图之前，先移除数组内数据和视图上所有的子视图
    [self.menuArray removeAllObjects];
    [self.tableArray removeAllObjects];
    [self removeAllSubViews];
    
    if (_segmentedStyle == Type) {
        //设置数据源
        RadioStyleSegmentedModel *model = [self.allSegmentedInfoArray firstObject];
        [self setSegmentedAndTableViewArray:model];
    } else if (_segmentedStyle == Content) {
        RadioStyleSegmentedModel *model = [self.allSegmentedInfoArray lastObject];
        [self setSegmentedAndTableViewArray:model];
    }
    //设置控件位置
    self.menuframe = CGRectMake(0, 64, ScreenW, 20);
    self.tableframe = CGRectMake(0, CGRectGetMaxY(self.menuframe), ScreenW, ScreenH - CGRectGetMaxY(self.menuframe));
    //调用父类方法加载控件
    [super viewDidLoad]; //最后执行
    
}
- (void)setSegmentedAndTableViewArray:(RadioStyleSegmentedModel *)model
{
    
    __weak typeof(self) weakSelf = self;
    NSArray *itemsArr = model.dataList;
    NSMutableArray *smallItemsArr = [NSMutableArray array];
    for (NSDictionary *dic in itemsArr) {
        [smallItemsArr addObject:dic[@"name"]];
    }
    //设置数据源
    if (smallItemsArr.count == 4) {
        [smallItemsArr removeLastObject];
    }
    self.area = 1;
    self.menuArray = [NSMutableArray arrayWithArray:smallItemsArr];
    self.tableArray = [NSMutableArray arrayWithCapacity:self.menuArray.count];
    for (int i = 0; i < self.menuArray.count; i++) {
        RadioStyleListTableView *table = [[RadioStyleListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        if (self.selectedSegmentIndex == 0) {
            NSString *emptyURL = RADIO_CLASSIFY_LIST_URL(RADIO_CLASSIFY_BASE_URL, (long)(i + 1), self.area, (self.selectedSegmentIndex + 1), RADIO_CLASSIFY_TAIL_URL);
            table.emptyURL = emptyURL;
            table.title = self.menuArray[i];
            ChooseAreaViewController *chooseVC = [[ChooseAreaViewController alloc] init];
            chooseVC.block = ^(NSInteger area, NSString *name) {
                table.area = area;
                table.areaName = name;
            };
            table.chooseBlock = ^() {
                [weakSelf.navigationController pushViewController:chooseVC animated:YES];
            };
        } else  {
            NSString *emptyURL = RADIO_CLASSIFY_LIST_URL(RADIO_CLASSIFY_BASE_URL, (long)(i+ 6), (long)1, (self.selectedSegmentIndex + 1), RADIO_CLASSIFY_TAIL_URL);
            table.emptyURL = emptyURL;
        }
        RadioDisPlayDetailViewController *displayVC = [[RadioDisPlayDetailViewController alloc] init];
        table.displayBlock = ^(NSInteger ID, NSInteger classifyid, NSInteger area, NSIndexPath *scroll) {
            displayVC.ID = ID;
            weakSelf.sendBlock = ^(NSInteger index) {
                if (_segmentedStyle == 0) {
                    index++;
                } else {
                    index = index + 6;
                }
                _selectID = index;
                
            };
            displayVC.classifyid = weakSelf.selectID;
            displayVC.area = area;
            displayVC.type = weakSelf.selectedSegmentIndex + 1;
            displayVC.scrollIndexPath = scroll;
            [weakSelf.navigationController pushViewController:displayVC animated:YES];
        };
        table.sectionHeaderHeight = 0;
        table.sectionFooterHeight = 0;
        [self.tableArray addObject:table];
    }
}



- (void)removeAllSubViews
{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
}

- (void)setSegmented
{
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (RadioStyleSegmentedModel *model in self.allSegmentedInfoArray) {
        [itemsArray addObject:model.typeName];
    }
    self.navigationSegmented = [[UISegmentedControl alloc] initWithItems:itemsArray];
    // 设置属性
    self.navigationSegmented.backgroundColor = [UIColor whiteColor];
    self.navigationSegmented.frame = CGRectMake(0, 0, 200, 30);
    
    self.navigationSegmented.layer.cornerRadius = 5;
    self.navigationSegmented.layer.masksToBounds = YES;
    // 指定被选中的分段
    self.navigationSegmented.selectedSegmentIndex = self.selectedSegmentIndex;
    if (self.selectedSegmentIndex == 0) {
        self.segmentedStyle = Type;
        [self setSmallSegmentedControl];
    } else if (self.selectedSegmentIndex == 1) {
        self.segmentedStyle = Content;
        [self setSmallSegmentedControl];
    }
    self.navigationSegmented.tintColor = kNavigationBarTintColor;
    [self.navigationSegmented addTarget:self  action:@selector(indexDidChangeForSegmentedControl:)
                       forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:self.navigationSegmented];
    
}

- (void)indexDidChangeForSegmentedControl:(id)sender
{
    NSInteger index = self.navigationSegmented.selectedSegmentIndex;
    if (index == 0) {
        self.segmentedStyle = Type;
        self.selectedSegmentIndex = 0;
        _selectID = 1;
        [self setSmallSegmentedControl];
    } else if (index == 1) {
        self.segmentedStyle = Content;
        self.selectedSegmentIndex = 1;
        _selectID = 6;
        [self setSmallSegmentedControl];
        
    }

}


@end
