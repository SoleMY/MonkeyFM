//
//  RadioContentTableViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioContentTableViewCell.h"
#import "Masonry.h"
#import "RadioContentCell.h"
#import "RadioModel.h"



#define kItemSize CGSizeMake((self.bounds.size.width - 60) / 3, (self.bounds.size.width - 60) / 3)


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
    self.backgroundColor = [UIColor whiteColor];
    
    [self.radioContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.top.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(-20);
        make.bottom.equalTo(self).with.offset(-10);
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
        
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
}

#warning 选中跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.pushBlock();
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
