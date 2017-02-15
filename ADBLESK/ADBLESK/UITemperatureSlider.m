//
//  UICircularSlider.m
//  UICircularSlider
//
//  Created by Zouhair Mahieddine on 02/03/12.
//  Copyright (c) 2012 Zouhair Mahieddine.
//  http://www.zedenem.com
//  
//  This file is part of the UICircularSlider Library, released under the MIT License.
//

#import "UITemperatureSlider.h"

@interface UITemperatureSlider()

@property (nonatomic) CGPoint thumbCenterPoint;

#pragma mark - Init and Setup methods
- (void)setup;

#pragma mark - Thumb management methods
- (BOOL)isPointInThumb:(CGPoint)point;

#pragma mark - Drawing methods
- (CGFloat)sliderRadius;
- (void)drawThumbAtPoint:(CGPoint)sliderButtonCenterPoint inContext:(CGContextRef)context;
- (CGPoint)drawCircularTrack:(float)track atPoint:(CGPoint)point withRadius:(CGFloat)radius inContext:(CGContextRef)context;
- (CGPoint)drawPieTrack:(float)track atPoint:(CGPoint)point withRadius:(CGFloat)radius inContext:(CGContextRef)context;



@end


#pragma mark -
@implementation UITemperatureSlider

@synthesize value = _value;
- (void)setValue:(float)value {
	if (value != _value) {
		if (value > self.maximumValue) { value = self.maximumValue; }
		if (value < self.minimumValue) { value = self.minimumValue; }
		_value = value;
		[self setNeedsDisplay];
        if (self.isContinuous) {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
	}
}
@synthesize minimumValue = _minimumValue;
- (void)setMinimumValue:(float)minimumValue {
	if (minimumValue != _minimumValue) {
		_minimumValue = minimumValue;
		if (self.maximumValue < self.minimumValue)	{ self.maximumValue = self.minimumValue; }
		if (self.value < self.minimumValue)			{ self.value = self.minimumValue; }
	}
}
@synthesize maximumValue = _maximumValue;
- (void)setMaximumValue:(float)maximumValue {
	if (maximumValue != _maximumValue) {
		_maximumValue = maximumValue;
		if (self.minimumValue > self.maximumValue)	{ self.minimumValue = self.maximumValue; }
		if (self.value > self.maximumValue)			{ self.value = self.maximumValue; }
	}
}

@synthesize minimumTrackTintColor = _minimumTrackTintColor;
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
	if (![minimumTrackTintColor isEqual:_minimumTrackTintColor]) {
		_minimumTrackTintColor = minimumTrackTintColor;
		[self setNeedsDisplay];
	}
}

@synthesize maximumTrackTintColor = _maximumTrackTintColor;
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
	if (![maximumTrackTintColor isEqual:_maximumTrackTintColor]) {
		_maximumTrackTintColor = maximumTrackTintColor;
		[self setNeedsDisplay];
	}
}

@synthesize thumbTintColor = _thumbTintColor;
- (void)setThumbTintColor:(UIColor *)thumbTintColor {
	if (![thumbTintColor isEqual:_thumbTintColor]) {
		_thumbTintColor = thumbTintColor;
		[self setNeedsDisplay];
	}
}
@synthesize continuous = _continuous;
@synthesize thumbCenterPoint = _thumbCenterPoint;
- (void)setTemSymbol:(temperatureSymbol)temSymbol {
    if (_temSymbol != temSymbol) {
        _temSymbol = temSymbol;
        [self setNeedsDisplay];
    }
}


/** @name Init and Setup methods */
#pragma mark - Init and Setup methods
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    } 
    return self;
}
- (void)awakeFromNib {
	[self setup];
}

- (void)setup {
	self.value = 0.0;
	self.minimumValue = 0.0;
	self.maximumValue = 1.0;
    self.minimumTrackTintColor = [UIColor colorWithRed:166/255.0 green:0/255.0 blue:30/255.0 alpha:1.0];
	self.maximumTrackTintColor = [UIColor colorWithRed:254/255.0 green:216/255.0 blue:130/255.0 alpha:1.0];
	self.thumbTintColor = [UIColor colorWithRed:166/255.0 green:0/255.0 blue:30/255.0 alpha:1.0];
	self.continuous = YES;
	self.thumbCenterPoint = CGPointZero;
	
    /**
     * This tapGesture isn't used yet but will allow to jump to a specific location in the circle
     */
	UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureHappened:)];
	[self addGestureRecognizer:tapGestureRecognizer];
	
	UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHappened:)];
	panGestureRecognizer.maximumNumberOfTouches = panGestureRecognizer.minimumNumberOfTouches;
	[self addGestureRecognizer:panGestureRecognizer];
}

/** @name Drawing methods */
#pragma mark - Drawing methods
#define kLineWidth self.bounds.size.width / 10
#define kThumbRadius self.bounds.size.width / 20
- (CGFloat)sliderRadius {
	CGFloat radius = MIN(self.bounds.size.width/2.5, self.bounds.size.height/2.5);
	radius -= MAX(kLineWidth, kThumbRadius);	
	return radius;
}
- (void)drawThumbAtPoint:(CGPoint)sliderButtonCenterPoint inContext:(CGContextRef)context {
	UIGraphicsPushContext(context);
	CGContextBeginPath(context);
	
	CGContextMoveToPoint(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y);
	CGContextAddArc(context, sliderButtonCenterPoint.x, sliderButtonCenterPoint.y, kThumbRadius, 0.0, 2*M_PI, NO);
	
	CGContextFillPath(context);
	UIGraphicsPopContext();
}

- (void)drawTextWithRadius:(CGFloat)radius sliderButtonCenterPoint:(CGPoint)sliderButtonCenterPoint inContext:(CGContextRef)context
{
    NSInteger startAngle = 240;
    CGFloat FontSize = self.bounds.size.width / 32;
    
    for (int i = 0; i < 18; i++) {
        
        UIGraphicsPushContext(context);
        CGContextBeginPath(context);
        NSString *str ;
        if (self.temSymbol == temperatureSymbolC) {
            str = [NSString stringWithFormat:@"%d",i*5];
        } else if (self.temSymbol == temperatureSymbolF) {
            str = [NSString stringWithFormat:@"%d",(int)((i * 5) * 1.8) +32];
        }
        
        CGSize size=[str sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:FontSize]}];
        
        CGPoint centerPoint = [UITemperatureSlider calcCircleCoordinateWithCenter:sliderButtonCenterPoint andWithAngle:startAngle andWithRadius:radius + kLineWidth];

        CGPoint drawPoint =CGPointMake(centerPoint.x - (size.width*0.9), centerPoint.y - (size.height));
        [str drawAtPoint:drawPoint withAttributes:nil];
        
        startAngle -= 17.4;
        CGContextClosePath(context);
        CGContextFillPath(context);
        UIGraphicsPopContext();
    }
}

- (void)drawRoundpointWithRadius:(CGFloat)radius sliderButtonCenterPoint:(CGPoint)sliderButtonCenterPoint inContext:(CGContextRef)context
{
    NSInteger startAngle = 240;
    UInt8 R = 128;
    UInt8 G = 255;
    UInt8 B = 255;
    
    CGFloat roundPointRadius = self.bounds.size.width / 256;

    for (int i = 0; i < 102; i++) {
        
        UIGraphicsPushContext(context);
        CGContextBeginPath(context);
        
        CGPoint centerPoint = [UITemperatureSlider calcCircleCoordinateWithCenter:sliderButtonCenterPoint andWithAngle:startAngle andWithRadius:radius + kThumbRadius *0.8];
        
        UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
        if (i < 33) {
            R < 255 ? R += 3 : 0;
            B > 128 ? B -= 3 : 0;
        } else if (i < 66){
            G > 0 ? G -= 6 : 0;
            B > 0 ? B -= 3 : 0;
        } else if (i < 100){
            R > 255 ? R -= 3 : 0;
        }
    
        [color setFill];
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, roundPointRadius, 0.0, 2*M_PI, NO);
        startAngle -= 3;
        
        CGContextClosePath(context);
        CGContextFillPath(context);
        UIGraphicsPopContext();
    }
}
//Utility
+(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

- (CGPoint)drawCircularTrack:(float)track atPoint:(CGPoint)center withRadius:(CGFloat)radius inContext:(CGContextRef)context {
	UIGraphicsPushContext(context);
	CGContextBeginPath(context);
	
	float angleFromTrack = translateValueFromSourceIntervalToDestinationInterval(track, self.minimumValue, self.maximumValue, 0, 2*M_PI - M_PI / 4);
	
	CGFloat startAngle = M_PI_2 + M_PI_4*0.5;
	CGFloat endAngle = startAngle + angleFromTrack;
	CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, NO);
	
	CGPoint arcEndPoint = CGContextGetPathCurrentPoint(context);
	
	CGContextStrokePath(context);
	UIGraphicsPopContext();
	
	return arcEndPoint;
}

- (CGPoint)drawPieTrack:(float)track atPoint:(CGPoint)center withRadius:(CGFloat)radius inContext:(CGContextRef)context {
	UIGraphicsPushContext(context);
	
	float angleFromTrack = translateValueFromSourceIntervalToDestinationInterval(track, self.minimumValue, self.maximumValue, 0, 2*M_PI);
	
	CGFloat startAngle = -M_PI_2;
	CGFloat endAngle = startAngle + angleFromTrack;
	CGContextMoveToPoint(context, center.x, center.y);
	CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, NO);
	
	CGPoint arcEndPoint = CGContextGetPathCurrentPoint(context);
	
	CGContextClosePath(context);
	CGContextFillPath(context);
	UIGraphicsPopContext();
	
	return arcEndPoint;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGPoint middlePoint;
	middlePoint.x = self.bounds.origin.x + self.bounds.size.width/2;
	middlePoint.y = self.bounds.origin.y + self.bounds.size.height/2;
	
	CGContextSetLineWidth(context, kLineWidth);
	
	CGFloat radius = [self sliderRadius];
	
            [self drawTextWithRadius:radius sliderButtonCenterPoint:middlePoint inContext:context];
            //slider背景色
			[self.maximumTrackTintColor setStroke];
            //
			[self drawCircularTrack:self.maximumValue atPoint:middlePoint withRadius:radius inContext:context];
            [self drawRoundpointWithRadius:radius sliderButtonCenterPoint:middlePoint inContext:context];
            
			[self.minimumTrackTintColor setStroke];
			self.thumbCenterPoint = [self drawCircularTrack:self.value atPoint:middlePoint withRadius:radius inContext:context];
			
	
	
	[self.thumbTintColor setFill];
	[self drawThumbAtPoint:self.thumbCenterPoint inContext:context];
}

/** @name Thumb management methods */
#pragma mark - Thumb management methods
- (BOOL)isPointInThumb:(CGPoint)point {
	CGRect thumbTouchRect = CGRectMake(self.thumbCenterPoint.x - kThumbRadius, self.thumbCenterPoint.y - kThumbRadius, kThumbRadius*2, kThumbRadius*2);
	return CGRectContainsPoint(thumbTouchRect, point);
}

/** @name UIGestureRecognizer management methods */
#pragma mark - UIGestureRecognizer management methods
- (void)panGestureHappened:(UIPanGestureRecognizer *)panGestureRecognizer {
	CGPoint tapLocation = [panGestureRecognizer locationInView:self];
	switch (panGestureRecognizer.state) {
		case UIGestureRecognizerStateChanged: {
			CGFloat radius = [self sliderRadius];
			CGPoint sliderCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
            CGPoint startPoint = [UITemperatureSlider calcCircleCoordinateWithCenter:sliderCenter andWithAngle:270 andWithRadius:radius];
			//CGPoint sliderStartPoint = CGPointMake(sliderCenter.x, sliderCenter.y - radius);
			CGFloat angle = angleBetweenThreePoints(sliderCenter, startPoint, tapLocation);
  
			if (angle < 0) {
				angle = -angle;
			} else {
				angle = 2*M_PI - angle;
			}
            NSLog(@"angle = %lf",angle);
            
            float newValue =translateValueFromSourceIntervalToDestinationInterval(angle, 0, 2*M_PI, self.minimumValue, self.maximumValue);
			self.value = newValue;
            
			break;
		}
        case UIGestureRecognizerStateEnded:
            if (!self.isContinuous) {
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
            if ([self isPointInThumb:tapLocation]) {
                [self sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
            else {
                [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
            }
            break;
		default:
			break;
	}
}
- (void)tapGestureHappened:(UITapGestureRecognizer *)tapGestureRecognizer {
	if (tapGestureRecognizer.state == UIGestureRecognizerStateEnded) {
		CGPoint tapLocation = [tapGestureRecognizer locationInView:self];
		if ([self isPointInThumb:tapLocation]) {
		}
		else {
		}
	}
}

/** @name Touches Methods */
#pragma mark - Touches Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    if ([self isPointInThumb:touchLocation]) {
        [self sendActionsForControlEvents:UIControlEventTouchDown];
    }
}

@end

