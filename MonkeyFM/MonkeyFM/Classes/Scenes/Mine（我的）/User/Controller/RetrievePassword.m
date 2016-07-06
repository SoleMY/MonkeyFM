//
//  RetrievePassword.m
//  MonkeyFM
//
//  Created by lanou3g on 16/7/5.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RetrievePassword.h"
#import "AVOSCloud/AVOSCloud.h"
@interface RetrievePassword ()
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextField *VerificationCode;

@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *mima2;


@end

@implementation RetrievePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)VerificationCode:(id)sender {
    [AVUser requestPasswordResetWithPhoneNumber:self.telTextField.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
        } else {
            
        }
    }];
    
}


- (IBAction)RetrievePasswordButton:(id)sender {
    
    
    if ([self.mima2.text isEqualToString:self.mima.text]) {
        [AVUser resetPasswordWithSmsCode:self.VerificationCode.text newPassword:self.mima.text block:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                
            }
        }];
    }
    
    
    
}
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
