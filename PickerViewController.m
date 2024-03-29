//
//  PickerViewController.m
//  BeerCalc
//
//  Created by Josh Palmer on 15/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PickerViewController.h"
#import "PresetValuesHelper.h"
#import "PickerCell.h"
#import "footerPicker.h"

#import "GAI.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface PickerViewController ()

@property UIViewController* nextViewController;

@end

@implementation PickerViewController

@synthesize presetValues;
@synthesize beerToBuild;
@synthesize stage;
@synthesize nextViewController;
@synthesize footer;
@synthesize beerTableDelegate;
@synthesize beverage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil // withMode:(beerStage)mode withBeer:(Beer *)beerBeingBuilt
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.tintColor = self.navigationController.navigationBar.tintColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
	// Do any additional setup after loading the view.
    [self registerForKeyboardNotifications];
    UINib * cellNib = [UINib nibWithNibName:@"PickerCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"pickerCell"];
    
    // populate our presets based on the selected mode/stage
    // set nav view title and set small back button
    // set footer text stuff

    switch (stage) {
        case myBeerBrand:
            self.presetValues = [[PresetValuesHelper presetBrandsFactoryWithBeverageType:beverage ] mutableCopy];
            break;
        
        case myBeerNumberOfCans:
            self.presetValues = [[PresetValuesHelper presetNumberOfCansFactoryWithBeverageType:beverage] mutableCopy];
            break;
        
        case myBeerCanVolume:
            self.presetValues = [[PresetValuesHelper presetVolumesFactoryWithBeverageType:beverage] mutableCopy];
            break;
        
        case myBeerAlcoholByVolume:
            self.presetValues = [[PresetValuesHelper presetABVFactoryWithBeverageType:beverage] mutableCopy];
            break;
            
        // no presets or title for price
        case myBeerPrice:
        default:
            break;
    }
    if (beerToBuild == nil) {
        self.beerToBuild = [[Beer alloc] init];
    }
    
    self.title = [PresetValuesHelper titleFactoryWithBeverageType:beverage andStage:stage];
    // set the title
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:[PresetValuesHelper logTitleFactoryWithBeverageType:beverage andStage:stage]];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];

    
    
    // forward swipe gesture recognizer
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeForward:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionRight);


    [self.view addGestureRecognizer:swipeGesture];

}
                                              
- (void) swipeForward:(UISwipeGestureRecognizer*)swipeGesture
{
    if (nextViewController != nil) {
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    footerPicker *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                         UICollectionElementKindSectionFooter withReuseIdentifier:@"footerPicker" forIndexPath:indexPath];
    
    footerView.tintColor = self.view.tintColor;
    NSLocale *theLocale = [NSLocale currentLocale];
    NSString *symbol = [theLocale objectForKey:NSLocaleCurrencySymbol];
    NSString* baseText = @"Other:  ";
    self.footer = footerView;
    self.footer.pickerDelegate = self;
    footer.stage = stage;
    // modify keyboard based on stage
    switch (stage) {
        case myBeerBrand:
            // do nothing its already fine
            break;
            
        case myBeerNumberOfCans:
            self.footer.customPicker.keyboardType = UIKeyboardTypeNumberPad;
            break;
            
        case myBeerCanVolume:
            self.footer.customPicker.text = @"Other:  ml";
            self.footer.customPicker.keyboardType = UIKeyboardTypeNumberPad;
            [self.footer setSelectedRange:NSMakeRange(self.footer.customPicker.text.length - 3, 0)];
            break;
            
        case myBeerAlcoholByVolume:
            self.footer.customPicker.text = @"Other:  %";
            self.footer.customPicker.keyboardType = UIKeyboardTypeDecimalPad;
            [self.footer setSelectedRange:NSMakeRange(self.footer.customPicker.text.length - 2, 0)];
            break;
        case myBeerPrice:
            self.footer.customPicker.text = [baseText stringByAppendingString:symbol];
            self.footer.customPicker.keyboardType = UIKeyboardTypeDecimalPad;
            [self.footer.customPicker becomeFirstResponder];
            break;
    }
    return footerView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PickerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pickerCell" forIndexPath:indexPath];
    cell.tintColor = self.view.tintColor;
    
    // conditionally format based on what stage we're in
    
    NSString * cellLabel;
    id currentVal = [self.presetValues objectAtIndex:indexPath.row];

    // since only the Brands have string literals, take stringValue for all other stages
//    if (indexPath.row == [presetValues count] - 1) {
//        
//        // lol fuck array indeces!!!!
//        
//        cell.pickerLabel.text = currentVal;
//        // just set the text as normal and skip everything else if it's the "custom" cell
//        return cell;
//    }
    if (stage == myBeerBrand)
    {
        cellLabel = currentVal;
    }
    else
    {
        if ([currentVal isKindOfClass:[NSConstantString class]]) {
            cellLabel = currentVal;
            // dumb override wtf ok
        }
        cellLabel = [currentVal stringValue];
   
    }
    
    switch (stage)
    {
        case myBeerBrand:
        case myBeerNumberOfCans:
            cell.pickerLabel.text = cellLabel;
            // just print string representation for brands (String) and cans (int)
            break;
            
        case myBeerAlcoholByVolume:
            cell.pickerLabel.text = [cellLabel stringByAppendingString:@"%"];
            break;
            
        case myBeerCanVolume:
            cell.pickerLabel.text = [cellLabel stringByAppendingString:@" ml"];
            break;

        default:
            break;
    }
    
    [cell.pickerLabel setNeedsUpdateConstraints];
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (stage == myBeerPrice) {
        return 0;
    }
    return [presetValues count];
}


- (void)advanceBeerStage
{
    
    if (stage != myBeerPrice) {
        PickerViewController * nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PickerViewController"];
        if ((beverage == (myDrinkSpirits) || (beverage == myDrinkWine)) && stage == myBeerBrand)
        {
            nextVC.stage = stage + 2;
            self.beerToBuild.numberOfCans = 1;
            // skip the myBeerCans stage for spirits and wines
        }
        else
        {
            nextVC.stage = stage + 1;
        }
        
        nextVC.beerToBuild = beerToBuild;
        nextVC.beverage = beverage;
        nextVC.beerTableDelegate = self.beerTableDelegate;
        
        self.nextViewController = nextVC;
        
        // keep track of this viewcontroller here so if they swipe back,
        // they can swipe forward without having to reclick
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id currentVal = [self.presetValues objectAtIndex:indexPath.row];
    
    switch (stage)
    {
        case myBeerBrand:
            [beerToBuild setBrand:currentVal];
            NSLog(@"Brand set to %@", beerToBuild.brand);
            break;
            
        case myBeerCanVolume:
            beerToBuild.canVolume = [currentVal intValue];
            
            // canVolume and numberOfCans are ints, cast from obj to int so we dont end up creatin stuff w/pointers
            break;
            
        case myBeerAlcoholByVolume:
            beerToBuild.alcoholByVolume = currentVal;
            break;
            
        case myBeerNumberOfCans:
            beerToBuild.numberOfCans = [currentVal intValue];

        default:
            break;
    }
    
    NSLog(@"Selection made: %@", [[presetValues objectAtIndex:indexPath.row] description]);
    NSLog(@"Beer is currently: %@", beerToBuild);
    // pass the beer up and along, advance to next view
    
    [self advanceBeerStage];

    
    // [self.delegate advanceViewController];
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//}

- (void) updateBeerFromCustomPickerText:(NSString *)string
{
    NSLocale *theLocale = [NSLocale currentLocale];
    NSString *symbol = [theLocale objectForKey:NSLocaleCurrencySymbol];

    switch (self.stage) {
        case myBeerBrand:
            self.beerToBuild.brand = string;
            
            //check for nil
            if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] != 0) {
                [self advanceBeerStage];
            }
            break;
        case myBeerNumberOfCans:
            self.beerToBuild.numberOfCans = [string intValue];
            
            // check for nil
            
            if (self.beerToBuild.numberOfCans != 0) {
                [self advanceBeerStage];
            }
            break;
        
        case myBeerCanVolume:
            string = [string stringByReplacingOccurrencesOfString:@"Other: " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" ml" withString:@""];
            self.beerToBuild.canVolume = [string intValue];
            // check for nil
            
            if (self.beerToBuild.canVolume != 0) {
                [self advanceBeerStage];
            }
            break;
            
        case myBeerAlcoholByVolume:
            string = [string stringByReplacingOccurrencesOfString:@"Other: " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@" %" withString:@""];
            self.beerToBuild.alcoholByVolume = [NSDecimalNumber decimalNumberWithString:string];
            
            if (![self.beerToBuild.alcoholByVolume isEqualToNumber:@0])
            {
                [self advanceBeerStage];
            }
            break;
            
        case myBeerPrice:
            string = [string stringByReplacingOccurrencesOfString:@"Other: " withString:@""];
            string = [string stringByReplacingOccurrencesOfString:symbol withString:@""];

            self.beerToBuild.price = [NSDecimalNumber decimalNumberWithString:string locale:[NSLocale currentLocale]];
            NSLog(@"Price: %@, = 0? %hhd",[beerToBuild.price description], [self.beerToBuild.price isEqualToNumber:[NSNumber numberWithInt:0]]);
            if (![self.beerToBuild.price isEqualToNumber:0])
            {
                [self.beerTableDelegate addBeerToList:beerToBuild];
                [self.navigationController popToRootViewControllerAnimated:YES];
            break;
            }
            
        default:
            break;
    }
}


#pragma mark – UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(130, 55);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 20, 20, 20);
}

#pragma mark - Keyboard Notifications


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [self.collectionView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0.0, kbSize.height + 20, 0.0);
    self.collectionView.contentInset = contentInsets;
    self.collectionView.scrollIndicatorInsets = contentInsets;
    [self.collectionView scrollRectToVisible:footer.frame animated:YES];
    
    // modify keyboard position based on stage
    // draw a done button over keyboard
    
    
    switch (stage) {
        case myBeerBrand:
            // do nothing its already fine
        case myBeerNumberOfCans:
            // self.footer.customPicker.rightViewMode = UITextFieldViewModeWhileEditing;
            break;
            
        case myBeerCanVolume:
            // self.footer.customPicker.rightViewMode = UITextFieldViewModeWhileEditing;
            [self.footer setSelectedRange:NSMakeRange(self.footer.customPicker.text.length - 3, 0)];
            break;
            
        case myBeerAlcoholByVolume:
            // self.footer.customPicker.rightViewMode = UITextFieldViewModeWhileEditing;
            [self.footer setSelectedRange:NSMakeRange(self.footer.customPicker.text.length - 2, 0)];
            break;
        case myBeerPrice:
            // do nothing
            break;
    }

    return;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.navigationController.navigationBar.frame.size.height
    self.collectionView.contentInset = contentInsets;
    self.collectionView.scrollIndicatorInsets = contentInsets;
    if (stage != myBeerPrice) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    }
    
    // hide done button on keyboard if it's left blank
    NSString* string = self.footer.customPicker.text;
    
    // strip our custom stuff
    string = [string stringByReplacingOccurrencesOfString:@"Other: " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" %" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" ml" withString:@""];
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        self.footer.customPicker.rightViewMode = UITextFieldViewModeWhileEditing;
    }

    
    return;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

@end
