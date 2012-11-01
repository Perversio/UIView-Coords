//
//  UIView+Coords.h
//
//  Created by Sergey Lukianov on 04.07.12.
//  Copyright (c) 2012 Sergey Lukianov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Coords)

- (CGSize) size;
- (CGPoint) origin;
- (CGFloat) originX;
- (CGFloat) originY;
- (CGFloat) width;
- (CGFloat) height;

- (void) setSize:(CGSize) size;
- (void) setOrigin:(CGPoint) origin;
- (void) setOriginX:(CGFloat) x;
- (void) setOriginY:(CGFloat) y;
- (void) setWidth:(CGFloat) width;
- (void) setHeight:(CGFloat) height;

- (CGFloat) centerX;
- (CGFloat) centerY;

- (void) centrate;
- (void) centrateX;
- (void) centrateY;
- (void) setCenterX:(CGFloat) x;
- (void) setCenterY:(CGFloat) y;

- (void) normalize;

- (void) shiftX:(CGFloat) shiftX;
- (void) shiftY:(CGFloat) shiftY;

- (void) becomeFrontView;
- (void) becomeBackView;

- (void) markRed;
- (void) markGreen;

@end
