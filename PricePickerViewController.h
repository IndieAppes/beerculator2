//
//  PricePickerViewController.h
//  BeerCalc
//
//  Parts taken from https://github.com/mpatric/decimal-input
//
//  Created by Josh Palmer on 23/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Beer.h"
#import "PickerViewController.h"
//@protocol PickerDelegate <NSObject>
//- (void)updateBeer:(Beer *)beer;
//- (Beer *) getBeerOnLoad;
//- (void)advanceViewController;
//@end

@protocol BeerUpdateDelegate <NSObject>
- (void) addBeerToList:(Beer *)beer;
@end

@interface PricePickerViewController : UIViewController <UITextFieldDelegate, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField* textField;
@property (strong, nonatomic) IBOutlet UILabel* currencyLabel;
@property (strong, nonatomic) IBOutlet UIScrollView* scrollView;
@property (assign) id <BeerUpdateDelegate> delegate;
@property (nonatomic, strong) Beer* beerToBuild;


- (IBAction)pushOk:(id)sender;

@end
