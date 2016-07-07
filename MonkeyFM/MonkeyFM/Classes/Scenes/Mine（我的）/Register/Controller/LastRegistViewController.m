//
//  LastRegistViewController.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/4.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "LastRegistViewController.h"
#import "AVOSCloud/AVOSCloud.h"
#import "LoginViewController.h"
@interface LastRegistViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nickname;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (nonatomic, strong) UIImagePickerController *imagePicker; //图片选择器

@end

@implementation LastRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置圆角
    self.headerImage.layer.masksToBounds=YES;
    self.headerImage.layer.cornerRadius=150/2.0f; //设置为图片宽度的一半出来为圆形
//    self.headerImage.layer.borderWidth=1.0f; //边框宽度
//    self.headerImage.layer.borderColor=[[UIColor greenColor] CGColor];//边框颜色

    // 图片添加手势
    self.headerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapheaderImage:)];
    // 设置轻拍次数
    aTapGR.numberOfTapsRequired = 1;
    
    aTapGR.delegate = self;
    
    // 添加手势
    [self.headerImage addGestureRecognizer:aTapGR];
    
    // 图片管理器
    self.imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    
    // 写完之后判断
    [self addFinishWrite];

    self.view.backgroundColor = kNavigationBarTintColor;
    
    self.nickname.delegate = self;
    [self.nickname becomeFirstResponder];
    self.password.delegate = self;
    [self.password becomeFirstResponder];
    self.email.delegate = self;
    [self.email becomeFirstResponder];
}

// 当点击键盘return的时候
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nickname resignFirstResponder]; // 释放第一响应者
    [self.password resignFirstResponder];
    [self.email resignFirstResponder];
    return YES;
}
//  触摸屏幕回收键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}


- (void)addFinishWrite
{
    [self.nickname addTarget:self action:@selector(nicknameAction:) forControlEvents:UIControlEventEditingDidEnd];
    [self.password addTarget:self action:@selector(passwordAction:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)nicknameAction:(UITextField *)sender
{
    if (self.nickname.text.length <= 2 || self.nickname.text.length > 12) {
        [self setHUDWithTitle:@"您输入的昵称不合格"];
    }
  }

- (void)passwordAction:(UITextField *)sender
{
    if (self.password.text.length < 6) {
        [self setHUDWithTitle:@"您的密码过于简单"];
    }
    if (self.password.text.length > 16) {
        [self setHUDWithTitle:@"您的密码过长"];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registeButton:(id)sender {
    
    if (self.nickname.text.length > 2 && self.nickname.text.length <= 12 && self.password.text.length >= 6 && self.password.text.length <= 16) {
        
        
        [[AVUser currentUser] setObject:self.nickname.text forKey:@"username"];
        [[AVUser currentUser] setObject:self.password.text forKey:@"password"];
        NSData *data = UIImageJPEGRepresentation(self.headerImage.image,1.0);
        [[AVUser currentUser] setObject:data forKeyedSubscript:@"headImage"];
        [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                LoginViewController *login = [[LoginViewController alloc] init];
                login.nickName.text = self.nickname.text;
                login.headerImage = self.headerImage;
                [self.navigationController pushViewController:login animated:YES];
            } else {
                [self setHUDWithTitle:@"未知错误"];
            }
        }];
    }
    
}

- (void)setHUDWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 5.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (IBAction)backButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)tapheaderImage:(UIGestureRecognizer *)sender {
    // 调用系统相册、相机
    // 添加alertSheet
    __weak typeof(self)weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicker.allowsEditing = YES;
        [weakSelf presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.allowsEditing = YES;
        [weakSelf presentViewController:_imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:photoAction];
    [alert addAction:cameraAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    // 赋值头像
    self.headerImage.image = image;
    
    // == //
    NSData *data = UIImageJPEGRepresentation(image,1.0);
    [[AVUser currentUser] setObject:data forKeyedSubscript:@"headImage"];
    [[AVUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"##########%@", error);
    }];
    // == //
    
    // 如果是相机
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
    }
    // dismiss当前的选择页面
    [self dismissViewControllerAnimated:YES completion:nil];
}
#warning 这个需要实现什么
- (void)saveImage {
    NSLog(@"存储图片...");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
