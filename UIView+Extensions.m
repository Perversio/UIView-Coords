#import "UIView+Extensions.h"
#import "Helper.h"

@implementation UIView (extension)

- (UIView *) findFirstResponder{
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
	UIGraphicsBeginImageContextWithOptions(self.kSize, YES, [UIScreen mainScreen].scale);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

- (NSLayoutConstraint*) addConstraintWithItem:(id) item attribute:(NSLayoutAttribute) attr shift:(CGFloat) shift{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:item
															  attribute:attr
															  relatedBy:NSLayoutRelationEqual
																 toItem:self
															  attribute:attr
															 multiplier:1
															   constant:shift];
	[self addConstraint:result];
	return result;
}

- (NSLayoutConstraint*) addHeightConstraint:(CGFloat) height{
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self
															  attribute:NSLayoutAttributeHeight
															  relatedBy:NSLayoutRelationEqual
																 toItem:nil
															  attribute:NSLayoutAttributeNotAnAttribute
															 multiplier:1
															   constant:height];
	[self addConstraint:result];
	return result;
}

- (NSLayoutConstraint*) addWidthConstraint:(CGFloat) width{
	[self removeConstraintsWithAttribute:NSLayoutAttributeWidth];
	NSLayoutConstraint *result = [NSLayoutConstraint constraintWithItem:self
															  attribute:NSLayoutAttributeWidth
															  relatedBy:NSLayoutRelationEqual
																 toItem:nil
															  attribute:NSLayoutAttributeNotAnAttribute
															 multiplier:1
															   constant:width];
	[self addConstraint:result];
	return result;
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

- (void) removeFromSuperviewAnimated:(BOOL)animated{
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

- (void) bounce{
	self.transform = CGAffineTransformMakeScale(0.6, 0.6);

	[UIView
	 animateWithDuration: 0.2
	 animations: ^(void){
		self.transform = CGAffineTransformMakeScale(1.1, 1.1);
	}
	 completion: ^(BOOL finished){
		[UIView
		 animateWithDuration: 1.0 / 15.0
		 animations: ^(void){
			self.transform = CGAffineTransformMakeScale(0.9, 0.9);
		}
		 completion: ^(BOOL finished){
			[UIView
			 animateWithDuration: 1.0 / 7.5
			 animations: ^(void){
				self.transform = CGAffineTransformIdentity;
			}];
		}];
	}];
}

- (void) fadeOut:(NSTimeInterval) duration{
	[UIView animateWithDuration:duration
						  delay:0
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
		self.alpha = 0;
	}
					 completion:nil];
}

- (void) fadeIn:(NSTimeInterval) duration{
	self.alpha = 0;
	[UIView
	 animateWithDuration: duration
	 animations: ^(void){
		self.alpha = 1.0;
	}];
}

- (void) fadeIn{
	[self fadeIn:0.2];
}

- (void) transformScale:(CGFloat) scale duration:(NSTimeInterval) duration{
	[UIView animateWithDuration:duration
					 animations:^{
		self.transform = CGAffineTransformMakeScale(scale, scale);
	}];
}
- (void) transformScaleAnimated:(CGFloat) scale{
	[self transformScale:scale duration:0.2];
}

- (void) transformIdentityWithDuration:(NSTimeInterval) duration{
	[UIView animateWithDuration:duration
					 animations:^{
		self.transform = CGAffineTransformIdentity;
	}];
}
- (void) transformIdentityAnimated{
	[self transformIdentityWithDuration:0.2];
}

- (CAShapeLayer*) addCircleLayerWithSize:(CGFloat)size fillColor:(UIColor*) fill strokeColor:(UIColor*) stroke{
	CAShapeLayer *result = [[CAShapeLayer alloc] init];
	result.frame = CGRectMake(0, 0, size, size);

	result.lineWidth = 1;
	result.fillColor = fill.CGColor;
	result.strokeColor = stroke.CGColor;

	CGPathRef path = CGPathCreateWithEllipseInRect(CGRectMake(0, 0, size, size),
												   NULL);

	result.path = path;

	CGPathRelease(path);

	[self.layer addSublayer:result];

	return result;
}

@end

#pragma mark coordinate related

@implementation UIView (Coords)

+ (void) arrangeViewsByOriginX:(NSArray*) views withGap:(CGFloat) gap{
	CGFloat origin = 0;
	for (UIView *v in views) {
		if (origin != 0) {
			v.originX = origin;
		}
		origin = v.edgeX + gap;
	}
}

+ (void) arrangeViewsByEdgeX:(NSArray*) views withGap:(CGFloat) gap{
	CGFloat origin = 0;
	for (UIView *v in views.reverseObjectEnumerator) {
		if (v.alpha == 0 || v.isHidden) {
			continue;;
		}
		if (origin != 0) {
			v.edgeX = origin;
		}
		origin = v.originX - gap;
	}
}

- (void) mirrorPosition{
	self.frame = CGRectMake(self.superview.width - self.originX - self.width, self.originY, self.width, self.height);
}


- (CGSize) kSize{
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
	return self.frame.size.width;
}

- (CGFloat) height{
	return self.frame.size.height;
}

- (CGFloat) edgeX{
	return self.originX + self.width;
}

- (CGFloat) edgeY{
	return self.originY + self.height;
}

- (void) scale:(CGFloat) scale{
	self.kSize = CGSizeMake(self.width * scale, self.height * scale);
}

- (void) fitHeight{
	CGFloat maxY = 0;
	for (UIView *v in self.subviews) {
		CGFloat y = v.edgeY;
		if (y > maxY) {
			maxY = y;
		}
	}
	self.height = maxY;
}

- (void) setKSize:(CGSize) size{
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
	if (isnan(width)) {
		return;
	}
	CGRect frame = self.frame;
	frame.size.width = width;
	[self setFrame:frame];
}

- (void) setHeight:(CGFloat) height{
	if (isnan(height)) {
		return;
	}
	CGRect frame = self.frame;
	frame.size.height = height;
	[self setFrame:frame];
}

- (void) setEdgeX:(CGFloat)edgeX{
	self.originX += (edgeX - self.edgeX);
}

- (void) setEdgeY:(CGFloat)edgeY{
	self.originY += (edgeY - self.edgeY);
}

- (void) strechEdgeX:(CGFloat)edgeX{
	self.width += (edgeX - self.edgeX);
}

- (void) strechEdgeY:(CGFloat)edgeY{
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

- (void) copyCenter:(UIView*) source{
	self.center = source.center;
}

- (void) copyCenterX:(UIView*) source{
	self.centerX = source.centerX;
}

- (void) copyCenterY:(UIView*) source{
	self.centerY = source.centerY;
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
	frame.origin.x = roundf((isnan(frame.origin.x))?0:frame.origin.x);
	frame.origin.y = roundf((isnan(frame.origin.y))?0:frame.origin.y);
	frame.size.width = roundf((isnan(frame.size.width))?0:frame.size.width);
	frame.size.height = roundf((isnan(frame.size.height))?0:frame.size.height);
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
	if (self.superview) {
		[self.superview bringSubviewToFront:self];
	}
}

- (void) becomeBackView{
	if (self.superview) {
		[self.superview sendSubviewToBack:self];
	}
}

#pragma mark misc

- (void) markSubviewsRandom{
	[self.subviews makeObjectsPerformSelector:@selector(markRandom)];
}

- (void) markWithColor:(UIColor*) color{
	[Helper executeProduction:nil debug:^{
		self.backgroundColor = [color colorWithAlphaComponent:0.3];
		[self addBorderWithColor:color andWidth:1];
	}];
}

- (void) markRed{
	[self markWithColor:UIColor.redColor];
}

- (void) markGreen{
	[self markWithColor:UIColor.greenColor];
}

- (void) markRandom{
	CGFloat red     = arc4random()%255 / 255.0f;
	CGFloat green   = arc4random()%255 / 255.0f;
	CGFloat blue    = arc4random()%255 / 255.0f;
	[self markWithColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]];
}

- (void) addBorderWithColor:(UIColor *)color andWidth:(CGFloat)width{
	[self.layer setBorderColor:color.CGColor];
	[self.layer setBorderWidth:width];
}

- (void) hide{
	self.hidden = YES;
}

- (void) hideAnimated:(NSTimeInterval)duration{
	[UIView animateWithDuration:duration animations:^{
		self.alpha = 0.0;
	}
					 completion:^(BOOL finished) {
		[self hide];
	}];
}

- (void) unhide{
	self.hidden = NO;
}

- (void) unhideAnimated:(NSTimeInterval)duration{
	[self unhide];
	[UIView animateWithDuration:duration animations:^{
		self.alpha = 1.0;
	}];
}

- (void) addSubviewsPack:(NSArray *)views{
	for (UIView *v in views) {
		[self addSubview:v];
	}
}

- (void) removeAllSubviewsExcluding:(NSArray*) exclude{
	for (UIView *v in self.subviews) {
		if (![exclude containsObject:v]) {
			[v removeFromSuperview];
		}
	}
}

- (void) removeAllSubviews{
	[self removeAllSubviewsExcluding:nil];
}

- (void) hideSubviewsExcluding:(UIView*) exclude animate:(NSTimeInterval) duration{
	if (duration != 0) {
		[UIView animateWithDuration:duration
						 animations:^{
			for (UIView *view in self.subviews) {
				if (view != exclude) {
					view.alpha = 0;
				}
			}
		}
						 completion:^(BOOL finished) {
			for (UIView *view in self.subviews) {
				if (view != exclude) {
					view.hidden = YES;
				}
			}
		}];
	}else{
		for (UIView *view in self.subviews) {
			if (view != exclude) {
				view.hidden = YES;
			}
		}
	}
}
- (void) hideSubviewsAnimate:(NSTimeInterval) duration{
	[self hideSubviewsExcluding:nil animate:duration];
}

- (void) hideSubviewsExcluding:(UIView*) exclude{
	[self hideSubviewsExcluding:exclude animate:0];
}
- (void) hideSubviews{
	[self hideSubviewsExcluding:nil];
}

- (void) unhideSubviewsExcluding:(UIView*) exclude animate:(NSTimeInterval) duration{
	for (UIView *view in self.subviews) {
		if (view != exclude) {
			view.hidden = NO;
		}
	}
	if (duration != 0) {
		[UIView animateWithDuration:duration
						 animations:^{
			for (UIView *view in self.subviews) {
				if (view != exclude) {
					view.alpha = 1;
				}
			}
		}];
	}
}

- (void) unhideSubviewsAnimate:(NSTimeInterval) duration{
	[self unhideSubviewsExcluding:nil animate:duration];
}

- (void) unhideSubviewsExcluding:(UIView*) exclude{
	[self unhideSubviewsExcluding:exclude animate:0];
}

- (void) unhideSubviews{
	[self unhideSubviewsExcluding:nil];
}

- (id) getSuperviewTop{
	if ([self.superview isKindOfClass:[UIWindow class]]) {
		return self;
	}
	if (!self.superview) {
		return self;
	}
	return [self.superview getSuperviewTop];
}

- (id) getSubviewWithClassRecursive:(Class) ofClass{
	id result = nil;
	if (self.subviews.count != 0) {
		for (UIView *v in self.subviews) {
			if ([v isKindOfClass:ofClass]) {
				result = v;
				break;
			}
			result = [v getSubviewWithClassRecursive:ofClass];
			if (result) {
				break;
			}
		}
	}

	return result;
}

- (id) getSubviewWithClass:(Class) ofClass{
	id result = nil;
	if (self.subviews.count != 0) {
		for (UIView *v in self.subviews) {
			if ([v isKindOfClass:ofClass]) {
				result = v;
				break;
			}
		}
	}

	return result;
}

- (id) getSuperviewOfClass:(Class) ofClass{
	if (!self.superview) {
		return nil;
	}
	if ([self.superview isMemberOfClass:ofClass]) {
		return self.superview;
	}
	return [self.superview getSuperviewOfClass:ofClass];
}

- (BOOL) containsPoint:(CGPoint) point{
	return CGRectContainsPoint(self.frame, point);
}

@end

@implementation UIView (Layer)

- (UIColor *) borderColor{
	return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void) setBorderColor:(UIColor *)color{
	[self.layer setBorderColor:color.CGColor];
}

- (CGFloat) borderWidth{
	return self.layer.borderWidth;
}

- (void) setBorderWidth:(CGFloat)width{
	[self.layer setBorderWidth:width];
}

- (CGFloat) cornerRadius{
	return self.layer.cornerRadius;
}

- (void) setCornerRadius:(CGFloat)radius{
	[self.layer setCornerRadius:radius];
}

@end
