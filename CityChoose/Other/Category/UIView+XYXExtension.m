//
//  UIView+XYXExtension.m
//  Bsbdj
//
//  Created by monica on 16/9/18.
//  Copyright © 2016年 xyx. All rights reserved.
//

#import "UIView+XYXExtension.h"

@implementation UIView (XYXExtension)

-(CGSize)xyx_size{
    return self.frame.size;
}

-(void)setXyx_size:(CGSize)xyx_size{
    CGRect frame = self.frame;
    frame.size = xyx_size;
    self.frame = frame;
}

-(CGFloat)xyx_width{
    return self.frame.size.width;
}

-(CGFloat)xyx_height{
    return self.frame.size.height;
}

-(CGFloat)xyx_x{
    return self.frame.origin.x;
}

-(CGFloat)xyx_y{
    return self.frame.origin.y;
}

-(CGFloat)xyx_centerX{
    return self.center.x;
}

-(CGFloat)xyx_centerY{
    return self.center.y;
}


-(void)setXyx_width:(CGFloat)xyx_width{
    CGRect frame = self.frame;
    frame.size.width = xyx_width;
    self.frame = frame;
}

-(void)setXyx_height:(CGFloat)xyx_height{
    CGRect frame = self.frame;
    frame.size.height = xyx_height;
    self.frame = frame;
}

-(void)setXyx_x:(CGFloat)xyx_x{
    CGRect frame = self.frame;
    frame.origin.x = xyx_x;
    self.frame = frame;
}

-(void)setXyx_y:(CGFloat)xyx_y{
    CGRect frame = self.frame;
    frame.origin.y = xyx_y;
    self.frame = frame;
}

-(void)setXyx_centerX:(CGFloat)xyx_centerX{
    CGPoint center = self.center;
    center.x = xyx_centerX;
    self.center = center;

}

-(void)setXyx_centerY:(CGFloat)xyx_centerY{
    CGPoint center = self.center;
    center.y = xyx_centerY;
    self.center = center;
    
}

-(CGFloat)xyx_right{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)xyx_bottom{
    return CGRectGetMaxY(self.frame);
}

-(void)setXyx_right:(CGFloat)xyx_right{
    self.xyx_x = xyx_right - self.xyx_width;
}

-(void)setXyx_bottom:(CGFloat)xyx_bottom{
    self.xyx_y = xyx_bottom - self.xyx_height;
}


+(instancetype)xyx_viewFromXib{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

//判断两个view是否有重叠
-(BOOL)intersectWithView:(UIView *)view{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}



@end
