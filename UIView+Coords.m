//
//  UIView+Coords.m
//
//  Created by Sergey Lukianov on 04.07.12.
//  Copyright (c) 2012 Sergey Lukianov. All rights reserved.
//

#import "UIView+Coords.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Coords)

#pragma mark coordinate related

- (CGSize) size{
    return self.frame.size;
}

- (CGPoint) origin{
    return self.frame.origin;
}

- (CGFloat) originX{
    return self.frame.origin.x;
}

- (CGFloat) originY{
    return self.frame.origin.y;
}

- (CGFloat) width{
    return self.frame.size.width;
}

- (CGFloat) height{
    return self.frame.size.height;
}

- (void) setSize:(CGSize) size{
    CGRect frame = self.frame;
    frame.size = size;
    [self setFrame:frame];
}

- (void) setOrigin:(CGPoint) origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    [self setFrame:frame];
}

- (void) setOriginX:(CGFloat) x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    [self setFrame:frame];
}

- (void) setOriginY:(CGFloat) y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    [self setFrame:frame];
}

- (void) setWidth:(CGFloat) width{
    CGRect frame = self.frame;
    frame.size.width = width;
    [self setFrame:frame];
}

- (void) setHeight:(CGFloat) height{
    CGRect frame = self.frame;
    frame.size.height = height;
    [self setFrame:frame];
}

- (void) centrate{
    CGSize size = self.superview.frame.size;
    CGPoint center = self.center;
    center.x = roundf(size.width/2);
    center.y = roundf(size.height/2);
    [self setCenter:center];
}

- (void) centrateX{
    CGFloat width = self.superview.frame.size.width;
    CGPoint center = self.center;
    center.x = roundf(width/2);
    [self setCenter:center];
}

- (void) centrateY{
    CGFloat height = self.superview.frame.size.height;
    CGPoint center = self.center;
    center.y = roundf(height/2);
    [self setCenter:center];
}

- (CGFloat) centerX{
    return self.center.x;
}

- (CGFloat) centerY{
    return self.center.y;
}

- (void) setCenterX:(CGFloat) x{
    CGPoint center = self.center;
    center.x = roundf(x);
    [self setCenter:center];
}

- (void) setCenterY:(CGFloat) y{
    CGPoint center = self.center;
    center.y = roundf(y);
    [self setCenter:center];
}

- (void) normalize{
    CGRect frame = self.frame;
    frame.origin.x = roundf(frame.origin.x);
    frame.origin.y = roundf(frame.origin.y);
    frame.size.width = roundf(frame.size.width);
    frame.size.height = roundf(frame.size.height);
    [self setFrame:frame];
}

#pragma mark shifts

- (void) shiftX:(CGFloat) shiftX{
    [self setOriginX:(self.originX + shiftX)];
}

- (void) shiftY:(CGFloat) shiftY{
    [self setOriginY:(self.originY + shiftY)];
}

#pragma mark layout related

- (void) becomeFrontView{
    [self.superview bringSubviewToFront:self];
}

- (void) becomeBackView{
    [self.superview sendSubviewToBack:self];
}

#pragma mark misc

- (void) markRed{
    [self setBackgroundColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:0.3]];
    [self.layer setBorderColor:[UIColor redColor].CGColor];
    [self.layer setBorderWidth:1];
}

- (void) markGreen{
    [self setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.3]];
    [self.layer setBorderColor:[UIColor greenColor].CGColor];
    [self.layer setBorderWidth:1];
}

@end
