

typedef enum
{
    kTopLeft,
    kTopRight,
    kBottomLeft,
    kBottomRight,

    kTopCenter,
    kBottomCenter,
}
ORIGIN;

@interface UIView (extension)

- (UIView *)findFirstResponder;

- (void) setError: (BOOL) flag;

- (void) removeFromSuperviewAnimated:(BOOL)animated;

- (void) setPosition: (CGPoint) pt;

- (void) setSizeWidth: (float) w;
- (void) setSizeHeight: (float) h;

- (UIImage *) snapshot;

- (void)mirrorPosition;
- (void)centerInsideSuperview;
- (void)centerHorizontallyInsideSuperview;
- (void)setPosition:(CGPoint)position fromOrigin:(ORIGIN)origin;

- (void)bounce;
- (void)fadeOut:(NSTimeInterval) duration;
- (void)fadeIn:(NSTimeInterval) duration;
- (void)fadeIn;

- (void) addConstraintWithItem:(id) item attribute:(NSLayoutAttribute) attr shift:(CGFloat) shift;
- (void) addSizeConstraint:(CGSize) size;

- (void) addHeightConstraint:(CGFloat) height;
- (void) addWidthConstraint:(CGFloat) width;

- (void) removeConstraintsWithItems:(NSArray*) items;
- (void) removeConstraintsWithAttribute:(NSLayoutAttribute) attr;
- (void) removeSizeConstraints;

@end

@interface UIView (Coords)

- (CGSize) size;
- (CGPoint) origin;
- (CGFloat) originX;
- (CGFloat) originY;
- (CGFloat) width;
- (CGFloat) height;
- (CGFloat) edgeX;
- (CGFloat) edgeY;

- (void) setSize:(CGSize) size;
- (void) setOrigin:(CGPoint) origin;
- (void) setOriginX:(CGFloat) x;
- (void) setOriginY:(CGFloat) y;
- (void) setWidth:(CGFloat) width;
- (void) setHeight:(CGFloat) height;
- (void) setEdgeX:(CGFloat) edgeX;
- (void) setEdgeY:(CGFloat) edgeY;
- (void) strechEdgeX:(CGFloat) edgeX;
- (void) strechEdgeY:(CGFloat) edgeY;

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
- (void) markRandom;

- (void) hide;
- (void)hideAnimated:(NSTimeInterval)duration;
- (void) unhide;
- (void)unhideAnimated:(NSTimeInterval)duration;

@end

@interface UIView (Layer)

- (UIColor *)borderColor;
- (void)setBorderColor:(UIColor *)color;

- (CGFloat)borderWidth;
- (void)setBorderWidth:(CGFloat)width;

- (CGFloat)cornerRadius;
- (void)setCornerRadius:(CGFloat)radius;

@end
