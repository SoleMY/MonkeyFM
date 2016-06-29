//
//  NEWSSegmentModel.h
//  MonkeyFM
//
//  Created by lanou3g on 16/6/25.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "BaseModel.h"

@interface DetailSegment : BaseModel

@property (nonnull, strong) NSString *categoryId;
@property (nonnull, strong) NSString *categoryName;
@property (nonnull, strong) NSString *hasSub;
@property (nonnull, strong) NSString *logo;
@property (nonnull, strong) NSString *linkType;
@property (nonnull, strong) NSString *ID;
@property (nonnull, strong) NSString *imageAoyo;
@property (nonnull, strong) NSString *imageAoyoEffect;


@end
