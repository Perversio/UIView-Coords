@import UIKit;

@interface UIView (extension)

- (UIView *) findFirstResponder;

- (void) setError: (BOOL) flag;

- (void) removeFromSuperviewAnimated:(BOOL)animated;

- (UIImage *) snapshot;

- (void) bounce;
- (void) fadeOut:(NSTimeInterval) duration;
- (void) fadeIn:(NSTimeInterval) duration;
- (void) fadeIn;

- (NSLayoutConstraint*) addConstraintWithItem:(id) item attribute:(NSLayoutAttribute) attr shift:(CGFloat) shift;
- (void) addSizeConstraint:(CGSize) size;

- (NSLayoutConstraint*) addHeightConstraint:(CGFloat) height;
- (NSLayoutConstraint*) addWidthConstraint:(CGFloat) width;

- (void) removeConstraintsWithItems:(NSArray*) items;
- (void) removeConstraintsWithAttribute:(NSLayoutAttribute) attr;
- (void) removeSizeConstraints;

- (void) transformScale:(CGFloat) scale duration:(NSTimeInterval) duration;
- (void) transformScaleAnimated:(CGFloat) scale;

- (void) transformIdentityWithDuration:(NSTimeInterval) duration;
- (void) transformIdentityAnimated;

- (CAShapeLayer*) addCircleLayerWithSize:(CGFloat)size fillColor:(UIColor*) fill strokeColor:(UIColor*) stroke;

@end

@interface UIView (Coords)

+ (void) arrangeViewsByOriginX:(NSArray*) views withGap:(CGFloat) gap;
+ (void) arrangeViewsByEdgeX:(NSArray*) views withGap:(CGFloat) gap;

- (void) mirrorPosition;

- (CGSize) kSize;
- (CGPoint) origin;
- (CGFloat) originX;
- (CGFloat) originY;
- (CGFloat) width;
- (CGFloat) height;
- (CGFloat) edgeX;
- (CGFloat) edgeY;

- (void) fitHeight;
- (void) setKSize:(CGSize) size;
- (void) scale:(CGFloat) scale;

- (void) setOrigin:(CGPoint) origin;
- (void) setOriginX:(CGFloat) x;
- (void) setOriginY:(CGFloat) y;
- (void) setWidth:(CGFloat) width;
- (void) setHeight:(CGFloat) height;
- (void) setEdgeX:(CGFloat) edgeX;
- (void) setEdgeY:(CGFloat) edgeY;
- (void) strechEdgeX:(CGFloat) edgeX;
- (void) strechEdgeY:(CGFloat) edgeY;

- (void) copyCenter:(UIView*) source;
- (void) copyCenterX:(UIView*) source;
- (void) copyCenterY:(UIView*) source;

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

- (void) markSubviewsRandom;
- (void) markRed;
- (void) markGreen;
- (void) markRandom;

- (void) hide;
- (void) hideAnimated:(NSTimeInterval)duration;
- (void) unhide;
- (void) unhideAnimated:(NSTimeInterval)duration;

- (void) addSubviewsPack:(NSArray *)views;

- (void) removeAllSubviewsExcluding:(NSArray*) exclude;
- (void) removeAllSubviews;

- (void) hideSubviewsExcluding:(UIView*) exclude animate:(NSTimeInterval) duration;
- (void) hideSubviewsAnimate:(NSTimeInterval) duration;

- (void) hideSubviewsExcluding:(UIView*) exclude;
- (void) hideSubviews;

- (void) unhideSubviewsExcluding:(UIView*) exclude animate:(NSTimeInterval) duration;
- (void) unhideSubviewsAnimate:(NSTimeInterval) duration;

- (void) unhideSubviewsExcluding:(UIView*) exclude;
- (void) unhideSubviews;

- (id) getSuperviewTop;
- (id) getSubviewWithClassRecursive:(Class) ofClass;
- (id) getSubviewWithClass:(Class) ofClass;
- (id) getSuperviewOfClass:(Class) ofClass;

- (BOOL) containsPoint:(CGPoint) point;

@end

@interface UIView (Layer)

- (UIColor *) borderColor;
- (void) setBorderColor:(UIColor *)color;

- (CGFloat) borderWidth;
- (void) setBorderWidth:(CGFloat)width;

- (CGFloat) cornerRadius;
- (void) setCornerRadius:(CGFloat)radius;

@end
