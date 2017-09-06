//
//  JCFlipPage.m
//  JCFlipPageView
//
//  Created by ThreegeneDev on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import "JCFlipPage.h"

@implementation JCFlipPage
{
    UIImageView *ImageBack;
    UILabel *userName;
    UIButton *placeButton;
    UILabel *descriptContent;
    UIImageView *headImage;
}
@synthesize reuseIdentifier = _reuseIdentifier;

- (void)dealloc
{
}

- (void)prepareForReuse
{
    
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _reuseIdentifier = reuseIdentifier;
        
#warning ! a temp label
        
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    UIView *contentView = self;
    ImageBack = [UIImageView new];
    [contentView addSubview:ImageBack];
    
    
    ImageBack.sd_layout
    .leftEqualToView(contentView)
    .topSpaceToView(contentView, 60)
    .rightEqualToView(contentView)
    .bottomSpaceToView(contentView, 50);
    
    //    AlphaColthesAndDesginer
    

    
    headImage = [UIImageView new];
    [contentView addSubview:headImage];
    headImage.sd_layout
    .leftSpaceToView(contentView, 10)
    .topSpaceToView(contentView, 10)
    .heightIs(40)
    .widthIs(40);
    [headImage.layer setCornerRadius:20];
    [headImage.layer setMasksToBounds:YES];
    
    
    userName = [UILabel new];
    [contentView addSubview:userName];
    [userName setTextAlignment:NSTextAlignmentLeft];
    userName.sd_layout
    .leftSpaceToView(headImage,12)
    .topEqualToView(headImage)
    .widthIs(200)
    .heightIs(20);
    [userName setTextColor:[UIColor whiteColor]];
    [userName setFont:[UIFont systemFontOfSize:16]];
    
    
    placeButton = [UIButton new];
    [contentView addSubview:placeButton];
    
    placeButton.sd_layout
    .leftSpaceToView(headImage,12)
    .topSpaceToView(userName, 0)
    .widthIs(55)
    .heightIs(20);
    placeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;    
    [placeButton.titleLabel setFont:[UIFont systemFontOfSize:16]];

    descriptContent = [UILabel new];
    [contentView addSubview:descriptContent];
    descriptContent.sd_layout
    .centerXEqualToView(contentView)
    .bottomSpaceToView(contentView, 60)
    .leftSpaceToView(contentView, 40)
    .rightSpaceToView(contentView, 40)
    .autoHeightRatio(0);
    //    [descript setNumberOfLines:2];
    [descriptContent setFont:[UIFont systemFontOfSize:14]];
    [descriptContent setTextColor:[UIColor whiteColor]];
    [descriptContent setTextAlignment:NSTextAlignmentCenter];
    [descriptContent setNumberOfLines:0];
    //    [descript setShadowColor:[UIColor blackColor]];
    
    
    _like = [UIButton new];
    [contentView addSubview:_like];
    _like.sd_layout
    .leftSpaceToView(contentView, 40)
    .topSpaceToView(ImageBack, 10)
    .heightIs(40)
    .widthIs(60);
    [_like setImage:[UIImage imageNamed:@"Like"] forState:UIControlStateNormal];
    [_like setTitle:@"赞" forState:UIControlStateNormal];
    [_like.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_like setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_like setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    
    
    _commend = [UIButton new];
    [contentView addSubview:_commend];
    _commend.sd_layout
    .centerXEqualToView(contentView)
    .topSpaceToView(ImageBack, 10)
    .heightIs(40)
    .widthIs(60);
    [_commend setImage:[UIImage imageNamed:@"commend"] forState:UIControlStateNormal];
    [_commend setTitle:@"评论" forState:UIControlStateNormal];
    [_commend.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_commend setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_commend setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    
    _share = [UIButton new];
    [contentView addSubview:_share];
    _share.sd_layout
    .rightSpaceToView(contentView, 40)
    .topSpaceToView(ImageBack, 10)
    .heightIs(40)
    .widthIs(60);
    [_share.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_share setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [_share setTitle:@"分享" forState:UIControlStateNormal];
    [_share setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_share setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 5)];
    
}



-(void)setModel:(withModel *)model
{
    _model = model;
//    [imageForClothes sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_HEADURL, model.clothesImage]]];
    [ImageBack setImage:[UIImage imageNamed:model.ImgUrl]];
    ImageBack.contentMode = UIViewContentModeScaleAspectFill;
    [headImage setImage:[UIImage imageNamed:model.headImage]];
    [userName setText:model.userName];
    [placeButton setTitle:model.PlaceName forState:UIControlStateNormal];
    [descriptContent setText:model.detailContent];
   
        
}


- (void)setReuseIdentifier:(NSString *)identifier
{
    _reuseIdentifier = identifier;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
