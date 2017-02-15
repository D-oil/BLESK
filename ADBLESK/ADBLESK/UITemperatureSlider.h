//
///  UICircularSlider.h
///  UICircularSlider
//
//  Created by Zouhair Mahieddine on 02/03/12.
//  Copyright (c) 2012 Zouhair Mahieddine.
//  http://www.zedenem.com
//  
//  This file is part of the UICircularSlider Library, released under the MIT License.
//

#if ! __has_feature(objc_arc)
#warning This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

#import <UIKit/UIKit.h>
#import "UICircularSlider.h"
#import "AppDelegate.h"

/** @name Constants */
/**
 * The styles permitted for the circular progress view.
 *
 * You can set and retrieve the current style of progress view through the progressViewStyle property.
 */

@interface UITemperatureSlider : UIControl

/**
 * The current value of the receiver.
 *
 * Setting this property causes the receiver to redraw itself using the new value.
 * If you try to set a value that is below the minimum or above the maximum value, the minimum or maximum value is set instead. The default value of this property is 0.0.
 */
@property (nonatomic) float value;

/**
 * The minimum value of the receiver.
 * 
 * If you change the value of this property, and the current value of the receiver is below the new minimum, the current value is adjusted to match the new minimum value automatically.
 * The default value of this property is 0.0.
 */
@property (nonatomic) float minimumValue;

/**
 * The maximum value of the receiver.
 * 
 * If you change the value of this property, and the current value of the receiver is above the new maximum, the current value is adjusted to match the new maximum value automatically.
 * The default value of this property is 1.0.
 */
@property (nonatomic) float maximumValue;

/**
 * The color shown for the portion of the slider that is filled.
 */
@property(nonatomic, retain) UIColor *minimumTrackTintColor;

/**
 * The color shown for the portion of the slider that is not filled.
 */
@property(nonatomic, retain) UIColor *maximumTrackTintColor;

/**
 * The color used to tint the standard thumb.
 */
@property(nonatomic, retain) UIColor *thumbTintColor;

/**
 * Contains a Boolean value indicating whether changes in the sliders value generate continuous update events.
 *
 * If YES, the slider sends update events continuously to the associated target’s action method.
 * If NO, the slider only sends an action event when the user releases the slider’s thumb control to set the final value.
 * The default value of this property is YES.
 */
@property(nonatomic, getter=isContinuous) BOOL continuous;


@property (nonatomic,assign) temperatureSymbol temSymbol;

@end



