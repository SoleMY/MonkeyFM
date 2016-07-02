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

@interface RadioDisPlayDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
//@property (nonatomic, strong) UICollectionView *myCollectionView;

@end

@implementation RadioDisPlayDetailViewController

static NSString * const identifier_displayCell = @"identifier_displayCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.myCollectionView.backgroundColor = kNavigationBarTintColor;
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"RadioDisPlayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier_displayCell];
    self.myCollectionView.clipsToBounds = YES;
    self.myCollectionView.collectionViewLayout = [[RFLayout alloc] init];
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    
//     初始化collectionView
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:@"RadioDisPlayCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier_displayCell];
    RadioDisPlayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier_displayCell forIndexPath:indexPath];
    return cell;
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
