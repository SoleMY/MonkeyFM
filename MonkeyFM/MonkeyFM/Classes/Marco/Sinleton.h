//
//  Sinleton.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#ifndef Sinleton_h
#define Sinleton_h

// 单例声明
#define singleton_interface(className) \
+ (instancetype)share##className;

// 单例实现
#define singletion_implementation(className) \
static className *manager; \
+ (instancetype)share##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
manager = [[[self class] alloc] init]; \
}); \
return manager; \
}


#endif /* Sinleton_h */
