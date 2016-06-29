//
//  MainTableView.m
//  MryNewsFrameWork
//
//  Created by mryun11 on 16/6/7.
//  Copyright © 2016年 mryun11. All rights reserved.
//

#import "MryPageTable.h"
#import "NewsCell.h"

//#define kBaseURL @"http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid="


//#define kAppendingURL @"&installid=00034w5l&appid=0&operator=2&playid=85C6753E388745BBADB885EFC5C8076F&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598913&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689"

@interface MryPageTable ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *newsAllArray;


@end

@implementation MryPageTable

- (NSMutableArray *)newsAllArray
{
    if (!_newsAllArray) {
        _newsAllArray = [NSMutableArray array];
    }
    return _newsAllArray;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)setString:(NSString *)string
{
    if (_string != string) {
        _string = string;
    }
    [self requstTableViewData];
}


- (void)requstTableViewData
{
    

    
//    NSLog(@"%@", string);
//    if (!self.segmentModel) {
//        self.string = @"http://api.kaolafm.com/api/v4/resource/search?pagesize=10&rtype=20000&sorttype=HOT_RANK_DESC&pagenum=1&cid=1003&installid=00034w5l&appid=0&operator=2&playid=85C6753E388745BBADB885EFC5C8076F&suppermode=0&devicetype=1&devicename=iPhone%206&lon=116.337453&channel=appstore&action=2060&resolution=750*1334&version=4.8.1&udid=f2f2d9eed2fb9ba3702e22fef2c25836&usertype=1&sign=0a53d25f552ae99314f7617ae507be7f&mac=020000000000&uid=2950963&timestamp=1466598913&sessionid=8D99FABB8D0143E98446C34BC9D24688&idfv=EE9AD43F-BE4B-46D9-93EF-618ADCF8F3FC&network=1&timezone=28800&osversion=9.3.2&lat=40.029254&page=200009&token=tokene9b05f44360811c43e95983b2d5c47a2&producer=apple&screensize=375*667&idfa=93C34B9A-7617-440C-A463-B4D59B6B3689";
//    }
    

//        self.string = [NSString stringWithFormat:@"%@%@%@", kBaseURL, self.categroyId, kAppendingURL];

//    NSLog(@"categroyId = categroyId =  categroyId =%@", self.categroyId);
    
        NSLog(@"self.string === == == %@", self.string);

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:self.string parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict = dictionary[@"result"];
        
        NSArray *dataListArray = dict[@"dataList"];
        
        for (NSDictionary *modelDic in dataListArray) {
            NewsAllModel *model = [[NewsAllModel alloc] init];
            [model setValuesForKeysWithDictionary:modelDic];
            [self.newsAllArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsAllArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NewsAllModel *model = self.newsAllArray[indexPath.row];

    NSURL *url = [NSURL URLWithString:model.pic];

    [cell.pic sd_setImageWithURL:url];

    cell.descLabel.text = model.desc;
    
    cell.nameLabel.text = self.title;
    
    NSString *string = [NSString stringWithFormat:@"%@", model.hot];
   
    cell.hotLabel.text = string;
    
    cell.utimeLabel.text = model.utime;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

@end
