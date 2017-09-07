//
//  orderListViewController.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/9/6.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "orderListViewController.h"
#import "orderModel.h"
#import "orderTableViewCell.h"
@interface orderListViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation orderListViewController
{
    UITableView *carTable;
    NSMutableArray *modelArray;
    BaseDomain *getData;
    UILabel *acountLabel;
    NSString *countNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单列表";
    modelArray = [NSMutableArray array];
    getData = [BaseDomain getInstance:NO];
    [self.view setBackgroundColor:Color_blackBack];
    [self createData];
    [self createTable];
    // Do any additional setup after loading the view.
}


-(void)createData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [getData getData:URL_bar_order_list PostParams:params finish:^(BaseDomain *domain, Boolean success) {
        
        if ([self checkHttpResponseResultStatus:domain]) {
            
            countNum = [[domain.dataRoot objectForKey:@"list"] stringForKey:@"total"];
            
            for (NSDictionary *dic in [[domain.dataRoot objectForKey:@"list"] arrayForKey:@"data"]) {
                orderModel *model = [orderModel new];
                model.userId = [dic stringForKey:@"uid"];
                model.userName = [[dic dictionaryForKey:@"user"] stringForKey:@"name"];
                model.payMoney = [dic stringForKey:@"pay_money"];
                model.orderTime = [orderListViewController getFriendlyDateString:[dic integerForKey:@"create_time"]];
                
                
                
                [modelArray addObject:model];
            }
            [self reloadData];
            [carTable reloadData];
        }
        
    }];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}





-(void)createTable
{
    carTable = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH , SCREEN_HEIGHT ) style:UITableViewStyleGrouped];
    [carTable setBackgroundColor:Color_blackBack];
    carTable.delegate = self;
    carTable.dataSource = self;
    [carTable setTableHeaderView:[self createHeadImage]];
    [carTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:carTable];
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
    
   
    
    
    acountLabel = [UILabel new];
    [headView addSubview:acountLabel];
    [acountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left).with.offset(12);
        make.centerY.equalTo(headView.mas_centerY);
        make.height.equalTo(@60);
    }];
    
    [acountLabel setFont:[UIFont systemFontOfSize:25]];
    [acountLabel setTextColor:[UIColor whiteColor]];
    
    
    return headView;
    
}


-(void)reloadData
{
    [acountLabel setText:[NSString stringWithFormat:@"订单总量:%@",countNum]];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [modelArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =@"orderList";
    //定义cell的复用性当处理大量数据时减少内存开销
    orderTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[orderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    orderModel *model = modelArray[indexPath.section];
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
