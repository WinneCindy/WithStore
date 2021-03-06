//
//  HHBaseViewController.m
//  DalianPort
//
//  Created by mac on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

#import "RDVTabBarController.h"
#import "UrlManager.h"
#import "AppDelegate.h"
#import "LoginManager.h"
#import "Masonry.h"
#import "userInfoModel.h"
#import "MBProgressHUD.h"
static NSString * Key_MsgList_Histroy_SearchTime = @"Message_SearchTime";

@interface BaseViewController ()
{
    CGFloat initViewY;
    Boolean isViewYFisrt;
    UIAlertView * alert;
    UIAlertView *alertTime;
    BaseDomain *timePostData;
    NSTimer *timers;
}

@property (nonatomic, retain) MBProgressHUD *progressHud;

@property (nonatomic, retain) UIAlertView *Albumalert;

@property (nonatomic, retain) BaseDomain *details;

@property (nonatomic, retain) UILabel *messageWorning;
@property (nonatomic, retain) NSMutableArray *msgList;
@property (nonatomic, retain) UIAlertView *alert;

@property (nonatomic, retain) NSMutableArray *imageViews;
@property (nonatomic, retain) UIAlertView *outAlert;
- (IBAction)onSpaceViewClickToCloseKeyboard:(id)sender;
- (CGFloat) getControlFrameOriginY : (UIView *) curView;

@end

@implementation BaseViewController

{
//    AwAlertView *awAlert;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        isViewYFisrt = YES;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.viewRootBak = self.view;
    self.details = [BaseDomain getInstance:YES];
    UIControl * controlView = [[UIControl alloc] initWithFrame:self.view.frame];
    timePostData = [BaseDomain getInstance:NO];
    [controlView addTarget:self action:@selector(onSpaceViewClickToCloseKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:controlView];
    [controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
    }];
    [self.view sendSubviewToBack:controlView];
    if (self.navigationItem != nil){
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }

}







- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

-(Boolean)userHaveLogin
{
    userInfoModel *userInfo = [userInfoModel getInstance];
    if ([userInfo checkUserHaveBeenLogin]) {
        return YES;
    } else return NO;
    
}



-(void)settabTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [titleLabel setTextColor:[UIColor whiteColor]];
    self.rdv_tabBarController.navigationItem.titleView = titleLabel;
}

-(void)settabImg:(NSString *)Img
{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 23)];
    [image setImage:[UIImage imageNamed:Img]];
    self.rdv_tabBarController.navigationItem.titleView = image;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}




- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)progressShow:(NSString*) title animated:(BOOL)animated{
    
    self.progressHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.progressHud];
    
    UIImage *image = [[UIImage imageNamed:@"toast_loading"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    _progressHud.customView = imgView;
    //    self.progressHud.dimBackground = YES;
    //self.progressHud.delegate = self;
    
    if (title==nil) {
        title = @"请求中";
    }
    _progressHud.label.text = title;
    
    [self.progressHud show:YES];
}

- (void)progressHide:(BOOL)animated{
    
    if (self.progressHud != nil){
        [self.progressHud hide:animated];
        
        [self.progressHud removeFromSuperview];
        //[self.progressHud release];
        self.progressHud = nil;
        
    }
}


- (Boolean) checkHttpResponseResultStatus:(BaseDomain*) domain {
    
    if (domain.result == 1) {
        return YES;
    } else if(domain.result == 10001) {
        BaseViewController *enter = [[BaseViewController alloc] init];
        [self presentViewController:enter animated:YES completion:nil];
        return NO;
    } else {
        if (domain.result == -99) {
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"dialog_title_tip", nil) message:domain.resultMessage delegate:self cancelButtonTitle:NSLocalizedString(@"dialog_button_okknow", nil) otherButtonTitles: nil];
            
            [alert show];
        } else {
            alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"dialog_title_tip", nil) message:domain.resultMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"dialog_button_okknow", nil) otherButtonTitles: nil];
            
            [alert show];
        }
        
        
        return NO;
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == alert) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - MBProgressHUDDelegate methods

#pragma mark - textFieldKeyboard

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (isViewYFisrt) {
        initViewY = self.view.frame.origin.y;
        isViewYFisrt = NO;
    }
    
    int offset = [self getControlFrameOriginY:textField] + 45 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

- (CGFloat) getControlFrameOriginY : (UIView *) curView {
    
    CGFloat resultY = 0;
    
    if ([curView superview] != nil && ![[curView superview] isEqual:self.view]) {
        resultY = [self getControlFrameOriginY:[curView superview]];
    }
    
    return resultY + curView.frame.origin.y;
}


- (CGFloat) calculateTextHeight:(UIFont *)font givenText:(NSString *)text givenWidth:(CGFloat)width{
    CGFloat delta;
    if ([text isEqualToString:@""]) {
        delta = 0;
    } else {
        CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 9999) lineBreakMode:NSLineBreakByWordWrapping];
        
        delta = size.height;
    }
    
    
    return delta;
    
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect frame = self.view.frame;
    
    frame.origin.x = 0;
    frame.origin.y = initViewY;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    [self.view setFrame:frame];
    
    [UIView commitAnimations];
//    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


//指定宽度按比例缩放
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

- (IBAction)onSpaceViewClickToCloseKeyboard:(id)sender{
    if (self.view != nil) {
        [self.view endEditing:YES];
    }
}




+ (NSString*) getFriendlyDateString : (long long) lngDate {
    
    NSDate *curDate = [NSDate dateWithTimeIntervalSince1970:lngDate];
    
    NSDate *myDate = [NSDate date];
    
    NSString *DIF;
    NSString *strDate;
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *compsNow = [[NSDateComponents alloc] init];
    NSDateComponents *compsCur = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    compsNow = [calendar components:unitFlags fromDate:myDate];
    compsCur = [calendar components:unitFlags fromDate:curDate];
    
    if ([compsCur day]==[compsNow day]&&[compsCur month]==[compsNow month]&&[compsCur year]==[compsNow year]) {
        DIF=@"今天";
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [formatter setDateFormat:@"HH:mm"];
        
        NSString* dateStr = [formatter stringFromDate:curDate];
        
        strDate=[NSString stringWithFormat:@"%@ %@",DIF,dateStr];
        
    }else if ([compsCur day]+1==[compsNow day]&&[compsCur month]==[compsNow month]&&[compsCur year]==[compsNow year]){
        DIF=@"昨天";
        
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [formatter setDateFormat:@"HH:mm"];
        
        NSString* dateStr = [formatter stringFromDate:curDate];
        
        
        strDate=[NSString stringWithFormat:@"%@ %@",DIF,dateStr];
    }else{
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [formatter setDateFormat:@"MM-dd"];
        
        NSString* dateStr = [formatter stringFromDate:curDate];
        
        
        strDate=dateStr;
    }
    
    return strDate;
    
}


-(void)hiddenALert
{
    if (timers.isValid) {
        [timers invalidate];
    }
    timers=nil;
    [alertTime dismissWithClickedButtonIndex:0 animated:YES];
    
}

-(void)alertViewShowOfTime:(NSString *)message time:(NSInteger)time
{
    alertTime = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertTime show];
    timers= [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hiddenALert) userInfo:nil repeats:NO];
}

@end
