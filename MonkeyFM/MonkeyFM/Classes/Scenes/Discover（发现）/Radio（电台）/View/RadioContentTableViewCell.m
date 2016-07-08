//
//  RadioContentTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioContentTableViewCell.h"
#import "RadioContentCell.h"
#import "RadioModel.h"



#define kItemSize CGSizeMake(([UIScreen mainScreen].bounds.size.width - 60) / 4, ([UIScreen mainScreen].bounds.size.width - 60) / 4)


@implementation RadioContentTableViewCell
static NSString * const identifier_contentCell = @"identifier_contentCell";

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //初始化按钮集合视图
        [self createRadioHeaderView];
    }
    return self;
}

//创建collectionView
-(void)createRadioHeaderView
{
    
    __weak typeof(self)weakSelf = self;
    // 创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = kItemSize;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.headerReferenceSize = CGSizeMake(0, 10);
//    flowLayout.footerReferenceSize = CGSizeMake(0, 10);

    
    // 初始化collectionView
    self.radioContentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.radioContentView.delegate = self;
    self.radioContentView.dataSource = self;
    
    // 取消水平滚动条,关闭滑动效果
    self.radioContentView.scrollEnabled = NO;
    self.radioContentView.showsVerticalScrollIndicator = NO;
    self.radioContentView.bounces = NO;
    [self.contentView addSubview:self.radioContentView];
//    self.backgroundColor = [UIColor whiteColor];
    
    [self NightWithType:UIViewColorTypeNormal];
    [self.radioContentView NightWithType:UIViewColorTypeNormal];
    [self.radioContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf).with.offset(-20);
        make.bottom.equalTo(weakSelf);
    }];
    [self.radioContentView registerClass:[RadioContentCell class] forCellWithReuseIdentifier:identifier_contentCell];
        [self.radioContentView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allInfoDataArray.count > 0) {
    
        RadioContentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_contentCell forIndexPath:indexPath];
        RadioModel *model = [[RadioModel alloc] init];
        model = self.allInfoDataArray[1];
        [cell bindModel:model indexPath:indexPath];
        [cell NightWithType:UIViewColorTypeNormal];
//        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioModel *model = [[RadioModel alloc] init];
    model = self.allInfoDataArray[1];
    NSDictionary *dic = [model.dataList firstObject];
    NSArray *nameArray = [dic objectForKey:@"dataList"];
    NSInteger selectID = [[nameArray[indexPath.row] objectForKey:@"id"] integerValue];
    self.pushBlock(selectID);
//    switch (indexPath.item) {
//        case 0:
//        {
//            self.radioCommonBlock(210000, 2, @"本地台");
//        }
//            break;
//        case 1:
//        {
//            self.radioCommonBlock(0, 1, @"国家台");
//        }
//            break;
//        case 2:
//        {
//            self.provinceRadioBlock(2, @"省市台");
//        }
//            break;
//        case 3:
//        {
//            self.radioCommonBlock(0, 3, @"网络台");
//        }
//            break;
//            
//        default:
//            break;
//    }
}

- (void)setAllInfoDataArray:(NSMutableArray *)allInfoDataArray
{
    if (_allInfoDataArray != allInfoDataArray)
    {
        _allInfoDataArray = allInfoDataArray;
    }
    [self.radioContentView reloadData];

}


@end
