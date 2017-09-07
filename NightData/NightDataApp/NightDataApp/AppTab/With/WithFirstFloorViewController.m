//
//  WithFirstFloorViewController.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/7/11.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "WithFirstFloorViewController.h"
#import "JCFlipPage.h"
#import "JCFlipPageView.h"
#import "withModel.h"
#import "SZQRCodeViewController.h"
#import "orderListViewController.h"
#import "packViewController.h"
#import "loginViewController.h"
@interface WithFirstFloorViewController ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation WithFirstFloorViewController
{
    NSMutableArray *modelArray;
    UITableView *shopTipTable;
    
    UILabel *orderNumber;
    UILabel *moneyNumber;
    
    BaseDomain *getData;
    NSDictionary *orderCound;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    
   

    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    getData = [BaseDomain getInstance:NO];
    [self.view setBackgroundColor:Color_blackBack];
    [self createView];
    [self createData];
    
    // Do any additional setup after loading the view.
}
-(void)createData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [getData getData:URL_getOrderNum PostParams:params finish:^(BaseDomain *domain, Boolean success) {
       
        if ([self checkHttpResponseResultStatus:domain]) {
            
            
            orderCound = [domain.dataRoot  dictionaryForKey:@"bar_order"];
            [self reloadView];
            
        }
        
    }];
}

-(void)reloadView
{
    orderNumber.text = [orderCound stringForKey:@"order_count"];
    moneyNumber.text = [NSString stringWithFormat:@"￥%@",[orderCound stringForKey:@"order_sum"]];
}
-(void)createView
{
    shopTipTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [shopTipTable setBackgroundColor:Color_blackBack];
    shopTipTable.delegate = self;
    shopTipTable.dataSource = self;
    [self.view addSubview:shopTipTable];
    shopTipTable.tableHeaderView = [self tableHeadView];
    
}

-(UIView *)tableHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [headView setBackgroundColor:Color_blackBack];
    
    UIImageView *imageHead = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 204)];
    [headView addSubview:imageHead];
    [imageHead setImage:[UIImage imageNamed:@"headBackCard"]];
    
    
    
    UILabel *labelOrderNumber = [UILabel new];
    [imageHead addSubview:labelOrderNumber];
    labelOrderNumber.sd_layout
    .leftEqualToView(imageHead)
    .topSpaceToView(imageHead, 80)
    .heightIs(20)
    .widthIs(SCREEN_WIDTH / 2 - 1);
    [labelOrderNumber setText:@"今日订单"];
    [labelOrderNumber setTextColor:Color_white];
    [labelOrderNumber setTextAlignment:NSTextAlignmentCenter];
    [labelOrderNumber setFont:[UIFont systemFontOfSize:18]];
    
    
    
    orderNumber = [UILabel new];
    [imageHead addSubview:orderNumber];
    orderNumber.sd_layout
    .leftEqualToView(imageHead)
    .topSpaceToView(labelOrderNumber, 20)
    .heightIs(30)
    .widthIs(SCREEN_WIDTH / 2 - 1);
    [orderNumber setText:@"0"];
    [orderNumber setTextAlignment:NSTextAlignmentCenter];
    [orderNumber setFont:[UIFont boldSystemFontOfSize:20]];
    [orderNumber setTextColor:[UIColor whiteColor]];
    
    
    UIView *lineView = [UIView new];
    [imageHead addSubview:lineView];
    lineView.sd_layout
    .topSpaceToView(imageHead, 85)
    .leftSpaceToView(labelOrderNumber, 0)
    .heightIs(60)
    .widthIs(1);
    [lineView setBackgroundColor:Color_whiteLight];
    
    
    UILabel *labelMoneyNumber = [UILabel new];
    [imageHead addSubview:labelMoneyNumber];
    labelMoneyNumber.sd_layout
    .rightEqualToView(imageHead)
    .topSpaceToView(imageHead, 80)
    .heightIs(20)
    .widthIs(SCREEN_WIDTH / 2);
    [labelMoneyNumber setText:@"今日营业额"];
    [labelMoneyNumber setTextAlignment:NSTextAlignmentCenter];
    [labelMoneyNumber setFont:[UIFont systemFontOfSize:18]];
    [labelMoneyNumber setTextColor:Color_white];
    
    
    moneyNumber = [UILabel new];
    [imageHead addSubview:moneyNumber];
    moneyNumber.sd_layout
    .rightEqualToView(imageHead)
    .topSpaceToView(labelMoneyNumber, 20)
    .heightIs(30)
    .widthIs(SCREEN_WIDTH / 2);
    [moneyNumber setText:@"￥0"];
    [moneyNumber setTextAlignment:NSTextAlignmentCenter];
    [moneyNumber setFont:[UIFont boldSystemFontOfSize:20]];
    [moneyNumber setTextColor:[UIColor whiteColor]];
    
   
    
    
    NSArray *array = [NSArray arrayWithObjects:@"扫码",@"订单管理",@"钱包",@"店铺管理",@"组局管理",@"认证中心", nil];
    for (int i = 0; i < 6 ; i ++) {
        UIButton *buttonTip = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * (i % 3), 204 + (i / 3) *SCREEN_WIDTH / 3, SCREEN_WIDTH / 3, SCREEN_WIDTH / 3)];
        [buttonTip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buttonTip setTitle:@"dd" forState:UIControlStateNormal];
       
        [buttonTip setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tip%d",i + 1]] forState:UIControlStateNormal];
        [buttonTip setTitle:array[i] forState:UIControlStateNormal];
        
        
        [buttonTip.titleLabel setFont:[UIFont systemFontOfSize:12]];
        
        buttonTip.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [buttonTip setTitleEdgeInsets:UIEdgeInsetsMake(buttonTip.imageView.frame.size.height + 20 ,-buttonTip.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [buttonTip setImageEdgeInsets:UIEdgeInsetsMake(-20, 0.0,0.0, -buttonTip.titleLabel.bounds.size.width)];
        [headView addSubview:buttonTip];
        
        buttonTip.tag = i + 5;
        [buttonTip addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    UIButton *buttonLogout = [[UIButton alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 50, SCREEN_WIDTH - 40, 40)];
    [buttonLogout setBackgroundImage:[UIImage imageNamed:@"ShakeBackView"] forState:UIControlStateNormal];
    [buttonLogout addTarget:self action:@selector(clickExit) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonLogout setTitle:@"注销" forState:UIControlStateNormal];
    [buttonLogout.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [headView addSubview:buttonLogout];
    
    
    return headView;
}

-(void)clickExit
{
    loginViewController *login = [[loginViewController alloc] init];
    [[LoginManager getInstance] exitSystemLogin:login];
}


-(void)buttonClick:(UIButton *)sender
{
    switch (sender.tag - 5) {
        case 0:
        {
            SZQRCodeViewController *Szq = [[SZQRCodeViewController alloc] init];
            [self.navigationController pushViewController:Szq animated:YES];
        }

            break;
            
        case 1:
        {
            orderListViewController *order = [[orderListViewController alloc] init];
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
        case 2:
        {
            packViewController *pack = [[packViewController alloc] init];
            [self.navigationController pushViewController:pack animated:YES];
            
        }
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;
       
        default:
            break;
    }
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"main";
    //定义cell的复用性当处理大量数据时减少内存开销
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
   
    return cell;
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
