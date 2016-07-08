//
//  MBProgressHUD+GifHUD.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/8.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "MBProgressHUD+GifHUD.h"
#import <SDWebImage/UIImage+GIF.h>

@implementation MBProgressHUD (GifHUD)


+ (void)setUpGifWithFrame:(CGRect)frame andShowToView:(UIView *)view
{
    // 使用MBProgress 播放gif 需要自定义视图显示
    // 添加动画
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    // 准备图片数组
    NSMutableArray *imageArray = [NSMutableArray array];
    
    for (int i = 1; i <= 9; i++) {
        // 图片名
        NSString *nameStr = [NSString stringWithFormat:@"ic_fresh_%d@2x",i];
        // 创建UIImage对象
        UIImage *image = [UIImage imageNamed:nameStr];
        // 添加到数组中
        [imageArray addObject:image];
    }
    // 设置一组动态图片
    imageView.animationImages = imageArray;
    // 设置动画播放时间
    imageView.animationDuration = 1;
    // 设置重复次数
    imageView.animationRepeatCount = 0;
    // 开始动画
    [imageView startAnimating];
    // 添加动态图片
//    [self.window addSubview:imageView];
    
    // 自定义视图
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    hud.customView = imageView;
    //    hud.color = COLOR(0, 0, 0, 0.5);
    hud.color = [UIColor clearColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"正在加载...";
    
}




@end
