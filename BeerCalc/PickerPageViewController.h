//
//  PickerPageViewController.h
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
#import "PresetValuesHelper.h"
#import "PickerViewController.h"

@protocol BeerUpdateDelegate <NSObject>
- (void) addBeerToList:(Beer *)beer;
@end


@interface PickerPageViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, PickerDelegate>

@property (nonatomic, strong) Beer * beerToBuild;
@property (nonatomic, assign) beerStage stage;
@property (nonatomic, strong) NSArray * myViewControllers;

@property (assign) IBOutlet id <BeerUpdateDelegate> BeerDelegate;

@end
