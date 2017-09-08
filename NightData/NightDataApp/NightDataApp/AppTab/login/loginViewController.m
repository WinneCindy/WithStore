//
//  loginViewController.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/9/7.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "loginViewController.h"
#import "LoginTextfield.h"
#import "AppDelegate.h"
@interface loginViewController ()<loginTextFieldDelegate>

@end

@implementation loginViewController
{
    LoginTextfield *phoneNumber;
    LoginTextfield *checkNumber;
    UIImageView *logoCicle;
    UIImageView *headImage;
    UIButton *btnCheck;
    UIButton *butLogin;
    UIImageView *backImg;
    BOOL animation;
    
    NSMutableDictionary *params;
    BaseDomain *DataSend;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    DataSend = [BaseDomain getInstance:NO];
    animation = NO;
    backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [backImg setImage:[UIImage imageNamed:@"loginBack"]];
    [backImg setUserInteractionEnabled:YES];
    [self.view addSubview:backImg];
    [self createView];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)createView
{
    logoCicle = [UIImageView new];
    [self.view addSubview:logoCicle];
    logoCicle.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 64)
    .heightIs(80)
    .widthIs(80);
    [logoCicle setImage:[UIImage imageNamed:@"loginCircle"]];
    
    
    headImage = [UIImageView new];
    [self.view addSubview:headImage];
    headImage.sd_layout
    .centerXEqualToView(self.view)
    .topSpaceToView(self.view, 68)
    .heightIs(72)
    .widthIs(72);
    
    //    [headImage.layer setCornerRadius:36];
    //    [headImage.layer setMasksToBounds:YES];
    headImage.sd_cornerRadiusFromHeightRatio = @(0.5);
    [headImage setImage:ImagePlaceHolder];
    
    
    phoneNumber = [[LoginTextfield alloc] initWithFrame:CGRectZero titleName:@"手机号"];
    [backImg addSubview:phoneNumber];
    phoneNumber.sd_layout
    .topSpaceToView(backImg,140 + 113.0 / 667.0 * SCREEN_HEIGHT)
    .leftSpaceToView(backImg, 50)
    .rightSpaceToView(backImg, 50)
    .heightIs(50);
    phoneNumber.tag = 2;
    phoneNumber.delegate = self;
    [phoneNumber.layer setBorderColor:Color_whiteLight.CGColor];
    [phoneNumber.layer setBorderWidth:1];
    [phoneNumber.layer setCornerRadius:25];
    [phoneNumber.layer setMasksToBounds:YES];
    
    
    
    btnCheck = [UIButton new];
    [backImg addSubview:btnCheck];
    btnCheck.sd_layout
    .topSpaceToView(backImg,140 +  118.0 / 667.0 * SCREEN_HEIGHT)
    .widthIs(40)
    .rightSpaceToView(backImg, 55)
    .heightIs(40);
    [btnCheck.layer setCornerRadius:20];
    [btnCheck.layer setMasksToBounds:YES];
    [btnCheck setImage:[UIImage imageNamed:@"getCheck"] forState:UIControlStateNormal];
    [btnCheck addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    checkNumber = [[LoginTextfield alloc] initWithFrame:CGRectZero titleName:@"验证码"];
    [backImg addSubview:checkNumber];
    checkNumber.sd_layout
    .topSpaceToView(phoneNumber, 31)
    .leftSpaceToView(backImg, 50)
    .rightSpaceToView(backImg, 50)
    .heightIs(50);
    checkNumber.tag = 3;
    checkNumber.delegate = self;
    [checkNumber.layer setBorderColor:Color_whiteLight.CGColor];
    [checkNumber.layer setBorderWidth:1];
    [checkNumber.layer setCornerRadius:25];
    [checkNumber.layer setMasksToBounds:YES];
    
    
    butLogin = [UIButton new];
    [backImg addSubview:butLogin];
    butLogin.sd_layout
    .centerXEqualToView(backImg)
    .topSpaceToView(checkNumber, 63.0 / 667.0 * SCREEN_HEIGHT)
    .heightIs(73)
    .widthIs(73);
    [butLogin.layer setCornerRadius:73.0 / 2.0];
    [butLogin.layer setMasksToBounds:YES];
    [butLogin setImage:[UIImage imageNamed:@"loginBtn"] forState:UIControlStateNormal
     ];
    [butLogin addTarget:self action:@selector(LoginClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sendClick
{
    [phoneNumber endEditing:YES];
    
    if (phoneNumber.detailText.text.length == 0) {
        
    } else {
        NSMutableDictionary *paramsdic = [NSMutableDictionary dictionary];
        [paramsdic setObject:phoneNumber.detailText.text forKey:@"phone"];
        [DataSend postData:URL_GetCheckCode PostParams:paramsdic finish:^(BaseDomain *domain, Boolean success) {
            
            
            if ([self checkHttpResponseResultStatus:domain]) {
                
                NSUserDefaults *used = [NSUserDefaults standardUserDefaults];
                [used setObject:[[domain.dataRoot objectForKey:@"data"] stringForKey:@"token"] forKey:@"token"];
                
                [self alertViewShowOfTime:@"验证码已经发送，请注意查收" time:1];
                
                
            }
        }];
        
        
    }
}

-(void)LoginClick
{
    
    [self.view endEditing:YES];
    
    // 检测手机号码是否输入
    if (phoneNumber.detailText.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入手机号" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        
        [alertView show];
        
        
        
        return;
    }
    
    // 检测密码是否输入
    if (checkNumber.detailText.text.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入验证码" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        
        [alertView show];
        
        
        
        return;
    }
    
    
    [[LoginManager getInstance] postLoginAuth:phoneNumber.detailText.text userPwd:checkNumber.detailText.text isAuto:YES finish:^(Boolean success) {
        if (success) {
            
            NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
            [userd setObject:phoneNumber.detailText.text forKey:@"phone"];
            [SelfPersonInfo getInstance].personPhone = phoneNumber.detailText.text;
//            [self dismissViewControllerAnimated:YES completion:nil];
            
            [[AppDelegate getInstance] runMainViewController:nil];
            
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"loginSuccess" object:nil];
            
        } else {
            
        }
    }];
    
    
   

}

-(void)textDidBeginEdit
{
    
    if (!animation) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        backImg.centerY -= 100;
        logoCicle.centerY -= 40;
        headImage.centerY -= 40;
        logoCicle.centerX += 10;
        headImage.centerX +=10;
        logoCicle.size = CGSizeMake(60, 60);
        headImage.size = CGSizeMake(52, 52);
        [headImage.layer setCornerRadius:26];
        [headImage.layer setMasksToBounds:YES];
        [UIView commitAnimations];
        animation = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditingSelview:)];
        [backImg addGestureRecognizer:tap];
    }
    

    
}



-(void)textDidEndShowText:(NSString *)text tag:(NSInteger)tagFlog
{
    if (animation) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        backImg.centerY += 100;
        
        logoCicle.centerY += 40;
        headImage.centerY += 40;
        logoCicle.centerX -= 10;
        headImage.centerX -=10;
        logoCicle.size = CGSizeMake(80, 80);
        headImage.size = CGSizeMake(72, 72);
        [headImage.layer setCornerRadius:36];
        [headImage.layer setMasksToBounds:YES];
        [UIView commitAnimations];
        animation = NO;
    }
    
    if (tagFlog==2) {
        [params setObject:text forKey:@"userName"];
    } else {
        [params setObject:text forKey:@"check"];
    }
}

-(void)endEditingSelview:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    [backImg removeGestureRecognizer:tap];
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
