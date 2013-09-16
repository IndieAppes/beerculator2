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

@interface PickerPageViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) Beer * beerToBuild;
@property (nonatomic, assign) beerStage stage;
@property (nonatomic, strong) NSArray * viewControllers;

@end
