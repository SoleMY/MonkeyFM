//
//  SystemLight.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/8.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemLight : NSObject

@property (nonatomic, assign) CGFloat currentLight;

singleton_interface(SystemLight)

@end
