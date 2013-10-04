//
//  footerPicker.h
//  BeerCalc
//
//  Created by Josh Palmer on 04/10/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresetValuesHelper.h"

@interface footerPicker : UICollectionReusableView

@property (nonatomic, strong) IBOutlet UITextField* customPicker;
@property (nonatomic, assign) beerStage stage;

@end
