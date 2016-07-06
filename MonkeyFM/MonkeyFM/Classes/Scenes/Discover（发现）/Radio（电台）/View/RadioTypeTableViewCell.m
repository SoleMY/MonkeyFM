//
//  RadioTypeTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioTypeTableViewCell.h"
#import "RadioTypeCell.h"
#import "RadioModel.h"
#import "RadioPlayerListViewController.h"


#define kItemSize CGSizeMake(([UIScreen mainScreen].bounds.size.width) / 4, [UIScreen mainScreen].bounds.size.width / 8)

@implementation RadioTypeTableViewCell

static NSString * const identifier_typeCell = @"identifier_typeCell";

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
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //    flowLayout.headerReferenceSize = CGSizeMake(0, 10);
    //    flowLayout.footerReferenceSize = CGSizeMake(0, 10);

    // 初始化collectionView
    self.radioTypeView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    self.radioTypeView.delegate = self;
    self.radioTypeView.dataSource = self;
    
    // 取消水平滚动条,关闭滑动效果
    self.radioTypeView.scrollEnabled = NO;
    self.radioTypeView.showsVerticalScrollIndicator = NO;
    self.radioTypeView.bounces = NO;
    [self.contentView addSubview:self.radioTypeView];
//    self.backgroundColor = [UIColor whiteColor];
#warning 夜间模式改动
    [self.radioTypeView NightWithType:UIViewColorTypeNormal];
    
    [self.radioTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(0);
        make.top.equalTo(weakSelf).with.offset(5);
        make.right.equalTo(weakSelf).with.offset(0);
        make.bottom.equalTo(weakSelf).with.offset(-5);
    }];
    [self.radioTypeView registerClass:[RadioTypeCell class] forCellWithReuseIdentifier:identifier_typeCell];
    [self.radioTypeView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 15;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.allInfoDataArray.count > 0) {
        
        RadioTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_typeCell forIndexPath:indexPath];
        RadioModel *model = [[RadioModel alloc] init];
        model = self.allInfoDataArray[1];
        [cell bindModel:model indexPath:indexPath];
#warning 夜间模式改动
        [cell NightWithType:UIViewColorTypeNormal];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
}

#warning 选中跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RadioModel *model = [[RadioModel alloc] init];
    model = self.allInfoDataArray[1];
    NSDictionary *dic = [model.dataList lastObject];
    NSArray *nameArray = [dic objectForKey:@"dataList"];
    NSInteger selectID = [[nameArray[indexPath.row] objectForKey:@"id"] integerValue];
    self.pushBlock(selectID);
        
}

- (void)setAllInfoDataArray:(NSMutableArray *)allInfoDataArray
{
    if (_allInfoDataArray != allInfoDataArray)
    {
        _allInfoDataArray = allInfoDataArray;
    }
    [self.radioTypeView reloadData];
    
}


@end
