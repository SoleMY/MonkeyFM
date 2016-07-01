//
//  PlayList.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/30.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayList : NSObject

@property (nonatomic, strong)NSArray *host;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *updateDay;
@property (nonatomic, strong)NSString *copyrightLabel;
@property (nonatomic, strong)NSString *uploadUserName;
@property (nonatomic, strong)NSArray *keyWords;
@property (nonatomic, strong)NSString *radioDesc;

@property (nonatomic, strong)NSString *audioName;
@property (nonatomic, assign)NSInteger orderNum;
@property (nonatomic, assign)NSInteger listenNum;
@property (nonatomic, assign)NSInteger likedNum;
@property (nonatomic, assign)NSInteger commentNum;
@property (nonatomic, strong)NSString *updateTime;


@property (nonatomic, strong)NSString *userImg;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *utime;
@property (nonatomic, assign)NSInteger praiseNum;

@end
