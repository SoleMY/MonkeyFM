//
//  AboutUsViewController.m
//  MonkeyFM
//
//  Created by 彭柞淞 on 16/7/6.
//  Copyright © 2016年 FGProject. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsCell.h"

@interface AboutUsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *aboutUsTableView;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat heightLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view NightWithType:UIViewColorTypeNormal];
    self.title = @"关于我们";
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_anchor_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [self setTableView];
    [self.aboutUsTableView registerClass:[AboutUsCell class] forCellReuseIdentifier:@"cell"];
    [self.aboutUsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellTwo"];
}

- (void)setTableView
{
    self.aboutUsTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.aboutUsTableView];
    self.aboutUsTableView.delegate = self;
    self.aboutUsTableView.dataSource = self;
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
 
    
   
    
    switch (indexPath.row) {
        case 0:
        {
             AboutUsCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.myImageView.backgroundColor = [UIColor redColor];
            cell.myImageView.image = [UIImage imageNamed:@"blueMonkey"];
            cell.myLabel.text = @"  开启手机, 连通网络, 我们玩转整个地球. 插上耳机, 按下paly, 我们感受无限律动. 闭上眼睛, 默数节拍, 我们遇见过去未来. MonkeyFM, 动感节奏, 电台、由你我创造. \n  我们将以“电台、由你我创造”作为电台准则, 全心全意为喜爱电台的朋友们营造一个崭新的时尚夜生活空间!";
            [cell.myLabel NightWithType:UIViewColorTypeNormal];
            [cell.myLabel NightTextType:LabelColorBlack];
            self.height = [SmallTools cellTextHeightWithText:cell.myLabel.text font:[UIFont systemFontOfSize:17]];
            [cell NightWithType:UIViewColorTypeNormal];
            return cell;
        }
            break;
        case 1:
        {
               UITableViewCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
            cell.textLabel.text = @"微信:monkeyfm";
            [cell.textLabel NightWithType:UIViewColorTypeNormal];
            [cell.textLabel NightTextType:LabelColorBlack];
            [cell NightWithType:UIViewColorTypeNormal];
            return cell;
        }
            break;
        case 2:
        {
               UITableViewCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
               [cell NightWithType:UIViewColorTypeNormal];
               cell.textLabel.text = @"QQ:2608080678";
            [cell.textLabel NightWithType:UIViewColorTypeNormal];
            [cell.textLabel NightTextType:LabelColorBlack];
            return cell;
        }
            break;
        case 3:
        {
               UITableViewCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
            [cell NightWithType:UIViewColorTypeNormal];
            cell.textLabel.text = @"QQ群:75899666";
            [cell.textLabel NightWithType:UIViewColorTypeNormal];
            [cell.textLabel NightTextType:LabelColorBlack];
            return cell;
        }
            break;
        case 4:
        {
               UITableViewCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
            [cell NightWithType:UIViewColorTypeNormal];
            cell.textLabel.text = @"邮箱:monkey@monkeyfm.com";
            [cell.textLabel NightWithType:UIViewColorTypeNormal];
            [cell.textLabel NightTextType:LabelColorBlack];
            return cell;
        }
            break;
        
            break;
        case 5:
        {
            UITableViewCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
            [cell NightWithType:UIViewColorTypeNormal];
            cell.textLabel.text = @"免责声明:本APP所有内容,包括文字、图片、音频、程序、以及版本设计均在网上搜集。访问者将本APP提供的内容或服务用于个人学习、研究或欣赏，以及其他非商业性或非盈利性用途，但同时应遵守著作权法及其他相关法律的规定，不得侵犯本APP及相关权利人的合法权利。除此以外，本APP无任何盈利性目的,不收取任何费用,但将本APP任何内容或服务用于其他用途时，需征得本APP及相关权利人的书面许可。本APP内容原作者如不愿意在本APP发布内容，请及时通知本APP，我们将立即予以删除。";
            cell.textLabel.numberOfLines = 0;
            [cell.textLabel sizeToFit];
            self.heightLabel = [self cellLabelTextHeightWithText:cell.textLabel.text font:[UIFont systemFontOfSize:17]];
            [cell.textLabel NightWithType:UIViewColorTypeNormal];
            [cell.textLabel NightTextType:LabelColorBlack];
            return cell;
        }
            break;
            
            
        default:
        {
           UITableViewCell *cell = [self.aboutUsTableView dequeueReusableCellWithIdentifier:@"cellTwo" forIndexPath:indexPath];
           [cell NightWithType:UIViewColorTypeNormal];
            return cell;
        }
            break;
    }
    
    
    
//    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        return 140 + self.height;
    }
    
    if (indexPath.row == 5) {
        return self.heightLabel + 5;
    }
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.aboutUsTableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)cellLabelTextHeightWithText:(NSString *)text font:(UIFont *)font {
    // 第一个参数
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 10000);
    
    // 第二个参数：设置以行高为单位
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    return rect.size.height;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
