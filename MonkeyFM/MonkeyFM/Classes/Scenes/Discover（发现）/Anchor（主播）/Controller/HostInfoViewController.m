//
//  HostInfoViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/26.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "HostInfoViewController.h"
#import <Masonry.h>
#import "UIScrollView+ScalableCover.h"
#import "HeadImage.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+LBBlurredImage.h"
@interface HostInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *bgTableView;

@property (nonatomic, strong)HeadImage *headImage;

@end

@implementation HostInfoViewController

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
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://image.kaolafm.net/mz/images/201601/124b6f11-c4b1-400d-8083-efb3bfce38f5/default.jpg"]];
    UIImage * image =  [imageView setImageToBlur:imageView.image blurRadius:21 ];
      [self.bgTableView addScalableCoverWithImage: image smallImageURL:@"http://image.kaolafm.net/mz/images/201601/124b6f11-c4b1-400d-8083-efb3bfce38f5/default.jpg"];
}

- (void)leftBarButtonItemAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HeadImage *image = [self.bgTableView dequeueReusableCellWithIdentifier:@"headImage" forIndexPath:indexPath];
        
        return image;
    }else {
        UITableViewCell *cell = [self.bgTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text = @"123";
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 170;
    }else {
        return 30;
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
