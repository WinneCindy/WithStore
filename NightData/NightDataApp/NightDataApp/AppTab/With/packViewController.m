//
//  packViewController.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/9/7.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "packViewController.h"
#import "orderModel.h"
#import "packTableViewCell.h"
@interface packViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation packViewController
{
    UILabel *moneyLabel;
    
    UILabel *coinLabel;
    
    UIButton *eyesButton;
    
    NSArray *titleArray;
    
    NSMutableArray *modelArray;
    
    BaseDomain *getData;
    
    UITableView *table;
    
    NSString *money;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    getData = [BaseDomain getInstance:NO];
    modelArray = [NSMutableArray array];
    [self.view setBackgroundColor:getUIColor(Color_black)];
    [self createData];
    [self createViewTable];
    // Do any additional setup after loading the view.
}

-(void)createData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [getData getData:URL_get_daily_bill PostParams:params finish:^(BaseDomain *domain, Boolean success) {
       
        if ([self checkHttpResponseResultStatus:domain]) {
            
            
            money = [domain.dataRoot stringForKey:@"all_order_sum"];
            for (NSDictionary *dic in [[domain.dataRoot objectForKey:@"list"] arrayForKey:@"data"]) {
                orderModel *model = [orderModel new];
                model.userId = [dic stringForKey:@"uid"];
                model.userName = [[dic dictionaryForKey:@"user"] stringForKey:@"name"];
                model.payMoney = [dic stringForKey:@"pay_sum"];
                model.orderTime = [packViewController getFriendlyDateString:[dic integerForKey:@"pay_date"]];
                [modelArray addObject:model];
            }
            
            [table reloadData];
            [self reloadPack];
        }
        
    }];
}

-(void)createViewTable
{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [table setBackgroundColor:Color_blackBack];
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    table.tableHeaderView = [self createHeadImage];
    [table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

-(void)reloadPack
{
    [moneyLabel setText:[NSString stringWithFormat:@"¥%@",money]];
//    [coinLabel setText:[NSString stringWithFormat:@"+%@钻石", [SelfPersonInfo getInstance].lastCoin]];
}


-(UIImageView *)createHeadImage
{
    UIImageView *headView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 204)];
    [headView setBackgroundColor:getUIColor(Color_black)];
    [headView setUserInteractionEnabled:YES];
    [headView setImage:[UIImage imageNamed:@"headBackCard"]];
    
    
    UIButton *buttonBack = [UIButton new];
    [headView addSubview:buttonBack];
    buttonBack.sd_layout
    .leftSpaceToView(headView, 10)
    .topSpaceToView(headView, 24)
    .heightIs(24)
    .widthIs(24);
    [buttonBack setBackgroundImage:[UIImage imageNamed:@"mine_back"] forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleMoney = [UILabel new];
    [headView addSubview:titleMoney];
    titleMoney.sd_layout
    .leftSpaceToView(headView, 12)
    .topSpaceToView(headView, 70)
    .heightIs(20)
    .widthIs(200);
    [headView addSubview:titleMoney];
    [titleMoney setText:@"账户余额（元）"];
    [titleMoney setFont:[UIFont systemFontOfSize:13]];
    [titleMoney setTextColor:[UIColor whiteColor]];
    
    
    moneyLabel = [UILabel new];
    [headView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left).with.offset(12);
        make.top.equalTo(titleMoney.mas_bottom).with.offset(20);
        make.height.equalTo(@60);
    }];
    
    [moneyLabel setFont:[UIFont systemFontOfSize:55]];
    [moneyLabel setTextColor:[UIColor whiteColor]];
    
    
    
    
    coinLabel = [UILabel new];
    [headView addSubview:coinLabel];
    [coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel.mas_right).with.offset(5);
        make.top.equalTo(titleMoney.mas_top).with.offset(75);
        make.height.equalTo(@20);
        make.right.lessThanOrEqualTo(headView.mas_right).with.offset(-12);
    }];
    [coinLabel setFont:[UIFont systemFontOfSize:14]];
    [coinLabel setTextColor:Color_white];
    
    
    return headView;
    
}


-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 30;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [view setBackgroundColor:Color_blackBack];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH - 12, 30)];
    [label setText:@"每日营业额"];
    [label setFont:[UIFont systemFontOfSize:14]];
    [label setTextColor:[UIColor whiteColor]];
    [view addSubview:label];
    
    
    return view;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"pack";
    //定义cell的复用性当处理大量数据时减少内存开销
    packTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[packTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    orderModel *model = modelArray[indexPath.row];
    cell.model = model;
    
    [cell setBackgroundColor:getUIColor(Color_black)];
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
