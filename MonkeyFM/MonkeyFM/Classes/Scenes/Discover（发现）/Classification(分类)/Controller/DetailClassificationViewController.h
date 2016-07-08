//
//  DetailClassificationViewController.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/27.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseViewController.h"
#import "MryScrollPageVC.h"
#import "ClassificationModel.h"
@interface DetailClassificationViewController : MryScrollPageVC

@property (nonatomic, strong) ClassificationModel *classificationModel;

@property (nonatomic, strong) NSString *urlString;

@end
