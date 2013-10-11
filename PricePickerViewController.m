//
//  PricePickerViewController.m
//  BeerCalc
//
//  Parts taken from https://github.com/mpatric/decimal-input
//
//  Created by Josh Palmer on 23/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//


#import "PricePickerViewController.h"
#import <QuartzCore/QuartzCore.h>


#define MAX_LENGTH 8


@interface PricePickerViewController()

@property (assign, nonatomic) int maximumFractionDigits;
@property (strong, nonatomic) NSString* decimalSeparator;


@end


@implementation PricePickerViewController

@synthesize textField = _textField, maximumFractionDigits = _maximumFractionDigits, decimalSeparator = _decimalSeparator;
@synthesize beerToBuild;
@synthesize scrollView;

@synthesize borderView;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        numberFormatter.locale = [NSLocale currentLocale];
        self.maximumFractionDigits = numberFormatter.maximumFractionDigits;
        self.decimalSeparator = numberFormatter.decimalSeparator;
        [self registerForKeyboardNotifications];
        
        self.beerToBuild = [[Beer alloc] init];
    }
    return self;
}

- (IBAction)pushOk:(id)sender {
    // wire this up to keyboard dismiss button
    
    self.beerToBuild.price = [NSDecimalNumber decimalNumberWithString:self.textField.text locale:[NSLocale currentLocale]];
    NSLog(@"Price: %@, = 0? %hhd",[beerToBuild.price description], [self.beerToBuild.price isEqualToNumber:[NSNumber numberWithInt:0]]);
    if (![self.beerToBuild.price isEqualToNumber:0])
    {
        [self.delegate addBeerToList:beerToBuild];
        [self.navigationController popToRootViewControllerAnimated:YES];

        
//        [self.delegate updateBeer:beerToBuild];
//        [self.delegate advanceViewController];
        
    }
}

#pragma mark - view lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated {
    // Default value
    // self.beerToBuild = [self.delegate getBeerOnLoad];
    // get the beer
    self.borderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.title = @"Price";
    // subtitle? extra view??!
    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 20, 0.0, 236, 0.0);
//    self.scrollView.contentInset = contentInsets;
//    self.scrollView.scrollIndicatorInsets = contentInsets;

    
    self.textField.text = @"0.00";
    // Pop up keyboard
    [self.textField becomeFirstResponder];
    // animate the other shit
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    // TODO replace the scrollview with a view? maybe idk
    
    // This is animated but its slow? hmmmmery should probably make shit appear in the right place
    // fuck this slow animation bullshit
    
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;

    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height + 20, 0.0, kbSize.height + 20, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self.scrollView scrollRectToVisible:self.borderView.frame animated:YES];
    return;
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    // get current cursor position
    UITextRange* selectedRange = [textField selectedTextRange];
    UITextPosition* start = textField.beginningOfDocument;
    NSInteger cursorOffset = [textField offsetFromPosition:start toPosition:selectedRange.start];
    // Update the string in the text input
    NSMutableString* currentString = [NSMutableString stringWithString:textField.text];
    NSUInteger currentLength = currentString.length;
    [currentString replaceCharactersInRange:range withString:string];
    // Strip out the decimal separator
    [currentString replaceOccurrencesOfString:self.decimalSeparator withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [currentString length])];
    // Generate a new string for the text input
    int currentValue = [currentString intValue];
    NSString* format = [NSString stringWithFormat:@"%%.%df", self.maximumFractionDigits];
    double minorUnitsPerMajor = pow(10, self.maximumFractionDigits);
    NSString* newString = [NSString stringWithFormat:format, currentValue / minorUnitsPerMajor];
    if (newString.length <= MAX_LENGTH) {
        textField.text = newString;
        // if the cursor was not at the end of the string being entered, restore cursor position
        if (cursorOffset != currentLength) {
            int lengthDelta = newString.length - currentLength;
            int newCursorOffset = MAX(0, MIN(newString.length, cursorOffset + lengthDelta));
            UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
            UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
            [textField setSelectedTextRange:newRange];
        }
    }
    return NO;
}

@end
