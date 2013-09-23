//
//  BeerTableController.h
//  BeerCalc
//
//  Created by Josh Palmer on 14/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerPageViewController.h"


@interface BeerTableController : UITableViewController <BeerUpdateDelegate>

@property (nonatomic, retain) NSMutableArray * beers;


@end
