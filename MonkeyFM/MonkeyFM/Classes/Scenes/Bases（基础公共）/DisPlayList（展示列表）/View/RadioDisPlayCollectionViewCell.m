//
//  RadioDisPlayCollectionViewCell.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/1.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "RadioDisPlayCollectionViewCell.h"

@interface RadioDisPlayCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *centerDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSeverTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightEndTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *lastButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *displayListButton;
@end
@implementation RadioDisPlayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.centerDesLabel sizeToFit];
//    self.headImage.layer.cornerRadius = self.headImage.frame.size.width / 2;
//    self.follow.layer.cornerRadius = 4;
}
- (IBAction)playAction:(id)sender {
}

- (IBAction)lastAction:(id)sender {
}

- (IBAction)nextAction:(id)sender {
}

- (IBAction)showDisplayListAction:(id)sender {
}







@end
