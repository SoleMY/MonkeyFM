//
//  RadioDisPlayDetailViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioDisPlayDetailViewController.h"
#import "RFLayout.h"
#import "RadioDisPlayCollectionViewCell.h"
#import "RadioDisplayModel.h"
#import "RadioDisplayPlayModel.h"
#import "UIImageView+LBBlurredImage.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface RadioDisPlayDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
//@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray *allDisplayListInfoArray;
@property (nonatomic, strong) NSMutableArray *allDisplayPlayInfoArray;

@end

@implementation RadioDisPlayDetailViewController

static NSString * const identifier_displayCell = @"identifier_displayCell";

- (NSMutableArray *)allDisplayListInfoArray
{
    if (!_allDisplayListInfoArray) {
        _allDisplayListInfoArray = [NSMutableArray array];
    }
    return _allDisplayListInfoArray;
}

- (NSMutableArray *)allDisplayPlayInfoArray
{
    if (!_allDisplayPlayInfoArray) {
        _allDisplayPlayInfoArray = [NSMutableArray array];
    }
    return _allDisplayPlayInfoArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.backBtn setImage:[[UIImage imageNamed:@"btn_anchor_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [self.allDisplayListInfoArray removeAllObjects];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myCollectionView.backgroundColor = kNavigationBarTintColor;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"RadioDisPlayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier_displayCell];
    self.myCollectionView.clipsToBounds = YES;
    self.myCollectionView.collectionViewLayout = [[RFLayout alloc] init];
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    self.myCollectionView.showsHorizontalScrollIndicator = NO;
    [self requestData];
    
}

- (void)setArea:(NSInteger)area
{
    if (_area != area) {
        _area = area;
    }
    [self requestData];
}

- (void)requestData
{
    __weak typeof(self) weakSelf = self;
    NSString *emptyURL = [NSString string];
    if (_type == 1) {
        if (_classifyid == 2) {
            emptyURL = RADIO_DISPLAY_AREA_EMPTY_URL(RADIO_DISPLAY_AREA_BASE_URL, _area, RADIO_DISPLAY_AREA_TAIL_URL);
        } else {
            emptyURL = RADIO_DISPLAY_LIST_EMPTY_URL(RADIO_DISPLAY_LIST_BASE_URL, _ID, _type, _classifyid, RADIO_DISPLAY_LIST_TAIL_URL);
        }
    } else if (_type == 2) {
        emptyURL = RADIO_DISPLAY_CONTENT_EMPTY_URL(RADIO_DISPLAY_CONTENT_BASE_URL, _ID, _classifyid, RADIO_DISPLAY_CONTENT_TAIL_URL);
    }
    
    [[AFHTTPSessionManager manager] GET:emptyURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = responseObject[@"result"];
        NSArray *infoArray = dic[@"dataList"];
        for (NSDictionary *dic in infoArray) {
            RadioDisplayModel *model = [[RadioDisplayModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [weakSelf.allDisplayListInfoArray addObject:model];
            }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadUI];
        });

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)requestPlayDataWithId:(NSInteger)Id
{
    __weak typeof(self) weakSelf = self;
    [self.allDisplayPlayInfoArray removeAllObjects];
    [[AFHTTPSessionManager manager] GET:RADIO_DISPLAY_PLAY_EMPTY_URL(RADIO_DISPLAY_PLAY_BASE_URL, Id, RADIO_DISPLAY_PLAY_TAIL_URL) parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dic = responseObject[@"result"];
            RadioDisplayPlayModel *model = [[RadioDisplayPlayModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.allDisplayPlayInfoArray addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.myCollectionView reloadData];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)reloadUI
{
    
    [self.myCollectionView reloadData];
    [self.myCollectionView scrollToItemAtIndexPath:_scrollIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    

}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.allDisplayListInfoArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"RadioDisPlayCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier_displayCell];
    RadioDisPlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_displayCell forIndexPath:indexPath];
    RadioDisplayModel *model = self.allDisplayListInfoArray[indexPath.row];
    [cell bindModel:model];
    if (self.allDisplayPlayInfoArray.count == 1) {
        [cell bindPlayModel:self.allDisplayPlayInfoArray[0]];
//        [cell.timer setFireDate:[NSDate distantPast]];
    }
    if (indexPath.row == _scrollIndexPath.row) {
        [self setBlurBackImageView];
    }
    return cell;
}

- (void)setBlurBackImageView
{
    NSInteger offset;
    // 根据屏幕判断偏移量，不同尺寸偏移量占比不同
    
    if (kScreenWidth == 320) {
        offset = kScreenWidth * 0.875;
    } else {
        offset = kScreenWidth * 0.89;
    }
    NSInteger index = self.myCollectionView.contentOffset.x / offset;
    RadioDisplayModel *model = self.allDisplayListInfoArray[index];
    [self requestPlayDataWithId:[model.ID integerValue]];
    [UIView animateWithDuration:1 animations:^{
        [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        self.titleNameLabel.text = model.name;
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        UIImage * image = [self.backImageView setImageToBlur:imageView.image blurRadius:21];
        self.backImageView.image = image;
    }];
    

}
// 当滚动彻底停止时触发这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setBlurBackImageView];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
