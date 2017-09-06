//
//  orderTableViewCell.m
//  NightDataApp
//
//  Created by 黄梦炜 on 2017/9/6.
//  Copyright © 2017年 黄梦炜. All rights reserved.
//

#import "orderTableViewCell.h"

@implementation orderTableViewCell

{
    UILabel *userName;
    UILabel *createTime;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self= [ super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUp];
        
    }
    return self;
}


-(void)setUp
{
    UIView *contentView  = self.contentView;
    
    UIImageView *backTicket = [UIImageView new];
    [contentView addSubview:backTicket];
    
    backTicket.sd_layout
    .leftSpaceToView(contentView, 12)
    .rightSpaceToView(contentView, 12)
    .topSpaceToView(contentView, 12)
    .bottomSpaceToView(contentView, 12);
    [backTicket setImage:[UIImage imageNamed:@"ShakeBackView"]];
    
    
    
    
    
    userName = [UILabel new];
    [backTicket addSubview:userName];
    userName.sd_layout
    .topSpaceToView(backTicket, 12)
    .leftSpaceToView(backTicket, 12)
    .heightIs(30)
    .widthIs(100);
    [userName setFont:[UIFont boldSystemFontOfSize:16]];
    [userName setTextColor:Color_white];
    
    
    createTime = [UILabel new];
    [backTicket addSubview:createTime];
    createTime.sd_layout
    .leftSpaceToView(backTicket, 12)
    .bottomSpaceToView(backTicket, 10)
    .heightIs(15)
    .rightSpaceToView(backTicket, 10);
    [createTime setFont:[UIFont systemFontOfSize:10]];
    [createTime setTextColor:Color_white];
    
    
    
    
    
    
    
    
}

-(void)setModel:(orderModel *)model
{
    _model = model;
    
    [userName setText:model.userName];
    [createTime setText:model.orderTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
