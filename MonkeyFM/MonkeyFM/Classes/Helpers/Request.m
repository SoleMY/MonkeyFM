//
//  Request.m
//  MonkeyFM
//
//  Created by lanou3g on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "Request.h"
#import "HeadView.h"
#import "shuffingNetRequest.h"
#import "MFM_URL.h"
#import "shufflingModel.h"
@implementation Request
- (void)requestWithURL:(NSString *)URL view:(UIView *)view frame:(CGRect)frame{
shuffingNetRequest *request = [[shuffingNetRequest alloc] init];
NSMutableArray *arr = [[NSMutableArray alloc] init];
[request requestDataWithString:URL Block:^(id responseObject) {
    NSDictionary *dict = responseObject[@"result"];
    NSArray *listArray = [dict objectForKey:@"dataList"];
    NSDictionary *oneObject = [listArray firstObject];
    NSArray *allDataArray = oneObject[@"dataList"];
    for (NSDictionary *dic in allDataArray) {
        shufflingModel *model = [[shufflingModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model.pic];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        HeadView *head = [[HeadView  alloc] initWithFrame:frame URLArray:arr];
        [view addSubview:head];
    });
}];
}
@end
