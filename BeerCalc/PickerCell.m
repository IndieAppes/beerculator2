//
//  PickerCell.m
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PickerCell.h"

@implementation PickerCell

@synthesize pickerLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect insetRect = CGRectInset(rect, 0.5, 0.5);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:6];
    
    [path setLineWidth:0.5];
    
    [[UIColor whiteColor] setFill];
    [path fill];
    
    [[UIColor darkGrayColor] setStroke];
    [path stroke];
}


@end
