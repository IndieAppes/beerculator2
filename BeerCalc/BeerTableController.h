//
//  BeerTableController.h
//  BeerCalc
//
//  Created by Josh Palmer on 14/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"
#import "PopoverView.h"

#import "GAITracker.h"

@interface BeerTableController : UITableViewController <BeerUpdateDelegate, PopoverViewDelegate>

@property (nonatomic, retain) NSMutableArray * beers;
@property (nonatomic, strong) IBOutlet UISegmentedControl * sortPicker;
@property (nonatomic, strong) IBOutlet UIBarButtonItem * addBeverageButton;

- (IBAction) sortListAppropriately;


@end
