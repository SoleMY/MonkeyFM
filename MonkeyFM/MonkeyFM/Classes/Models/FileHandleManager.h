//
//  FileHandleManager.h
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileHandleManager : NSObject

- (void)setFilesSize:(CGFloat)size;
- (NSString *)cachesPath;
singleton_interface(FileHandleManager)
#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
- (NSString *)imageFilePathWithURL:(NSString *)imageURL;
#pragma mark 保存图片缓存
- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path;
#pragma mark 清除缓存
- (float)cleanDownloadImages;
- (float)folderSizeAtPath:(NSString*)folderPath;

@end
