//
//  SettingViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#import "AboutUsViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (nonatomic, strong) NSMutableDictionary *textDict;
@property (nonatomic, strong) NSString *diskSize;

@end

@implementation SettingViewController
static NSString * const identifier_cell = @"identifier_cell";
static NSString * const identifier_switchCell = @"identifier_switchCell";

- (NSMutableDictionary *)textDict
{
    if (!_textDict) {
        _textDict = [NSMutableDictionary dictionary];
    }
    return _textDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.title = @"设置";
    [self setTableView];
   
}

- (void)setTableView
{
    // 适配夜间模式
//    [self.settingTableView NightWithType:UIViewColorTypeNormal];
//    [self.settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier_cell];
    [self.settingTableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:identifier_switchCell];
    [self.textDict setValue:[NSArray arrayWithObjects:@"使用移动流量收听", @"夜间模式", nil] forKey:@"0"];
    [self.textDict setValue:[NSArray arrayWithObjects:@"当前版本", @"清除缓存", @"关于我们", nil] forKey:@"1"];
}


#pragma mark - UITableViewMethod ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.textDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.textDict objectForKey:[NSString stringWithFormat:@"%ld", section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_switchCell forIndexPath:indexPath];
        cell.leftTextLabel.text = [self.textDict objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section]][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_cell];
        if (nil == cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier_cell];
        }

        [cell NightWithType:UIViewColorTypeNormal];
        [cell.textLabel NightWithType:UIViewColorTypeNormal];
        [cell.textLabel NightTextType:LabelColorBlack];
        cell.textLabel.text = [self.textDict objectForKey:[NSString stringWithFormat:@"%ld", indexPath.section]][indexPath.row];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"v1.0.0";
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2lfM", [self getDiskSize]];
        } else if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {
        
    } else {
        if (indexPath.row == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *trueActoin = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf clearDisk];
                [weakSelf.settingTableView reloadData];
                
            }];
            [alertController addAction:trueActoin];
            [alertController addAction:cancleAction];
            [self presentViewController:alertController animated:YES completion:nil];
        } else if (indexPath.row == 2) {
            AboutUsViewController *aboutVC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//获取硬盘大小
- (CGFloat)getDiskSize{
    
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    //初始化文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    //获取lib下所有路径
    NSArray *libAllPath = [mgr subpathsAtPath:libPath];
    NSInteger size = 0;
    for (NSString *path in libAllPath) {
        if (![path containsString:@"Preferences"]) {
            //把路径拼接全
            NSString *pathA = [libPath stringByAppendingPathComponent:path];
            //获取文件的所有信息
            NSDictionary *fileAttri = [mgr attributesOfItemAtPath:pathA error:nil];
            //获取文件大小
            size += [fileAttri[@"NSFileSize"] integerValue];
        }
    }
    return size/1024.0/1024.0;
}
//清楚缓存
- (void)clearDisk{
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    //初始化文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    //获取lib下所有路径
    NSArray *libAllPath = [mgr subpathsAtPath:libPath];
    
    for (NSString *path in libAllPath) {
        if (![path containsString:@"Preferences"]) {
            //把路径拼接全
            NSString *pathA = [libPath stringByAppendingPathComponent:path];
            //移除文件
            [mgr removeItemAtPath:pathA error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDisk];
}



@end
