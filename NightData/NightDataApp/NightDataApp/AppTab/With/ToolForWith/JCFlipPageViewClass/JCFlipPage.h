//
//  JCFlipPage.h
//  JCFlipPageView
//
//  Created by ThreegeneDev on 14-8-8.
//  Copyright (c) 2014年 JimpleChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "withModel.h"
static NSString const* kJCFlipPageDefaultReusableIdentifier = @"kJCFlipPageDefaultReusableIdentifier";


@interface JCFlipPage : UIView
@property (nonatomic, retain) withModel *model;
@property (nonatomic, readonly, copy) NSString *reuseIdentifier;
@property (nonatomic, strong) UILabel *tempContentLabel;
@property (nonatomic, retain) UIButton *like;
@property (nonatomic, retain) UIButton *commend;
@property (nonatomic, retain) UIButton *share;


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier;
- (void)prepareForReuse;

- (void)setReuseIdentifier:(NSString *)identifier;


@end
