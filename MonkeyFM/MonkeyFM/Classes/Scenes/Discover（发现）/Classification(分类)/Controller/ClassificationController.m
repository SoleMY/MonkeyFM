//
//  ClassificationController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/23.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "ClassificationController.h"
#import "ClassificationView.h"
#import "ClassificationCell.h"
#import "ClassificationModel.h"
#import <UIImageView+WebCache.h>
@interface ClassificationController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)ClassificationView *myView;

@property (nonatomic, strong)NSMutableArray *allArray;
@end

@implementation ClassificationController

// 懒加载
- (NSMutableArray *)allArray
{
    if (!_allArray) {
        _allArray = [NSMutableArray array];
    }
    return _allArray;
}

// 定义全局的重用标识符

static  NSString *const identifile_cell = @"identifile_cell";


- (void)loadView
{
     self.myView = [[ClassificationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.myView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requstData];
#warning 请求完数据 加载视图
    self.myView.collectionView.delegate = self;
    self.myView.collectionView.dataSource = self;
    // 第一步：注册cell
    [self.myView.collectionView registerClass:[ClassificationCell class] forCellWithReuseIdentifier:identifile_cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource Method---

// 设置多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 设置每个分区有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allArray.count;
}

// 返回每一个item的cell对象

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 第二步：重用cell
    ClassificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifile_cell forIndexPath:indexPath];

    ClassificationModel *model = self.allArray[indexPath.row];
    cell.label.text = model.title;
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.icon]];

    return cell;
}

//// 点击item
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    SecondController *second = [SecondController new];
//    
//    [self.navigationController pushViewController:second animated:YES];
//}

- (void)requstData
{


    NSString *urlString = @"http://api.kaolafm.com/api/v4/category/listofall?pagenum=1&pagesize=10&installid=00034w5l&appid=0&operator=2&playid=&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337465&channel=appstore&action=14&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=0&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=&timestamp=1466571728&sessionid=3CA1D5ABBD054C81B1CD156659740F36&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029170&page=200022&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    __weak typeof(self)mySelf = self;
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *dict = dictionary[@"result"];
            NSArray *Array = dict[@"dataList"];
            NSDictionary *dic = Array[0];
            NSArray *dataListArray = dic[@"dataList"];
            for (NSDictionary *modelDic in dataListArray) {
                ClassificationModel *model = [ClassificationModel new];
                [model setValuesForKeysWithDictionary:modelDic];
                [self.allArray addObject:model];
                
            }
//            NSLog(@"%@", self.allArray);
            dispatch_async(dispatch_get_main_queue(), ^{
                [mySelf.myView.collectionView reloadData];
            });
        } else {
            NSLog(@"error = %@", error);
        }
       
    }];
    
    [task resume];
    

    
}



@end
