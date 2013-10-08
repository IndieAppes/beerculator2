//
//  footerPicker.h
//  BeerCalc
//
//  Created by Josh Palmer on 04/10/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetValuesHelper.h"

@protocol CustomPickerDelegate <NSObject>
- (void) updateBeerFromCustomPickerText:(NSString *)string;
@end


@interface footerPicker : UICollectionReusableView <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField* customPicker;
@property (nonatomic, assign) beerStage stage;
@property (nonatomic, strong) UIButton* overlayButton;
- (void)setSelectedRange:(NSRange)range;
@property (assign) id <CustomPickerDelegate> pickerDelegate;

@end
