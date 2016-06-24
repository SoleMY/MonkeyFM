//
//  AnchorViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AnchorViewController.h"
#import "TheHostShow.h"
#import "Request.h"
#import "MFM_URL.h"
#import "CollectionView.h"
#import "CollectionViewCell.h"

#define kHeadViewHeight 200
#define kHeadViewY 40
@interface AnchorViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *collectionViewLayout;
@property (nonatomic, strong)CollectionView *collection;
@end

@implementation AnchorViewController

- (void)loadView {
    self.collection = [[CollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.collection;
}

//定义全局的重用标识符
static NSString *const identifier_cell = @"identifier_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //    设置代理
    self.collection.collectionView.dataSource = self;
    self.collection.collectionView.delegate = self;
    
    //   第一步： 注册collectionViewCell
    [self.collection.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:identifier_cell];
    //    注册头视图
    [self.collection.collectionView registerClass:[HeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    //    注册尾视图
    [self.collection.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
}

#pragma mark UICollectionViewDataSource Method----

//设置多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

//设置每一个分区里有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

//返回每一个item的cell对象
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    第二步：重用cell
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_cell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
    
}
//
////返回头视图和尾视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    //    判断是头视图和还是尾视图
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        HeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
//        switch (indexPath.section) {
//            case 0:
//                headerView.headeLabel.text = @"haha";
//                break;
//            case 1:
//                headerView.headeLabel.text = @"哈哈";
//                break;
//            case 2:
//                headerView.headeLabel.text = @"呵呵";
//                break;
//            default:
//                break;
//        }
//        
//        
//        return headerView;
//    }
//    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
//    footerView.backgroundColor = [UIColor greenColor];
//    return footerView;
//}
//
////点击item
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    [self.navigationController pushViewController:secondVC animated:YES];
//}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
