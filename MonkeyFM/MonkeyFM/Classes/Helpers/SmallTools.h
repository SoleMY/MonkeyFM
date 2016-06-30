//
//  SmallTools.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SmallTools : NSObject


// 根据输入尺寸修改图片大小，并返回UIImage
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

// 声明类方法用来计算文本高度
+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font;

// 声明类方法用来计算图片的高度
+ (CGFloat)imageHeightWithImage:(UIImage *)image;

// 声明类方法用来计算文本宽度
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font;

@end
