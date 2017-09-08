//
//  packTableViewCell.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/9/7.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "packTableViewCell.h"

@implementation packTableViewCell
{
    UILabel *timeLabel;
    UILabel *moneyLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}


-(void)setUp
{
    UIView *contentView = self.contentView;
    UIImageView *orderMoneyBack = [UIImageView new];
    [contentView addSubview:orderMoneyBack];
    
    orderMoneyBack.sd_layout
    .leftSpaceToView(contentView, 12)
    .rightSpaceToView(contentView, 12)
    .topSpaceToView(contentView, 12)
    .bottomSpaceToView(contentView, 12);
    [orderMoneyBack setImage:[UIImage imageNamed:@"ShakeBackView"]];
    

    timeLabel = [UILabel new];
    [orderMoneyBack addSubview:timeLabel];
    timeLabel.sd_layout
    .leftSpaceToView(orderMoneyBack, 10)
    .centerYEqualToView(orderMoneyBack)
    .heightIs(30)
    .widthIs(100);
    [timeLabel setTextColor:Color_white];
    [timeLabel setFont:[UIFont systemFontOfSize:16]];
    
    
    moneyLabel = [UILabel new];
    [orderMoneyBack addSubview:moneyLabel];
    moneyLabel.sd_layout
    .rightSpaceToView(orderMoneyBack, 10)
    .centerYEqualToView(orderMoneyBack)
    .heightIs(30)
    .widthIs(100);
    [moneyLabel setTextColor:[UIColor whiteColor]];
    [moneyLabel setFont:[UIFont systemFontOfSize:16]];
    [moneyLabel setTextAlignment:NSTextAlignmentRight];
    
    
    
    
    
}

-(void)setModel:(orderModel *)model
{
    _model = model;
    [timeLabel setText:model.orderTime];
    [moneyLabel setText:[NSString stringWithFormat:@"金额:%@",model.payMoney]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
