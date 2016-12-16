
//
//  ExpandCell.m
//  ExpandTableView
//
//  Created by 郑文明 on 16/1/8.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "ExpandCell.h"
#import "UIView+XYXExtension.h"

@implementation ExpandCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.contentView.backgroundColor = [UIColor whiteColor];

}
    return self;
}
//子控件的位置,大小
-(void)layoutSubviews{
    [super layoutSubviews];
     self.textLabel.xyx_x = 10;
}

//-(void)setSelected:(BOOL)selected{
//
//    [super setSelected:selected];
//    if (selected == NO) {
//        self.textLabel.textColor = [UIColor blackColor];
//        selected = YES;
//    }else{
//        self.textLabel.textColor = [UIColor orangeColor];
//        selected = NO;
//
//    }
//}


@end
