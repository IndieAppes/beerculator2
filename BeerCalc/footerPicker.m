//
//  footerPicker.m
//  BeerCalc
//
//  Created by Josh Palmer on 04/10/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "footerPicker.h"

@implementation footerPicker

@synthesize customPicker;
@synthesize stage;
@synthesize overlayButton;
@synthesize pickerDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        customPicker.delegate = self;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect
{
    CGRect insetRect = CGRectInset(rect, 20.5, 0.5);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:insetRect cornerRadius:6];
    
    [path setLineWidth:0.5];
    
    [[UIColor whiteColor] setFill];
    [path fill];
    
    [[UIColor darkGrayColor] setStroke];
    [path stroke];
    return;
}

- (void)setSelectedRange:(NSRange)range
{
    UITextPosition *beginning = self.customPicker.beginningOfDocument;
    UITextPosition *start = [self.customPicker positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self.customPicker positionFromPosition:start offset:range.length];
    UITextRange *textRange = [self.customPicker textRangeFromPosition:start toPosition:end];
    [self.customPicker setSelectedTextRange:textRange];
    return;
}


- (UIButton *)createOverlayButton {
    if (self.overlayButton == nil) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0, 0, 61, 30);
        [button setTitle:@"Done" forState:UIControlStateNormal];
//            [overlayButton setImage:overlayImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(customPickerDoneTapped)
                    forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        return button;
    }
    return self.overlayButton;
}

-(void)customPickerDoneTapped
{
    NSLog(@"Current text: %@", customPicker.text);
    [self.pickerDelegate updateBeerFromCustomPickerText:customPicker.text];
    return;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.overlayButton = [self createOverlayButton];
    textField.rightView = self.overlayButton;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self customPickerDoneTapped];
    // wire up our done button
    return YES;
}

@end
