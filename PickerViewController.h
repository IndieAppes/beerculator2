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


@protocol PickerDelegate <NSObject>
- (void)updateBeer:(Beer *)beer;
- (Beer *) getBeerOnLoad;
- (void)advanceViewController;
@end

@interface PickerViewController : UICollectionViewController <UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray * presetValues;
@property (nonatomic, strong) Beer * beerToBuild;

@property (nonatomic, assign) beerStage stage;

@property (assign) id <PickerDelegate> delegate;

@end
