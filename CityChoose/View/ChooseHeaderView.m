//
//  ChooseHeaderView.m
//  CityChoose
//
//  Created by 亚杏 on 16/12/9.
//  Copyright © 2016年 oms. All rights reserved.
//

#import "ChooseHeaderView.h"

@implementation ChooseHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = XYXCommonBgColor;



    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // 在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = [UIFont systemFontOfSize:20];
    self.textLabel.textColor = [UIColor darkGrayColor];

    // 设置label的x值
    self.textLabel.xyx_x = XYXSmallMargin;
}


@end
