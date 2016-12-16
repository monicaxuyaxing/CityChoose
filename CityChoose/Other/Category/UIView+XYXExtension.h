//
//  UIView+XYXExtension.h
//  Bsbdj
//
//  Created by monica on 16/9/18.
//  Copyright © 2016年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYXExtension)

@property(nonatomic,assign) CGFloat xyx_width;
@property(nonatomic,assign) CGFloat xyx_height;
@property(nonatomic,assign) CGFloat xyx_x;
@property(nonatomic,assign) CGFloat xyx_y;
@property(nonatomic,assign) CGFloat xyx_centerX;
@property(nonatomic,assign) CGFloat xyx_centerY;

@property(nonatomic,assign) CGFloat xyx_right;
@property(nonatomic,assign) CGFloat xyx_bottom;
@property(nonatomic,assign) CGSize xyx_size;

+(instancetype)xyx_viewFromXib;
-(BOOL)intersectWithView:(UIView *)view;



@end
