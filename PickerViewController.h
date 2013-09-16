//
//  PickerViewController.h
//  BeerCalc
//
//  Created by Josh Palmer on 15/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
#import "PresetValuesHelper.h"

@interface PickerViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray * presetValues;
@property (nonatomic, strong) Beer * beerToBuild;

@property (nonatomic, assign) beerStage stage;

@end
