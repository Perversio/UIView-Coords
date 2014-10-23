#import "UIView+Extensions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (extension)

- (UIView *)findFirstResponder{
	if ([self isFirstResponder]) {
		return self;
	}
	
	for (UIView *subview in [self subviews]) {
		UIView *firstResponder = [subview findFirstResponder];
		if (nil != firstResponder) {
			return firstResponder;
		}
	}
	
	return nil;
}

- (UIImage *) snapshot{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (void) addConstraintWithItem:(id) item attribute:(NSLayoutAttribute) attr shift:(CGFloat) shift{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item
                                                     attribute:attr
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:attr
                                                    multiplier:1
                                                      constant:shift]];
}

- (void) addHeightConstraint:(CGFloat) height{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:height]];
}

- (void) addWidthConstraint:(CGFloat) width{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:width]];
}

- (void) addSizeConstraint:(CGSize) size{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:size.width]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1
                                                      constant:size.height]];
}

- (void) removeSizeConstraints{
    [self removeConstraintsWithAttribute:NSLayoutAttributeHeight];
    [self removeConstraintsWithAttribute:NSLayoutAttributeWidth];
}

- (void) removeConstraintsWithItems:(NSArray*) items{
    NSMutableArray *toRemove = [NSMutableArray array];
    [self.constraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *obj, NSUInteger idx, BOOL *stop) {
        if ([items containsObject:obj.secondItem] || [items containsObject:obj.firstItem]) {
            [toRemove addObject:obj];
        }
    }];
    [self removeConstraints:toRemove];
}

- (void) removeConstraintsWithAttribute:(NSLayoutAttribute) attr{
    NSMutableArray *toRemove = [NSMutableArray array];
    
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == attr || c.secondAttribute == attr) {
            [toRemove addObject:c];
        }
    }
    
    [self removeConstraints:toRemove];
}

- (void) setError:(BOOL)flag{
    if(flag){
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1.2;
        if([self isMemberOfClass: [UITextField class]]){
            self.layer.cornerRadius = 6;
        }
    } else {
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0;
        if([self isMemberOfClass: [UITextField class]]){
            self.layer.cornerRadius = 0;
        }
    }
}

- (void) removeFromSuperviewAnimated:(BOOL)animated
{
    if (!animated) {
        [self removeFromSuperview];
    }
    else {
        [UIView animateWithDuration:0.2
                         animations: ^{
                             self.alpha = 0.0;
                         }
                         completion: ^(BOOL finished){
                             if (finished) {
                                 [self removeFromSuperview];
                             }
                         }];
    }
}

- (void) setOriginX: (float) x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void) setOriginY: (float) y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void) setSizeWidth: (float) w {
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}

- (void) setSizeHeight: (float) h {
    CGRect rect = self.frame;
    rect.size.height = h;
    self.frame = rect;
}

- (void) setPosition: (CGPoint) pt {
    CGRect rect = self.frame;
    rect.origin.x = pt.x;
    rect.origin.y = pt.y;
    self.frame = rect;
}

- (void)mirrorPosition
{
    self.frame = CGRectMake(self.superview.width - self.originX - self.width, self.originY, self.width, self.height);
}

- (void)centerInsideSuperview
{
    CGRect f = self.frame;
    
    f.origin.x = (self.superview.width  - f.size.width)  / 2.0;
    f.origin.y = (self.superview.height - f.size.height) / 2.0;
    
    self.frame = f;
}

- (void)centerHorizontallyInsideSuperview
{
    CGRect f = self.frame;
    
    f.origin.x = (self.superview.width  - f.size.width)  / 2.0;
    
    self.frame = f;
}

- (void)setPosition:(CGPoint)position fromOrigin:(ORIGIN)origin
{
    CGRect f = self.frame;
    
    switch (origin)
    {
        case kTopLeft:
            f.origin.x = position.x;
            f.origin.y = position.y;
            break;
            
        case kTopRight:
            f.origin.x = self.superview.width  - position.x - f.size.width;
            f.origin.y = position.y;
            break;
            
        case kTopCenter:
            f.origin.x = (self.superview.width  - f.size.width) / 2.0;
            f.origin.y = position.y;
            break;

        case kBottomLeft:
            f.origin.x = position.x;
            f.origin.y = self.superview.height - position.y - f.size.height;
            break;
            
        case kBottomRight:
            f.origin.x = self.superview.width  - position.x - f.size.width;
            f.origin.y = self.superview.height - position.y - f.size.height;
            break;

        case kBottomCenter:
            f.origin.x = (self.superview.width  - f.size.width) / 2.0;
            f.origin.y = self.superview.height - position.y - f.size.height;
            break;
    }
    
    self.frame = f;
}

- (void)bounce
{
    self.transform = CGAffineTransformMakeScale(0.6, 0.6);
    
	[UIView
     animateWithDuration: 0.2
     animations: ^(void)
     {
         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
     }
     completion: ^(BOOL finished)
     {
         [UIView
          animateWithDuration: 1.0 / 15.0
          animations: ^(void)
          {
              self.transform = CGAffineTransformMakeScale(0.9, 0.9);
          }
          completion: ^(BOOL finished)
          {
              [UIView
               animateWithDuration: 1.0 / 7.5
               animations: ^(void)
               {
                   self.transform = CGAffineTransformIdentity;
               }];
          }];
     }];
}

- (void)fadeOut:(NSTimeInterval) duration{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:nil];
}

- (void)fadeIn:(NSTimeInterval) duration{
    self.alpha = 0;
    [UIView
     animateWithDuration: duration
     animations: ^(void){
         self.alpha = 1.0;
     }];
}

- (void)fadeIn
{
    [self fadeIn:0.2];
}

@end

#pragma mark coordinate related

@implementation UIView (Coords)

- (CGSize) size{
    return self.frame.size;
}

- (CGPoint) origin{
    return self.frame.origin;
}

- (CGFloat) originX{
    return self.origin.x;
}

- (CGFloat) originY{
    return self.origin.y;
}

- (CGFloat) width{
    return self.size.width;
}

- (CGFloat) height{
    return self.size.height;
}

- (CGFloat)edgeX
{
    return self.originX + self.width;
}

- (CGFloat)edgeY
{
    return self.originY + self.height;
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

- (void)setEdgeX:(CGFloat)edgeX
{
    self.originX += (edgeX - self.edgeX);
}

- (void)setEdgeY:(CGFloat)edgeY
{
    self.originY += (edgeY - self.edgeY);
}

- (void)strechEdgeX:(CGFloat)edgeX
{
    self.width += (edgeX - self.edgeX);
}

- (void)strechEdgeY:(CGFloat)edgeY
{
    self.height += (edgeY - self.edgeY);
}

- (void) centrate{
    CGSize size = self.superview.frame.size;
    CGPoint center = self.center;
    center.x = roundf(size.width/2);
    center.y = roundf(size.height/2);
    [self setCenter:center];
}

- (void) centrateX{
    CGFloat width = self.superview.width;
    CGPoint center = self.center;
    center.x = roundf(width/2);
    [self setCenter:center];
}

- (void) centrateY{
    CGFloat height = self.superview.height;
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

- (void) markRandom{
    CGFloat red     = arc4random()%254 / 255.0f;
    CGFloat green   = arc4random()%254 / 255.0f;
    CGFloat blue    = arc4random()%254 / 255.0f;
    [self setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:0.3]];
    [self.layer setBorderColor:[UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor];
    [self.layer setBorderWidth:1];
}

- (void) addBorderWithColor:(UIColor *)color andWidth:(CGFloat)width
{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

- (void)hide
{
    self.hidden = YES;
}

- (void)hideAnimated:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0.0;
    }
                     completion:^(BOOL finished) {
                         [self hide];
                     }];
}

- (void)unhide
{
    self.hidden = NO;
}

- (void)unhideAnimated:(NSTimeInterval)duration
{
    [self unhide];
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.0;
    }];
}

@end

@implementation UIView (Layer)

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)color
{
    [self.layer setBorderColor:color.CGColor];
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)width
{
    [self.layer setBorderWidth:width];
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
}

@end
