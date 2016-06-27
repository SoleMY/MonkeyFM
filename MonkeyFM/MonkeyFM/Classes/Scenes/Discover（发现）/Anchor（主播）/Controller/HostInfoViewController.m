//
//  HostInfoViewController.m
//  MonkeyFM
//
//  Created by 郑淮予 on 16/6/26.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HostInfoViewController.h"
#import <Masonry.h>
#import "UIScrollView+ScalableCover.h"
#import "HeadImage.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+LBBlurredImage.h"
#import "SocialNetworkCell.h"
#import "AlbumCell.h"
#import "SubscribeCell.h"
#import "collectCell.h"
#import "NetWorking.h"
#import "MFM_URL.h"
#import "Host.h"
#import "More.h"
#import "HostTitle.h"
#import "Collection.h"

@interface HostInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *bgTableView;

@property (nonatomic, strong)HeadImage *headImage;

@property (nonatomic, strong)NSMutableArray *issueListArr;

@property (nonatomic, strong)NSMutableArray *subscribeListArr;

@property (nonatomic, strong)NSMutableArray *likedListArr;

@property (nonatomic, strong)NSMutableArray *infoListArr;

@end

@implementation HostInfoViewController

- (NSMutableArray *)issueListArr {
    if (!_issueListArr) {
        _issueListArr = [NSMutableArray array];
    }
    return _issueListArr;
}

- (NSMutableArray *)subscribeListArr {
    if (!_subscribeListArr) {
        _subscribeListArr = [NSMutableArray array];
    }
    return _subscribeListArr;
}

- (NSMutableArray *)likedListArr {
    if (!_likedListArr) {
        _likedListArr = [NSMutableArray array];
    }
    return _likedListArr;
}

- (NSMutableArray *)infoListArr {
    if (!_infoListArr) {
        _infoListArr = [NSMutableArray array];
    }
    return _infoListArr;
}

- (void)loadView {
    self.bgTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.view = self.bgTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemAction)];
    self.bgTableView.delegate = self;
    self.bgTableView.dataSource = self;
    [self.bgTableView registerClass:[HeadImage class] forCellReuseIdentifier:@"headImage"];
    [self.bgTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.bgTableView.tableHeaderView = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [self.bgTableView registerClass:[SocialNetworkCell class] forCellReuseIdentifier:@"netWorkCell"];
    [self.bgTableView registerClass:[AlbumCell class] forCellReuseIdentifier:@"AlbumCell"];
    [self.bgTableView registerClass:[SubscribeCell class] forCellReuseIdentifier:@"SubscribeCell"];
    [self.bgTableView registerClass:[collectCell class] forCellReuseIdentifier:@"collectCell"];
    [self request];
}

- (void)request {
    NetWorking *netWorking = [[NetWorking alloc] init];
    NSString *URLStr = [NSString stringWithFormat:@"%@%@%@", Host_detailed_Base_URL, self.uid, Host_detailed_append_URL];
    [netWorking requestWithURL:URLStr Bolck:^(id array) {
        NSDictionary *resultDic = [array objectForKey:@"result"];
        NSDictionary *infoDic = resultDic[@"info"];
//        头视图图片和简介
        Host *host = [[Host alloc] init];
        [host setValuesForKeysWithDictionary:infoDic];
        [self.infoListArr addObject:host];
//        name、pic
        NSDictionary *issuseDic = resultDic[@"issueList"];
        NSArray *issuseArr = issuseDic[@"dataList"];
//        TA发布的专辑应该返回的item的数量
        for (NSDictionary *dic in issuseArr) {
            More *more = [[More alloc] init];
            [more setValuesForKeysWithDictionary:dic];
            [self.issueListArr addObject:more];
        }
        
//        name/pic
        NSDictionary *subScribeDic = resultDic[@"subscribeList"];
        NSArray *subScribeArr = subScribeDic[@"dataList"];
        for (NSDictionary *dic in subScribeArr) {
            HostTitle *model = [[HostTitle alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.subscribeListArr addObject:model];
        }
        
//        收藏
        NSDictionary *collectionDic = resultDic[@"likedList"];
        NSArray *collectionArr = collectionDic[@"dataList"];
        for (NSDictionary *dic in collectionArr) {
            Collection *collection = [[Collection alloc] init];
            [collection setValuesForKeysWithDictionary:dic];
            [self.likedListArr addObject:collection];
        }
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.bgTableView reloadData];

            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:host.avatar]];
            UIImage * image =  [imageView setImageToBlur:imageView.image blurRadius:21 ];
            [self.bgTableView addScalableCoverWithImage: image smallImageURL:host.avatar];
            
        });
        
        
    }];
}


- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HeadImage *image = [self.bgTableView dequeueReusableCellWithIdentifier:@"headImage" forIndexPath:indexPath];
        Host *host = [self.infoListArr firstObject];
        image.fansNumber.text = [NSString stringWithFormat:@"%ld", (long)host.fansNum];
        image.followNumber.text = [NSString stringWithFormat:@"%ld", (long)host.followedNum];
        return image;
    }else if(indexPath.row == 2){
        SocialNetworkCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"netWorkCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 3) {
        AlbumCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"AlbumCell" forIndexPath:indexPath];
        cell.albumArr = self.issueListArr;
        NSLog(@"%@", self.issueListArr);
        return cell;
    }else if (indexPath.row == 4) {
        SubscribeCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"SubscribeCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 5) {
        collectCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"隋唐帝王史话";
        cell.decLabel.text = @"中国帝王史话";
        cell.dateLabel.text = @"2016-03-21";
        return cell;
    } else {
        UITableViewCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 0;
        Host *host = [self.infoListArr firstObject];
        cell.textLabel.text = host.intro;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 170;
    }else if (indexPath.row == 2){
        return 100;
    } else {
        return 200;
    }
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
