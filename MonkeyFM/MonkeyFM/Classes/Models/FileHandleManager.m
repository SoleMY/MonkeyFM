//
//  FileHandleManager.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "FileHandleManager.h"


@implementation FileHandleManager

singletion_implementation(FileHandleManager)

- (NSString *)cachesPath
{
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)setFilesSize:(CGFloat)size
{
    [[NSUserDefaults standardUserDefaults] setFloat:size forKey:@"size"];
}

- (CGFloat)filesSize
{
    return [[NSUserDefaults standardUserDefaults] floatForKey:@"size"];
}



#pragma mark - 缓存
#pragma mark 下载的图片的完整路径
#pragma mark----自定义存储图片。将下载下来的图片保存在本地沙盒中，每张图片的名字统一格式是，将imageURL中‘/’都替换成‘_’作为图片文件的名字。
- (NSString *)imageFilePathWithURL:(NSString *)imageURL
{
    //根据图像的URL，创建图像在存储时的文件名
    NSString * imageName = [imageURL stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    
    return [[self downloadImageManagerFilePath] stringByAppendingPathComponent:imageName];
}
//通常用于删除缓存的时，计算缓存大小
//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
//
//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//将下载的图片存储到沙盒中
- (void)saveDownloadImage:(UIImage *)image filePath:(NSString *)path
{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    [data writeToFile:path atomically:YES];
    CGFloat size = [self folderSizeAtPath:[self downloadImageManagerFilePath]];
    //获取SDWebImage下载图片时的缓存，并得到大小
    size = size + [[SDImageCache sharedImageCache] getSize] / (1024.0*1024.0);
    NSLog(@"%lu",(unsigned long)[[SDImageCache sharedImageCache] getSize]);
    [self setFilesSize:size];
}
#pragma mark 存储下载图片的文件夹路径
- (NSString *)downloadImageManagerFilePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * imageManagerPath = [[self cachesPath] stringByAppendingPathComponent:@"DownloadImages"];
    if (NO == [fileManager fileExistsAtPath:imageManagerPath]) {
        //如果沙盒中没有存储图像的文件夹，创建文件夹
        [fileManager createDirectoryAtPath:imageManagerPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return imageManagerPath;
}

#pragma mark 清除缓存
- (float)cleanDownloadImages
{
    //清除头像图片
    [[SDImageCache sharedImageCache] clearDisk];
    
    NSString * imageManagerPath = [self downloadImageManagerFilePath];
    //清除活动列表和电影列表对应 的图片
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:imageManagerPath error:nil];
    return 0.0;
    
}



@end
