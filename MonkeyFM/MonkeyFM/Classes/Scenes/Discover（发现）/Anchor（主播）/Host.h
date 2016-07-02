//
//  Host.h
//  MonkeyFM
//
//  Created by 郑淮予 on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Host : NSObject

//介绍
@property (nonatomic, strong)NSString *recommendReson;
//昵称
@property (nonatomic, strong)NSString *nickName;
//图片
@property (nonatomic, strong)NSString *avatar;
//uid
@property (nonatomic, strong)NSString *uid;
//简介
@property (nonatomic, strong)NSString *intro;

@property (nonatomic, assign)NSInteger followedNum;
@property (nonatomic, assign)NSInteger fansNum;
//@property (nonatomic, strong)NSString *intro;

////社交网络
//@property (nonatomic, strong)


/// 电台页面需要
// 名称
@property (nonatomic, strong) NSString *rname;
// 图片地址
@property (nonatomic, strong) NSString *pic;

@end
