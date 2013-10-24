//
//  PopoverView_Configuration.h
//  popover
//
//  Created by Bas Pellis on 12/25/12.
//  Copyright (c) 2012 Oliver Rickard. All rights reserved.
//

#pragma mark Constants - Configure look/feel

// BOX GEOMETRY

//Height/width of the actual arrow
#define kArrowHeight 12.f

//padding within the box for the contentView
#define kBoxPadding 10.f

//control point offset for rounding corners of the main popover box
#define kCPOffset 1.8f

//radius for the rounded corners of the main popover box
#define kBoxRadius 4.f

//Curvature value for the arrow.  Set to 0.f to make it linear.
#define kArrowCurvature 6.f

//Minimum distance from the side of the arrow to the beginning of curvature for the box
#define kArrowHorizontalPadding 0.f

//Alpha value for the shadow behind the PopoverView
#define kShadowAlpha 0.4f

//Blur for the shadow behind the PopoverView
#define kShadowBlur 3.f;

//Box gradient bg alpha
#define kBoxAlpha 0.95f

//Padding along top of screen to allow for any nav/status bars
#define kTopMargin 50.f

//margin along the left and right of the box
#define kHorizontalMargin 10.f

//padding along top of icons/images
#define kImageTopPadding 3.f

//padding along bottom of icons/images
#define kImageBottomPadding 3.f


// DIVIDERS BETWEEN VIEWS

//Bool that turns off/on the dividers
#define kShowDividersBetweenViews NO

//color for the divider fill
#define kDividerColor [UIColor colorWithRed:0.329 green:0.341 blue:0.353 alpha:0.15f]


// BACKGROUND GRADIENT

//bottom color white in gradient bg
#define kGradientBottomColor [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:kBoxAlpha]

//top color white value in gradient bg
#define kGradientTopColor [UIColor colorWithRed:1.f green:0.5f blue:0.f alpha:kBoxAlpha]


// TITLE GRADIENT

//bool that turns off/on title gradient
#define kDrawTitleGradient NO

//bottom color white value in title gradient bg
#define kGradientTitleBottomColor [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:kBoxAlpha]

//top color white value in title gradient bg
#define kGradientTitleTopColor [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:kBoxAlpha]


// FONTS

//normal text font
#define kTextFont [UIFont fontWithName:@"HelveticaNeue-Light" size:22.f]

//normal text color
#define kTextHighlightColor [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.000]

// highlighted text color
#define kTextColor [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0]


//normal text alignment
#define kTextAlignment UITextAlignmentCenter

//title font
#define kTitleFont [UIFont fontWithName:@"HelveticaNeue" size:22.f]

//title text color
#define kTitleColor [UIColor colorWithRed:1 green:1 blue:1 alpha:1]


// BORDER

//bool that turns off/on the border
#define kDrawBorder NO

//border color
#define kBorderColor [UIColor blackColor]

//border width
#define kBorderWidth 1.f