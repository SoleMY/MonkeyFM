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
#import "DetailClassificationViewController.h"
#import "BaseNavigationViewController.h"
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
    
#warning 夜间模式改动
    [self.view NightWithType:UIViewColorTypeNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requstData];
#warning 请求完数据 加载视图
    self.myView.collectionView.delegate = self;
    self.myView.collectionView.dataSource = self;
#warning 夜间模式改动
    [self.myView.collectionView NightWithType:UIViewColorTypeNormal];
    // 第一步：注册cell
    [self.myView.collectionView registerClass:[ClassificationCell class] forCellWithReuseIdentifier:identifile_cell];
    __weak typeof(self)weakSelf = self;
    self.title = @"分类";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
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
#warning 夜间模式改动
    [cell NightWithType:UIViewColorTypeNormal];

//    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.backgroundPic]];
   
     cell.photoImage.image = [UIImage imageNamed:model.title];
    
    return cell;
}

// 点击item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassificationModel *model = self.allArray[indexPath.row];
    
    DetailClassificationViewController *detailVC = [DetailClassificationViewController new];
    
    detailVC.classificationModel = model;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)requstData
{


    NSString *urlString = classification_Url;
    
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
