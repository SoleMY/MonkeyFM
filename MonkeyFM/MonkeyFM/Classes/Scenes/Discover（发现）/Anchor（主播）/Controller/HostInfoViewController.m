//
//  HostInfoViewController.m
//  MonkeyFM
//
//  Created by 郑淮予 on 16/6/26.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HostInfoViewController.h"
#import "UIScrollView+ScalableCover.h"
#import "HeadImage.h"
#import "UIImageView+LBBlurredImage.h"
#import "SocialNetworkCell.h"
#import "AlbumCell.h"
#import "SubscribeCell.h"
#import "collectCell.h"
#import "NetWorking.h"
#import "Host.h"
#import "More.h"
#import "HostTitle.h"
#import "Collection.h"
#import "SmallTools.h"
#import "MoreViewController.h"
#import "MJRefresh.h"
#import "PlayListViewController.h"

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
    self.bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self request];
    [self.bgTableView reloadData];
    self.title = @"主播详情";
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18], NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (void)request {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.bgTableView animated:YES];
    HUD.backgroundColor = [UIColor whiteColor];
    
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
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:host.avatar]];
            UIImage * image = [imageView setImageToBlur:imageView.image blurRadius:21 ];
            [self.bgTableView addScalableCoverWithImage: image smallImageURL:host.avatar];
            [self.bgTableView reloadData];
            [MBProgressHUD hideHUDForView:self.bgTableView animated:YES];
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
        image.nameLabel.text= host.nickName;
        image.fansNumber.text = [NSString stringWithFormat:@"%ld", (long)host.fansNum];
        image.followNumber.text = [NSString stringWithFormat:@"%ld", (long)host.followedNum];
        image.selectionStyle = UITableViewCellSelectionStyleNone;
        return image;
    }else if(indexPath.row == 2){
        SocialNetworkCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"netWorkCell" forIndexPath:indexPath];
        return cell;
    }else if (indexPath.row == 3) {
        AlbumCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"AlbumCell" forIndexPath:indexPath];
        cell.albumArr = self.issueListArr;
        cell.block = ^(){
            MoreViewController *moreVC = [[MoreViewController alloc] init];
            moreVC.appendStr = @"issue/list";
            moreVC.uid = self.uid;
            [self.navigationController pushViewController:moreVC animated:YES];
        };
        cell.albumBlock = ^(){
            PlayListViewController *playList = [[PlayListViewController alloc] init];
            
            [self.navigationController pushViewController:playList animated:YES];
        };
        return cell;
    }else if (indexPath.row == 4) {
        SubscribeCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"SubscribeCell" forIndexPath:indexPath];
        cell.collectionArr = self.subscribeListArr;
        cell.block =^(){
            MoreViewController *moreVC = [[MoreViewController alloc] init];
            moreVC.appendStr = @"subscribe";
            moreVC.uid = self.uid;
            [self.navigationController pushViewController:moreVC animated:YES];
        };
//        cell
        cell.subsribeblock = ^(){
            PlayListViewController *playList = [[PlayListViewController alloc] init];
            [self.navigationController pushViewController:playList animated:YES];
        };
        return cell;
    }else if (indexPath.row == 5) {
        collectCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];
        cell.collectArr = self.likedListArr;
        cell.block =^(){
            MoreViewController *moreVC = [[MoreViewController alloc] init];
            moreVC.appendStr = @"like";
            moreVC.uid = self.uid;
            [self.navigationController pushViewController:moreVC animated:YES];
        };
        cell.collectBlock = ^(){
//            PlayListViewController *playList = [[PlayListViewController alloc] init];
//            [self.navigationController pushViewController:playList animated:YES];
        };
        return cell;
    } else {
        UITableViewCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [UIColor grayColor];
        Host *host = [self.infoListArr firstObject];
        cell.textLabel.text = host.intro;
      self.height = [SmallTools textHeightWithText:cell.textLabel.text font:[UIFont systemFontOfSize:13]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.infoListArr.count == 0) {
            return 0;
        }else {
        return 150;
        }
    }else if (indexPath.row == 2){
            return 0;
    
    }else if (indexPath.row == 3){
        if (self.issueListArr.count == 0) {
            return 0;
        }else {
        return 150;
        }
    } else if (indexPath.row == 4) {
        if (self.subscribeListArr.count == 0) {
            return 0;
        }else {
            return 150;
        }
    }else if (indexPath.row == 5) {
        if (self.likedListArr.count == 0) {
            return 0;
        }else {
            return 250;
        }
    }else {
        return self.height + 10;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
