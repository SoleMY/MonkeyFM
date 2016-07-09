//
//  SmallTools.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/6/24.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SmallTools.h"

@implementation SmallTools

+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

+ (CGFloat)textHeightWithText:(NSString *)text font:(UIFont *)font {
    
    // iOS7.0中求文本高度的方法，返回一个CGRect的高度
    
    // 第一个参数
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 10000);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.height;
}


// 计算文本高度
+ (CGFloat)FramWithtextHeightWithText:(NSString *)text font:(UIFont *)font {
    
    // iOS7.0中求文本高度的方法，返回一个CGRect的高度
    
    // 第一个参数
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 70, 10000);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.height;
}

// 计算图片高度
+ (CGFloat)imageHeightWithImage:(UIImage *)image {
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    //    float scile = height / width;
    //
    //    float screenH = [UIScreen mainScreen].bounds.size.width;
    
    
    NSLog(@"%f", width);
    //    return  scile * screenH;
    return height / width * [UIScreen mainScreen].bounds.size.width;
}

// 计算文本高度
+ (CGFloat)textWidthWithText:(NSString *)text font:(UIFont *)font {
    
    // iOS7.0中求文本高度的方法，返回一个CGRect的高度
    
    // 第一个参数
    CGSize size = CGSizeMake(100000, 25);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.width;
}

+ (CGFloat)cellTextHeightWithText:(NSString *)text font:(UIFont *)font {
    // 第一个参数
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 10000);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.height;
}

@end
