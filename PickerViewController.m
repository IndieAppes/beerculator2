//
//  PickerCVControllerViewController.m
//  BeerCalc
//
//  Created by Josh Palmer on 15/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PickerViewController.h"
#import "PresetValuesHelper.h"
#import "PickerCell.h"
#import "PricePickerViewController.h"
#import "footerPicker.h"

@interface PickerViewController ()

@property UIViewController* nextViewController;

@end

@implementation PickerViewController

@synthesize presetValues;
@synthesize beerToBuild;
@synthesize stage;
@synthesize delegate;
@synthesize nextViewController;

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
	// Do any additional setup after loading the view.
    
    

    UINib * cellNib = [UINib nibWithNibName:@"PickerCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"pickerCell"];
    
    // populate our presets based on the selected mode/stage
    // set nav view title and set small back button
    
    switch (stage) {
        case myBeerBrand:
            self.presetValues = [[PresetValuesHelper presetBrandsFactory] mutableCopy];
            self.title = @"Beer name";
            break;
        
        case myBeerNumberOfCans:
            self.presetValues = [[PresetValuesHelper presetNumberOfCansFactory] mutableCopy];
            self.title = @"Number of cans";
            break;
        
        case myBeerCanVolume:
            self.presetValues = [[PresetValuesHelper presetVolumesFactory] mutableCopy];
            self.title = @"Volume of each can";
            break;
        
        case myBeerAlcoholByVolume:
            self.presetValues = [[PresetValuesHelper presetABVFactory] mutableCopy];
            self.title = @"Percentage alcohol by volume";
            break;
        case myBeerPrice:
            // shouldn't get here using this view because there's no presets for this, so fuck off i guess
            NSLog(@"something broke. got to pickerCollView with price selection option. aaaa");
            
        default:
            break;
    }
    if (beerToBuild == nil) {
        self.beerToBuild = [[Beer alloc] init];
    }
    
    // init the beer if we don't already have one
    
//    [self.presetValues addObject:@"Other"];
    
    
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

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    footerPicker *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                         UICollectionElementKindSectionFooter withReuseIdentifier:@"footerPicker" forIndexPath:indexPath];
    return footerView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PickerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pickerCell" forIndexPath:indexPath];
    
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
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [presetValues count];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id currentVal = [self.presetValues objectAtIndex:indexPath.row];
    
    if (indexPath.row == [presetValues count])
    {
        // display keyboard, and UITextField
        // modify appearance based on stage
        
    }

    
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
    
    // [self.delegate updateBeer:beerToBuild];
    
    if (stage != myBeerAlcoholByVolume) {
        PickerViewController * nextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PickerViewController"];
        nextVC.stage = stage + 1;
    
        nextVC.beerToBuild = beerToBuild;
        
        self.nextViewController = nextVC;
        
        // keep track of this viewcontroller here so if they swipe back,
        // they can swipe forward without having to reclick
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else {
        PricePickerViewController * pricePicker = [[PricePickerViewController alloc] initWithNibName:@"PricePickerViewController" bundle:nil];
        pricePicker.beerToBuild = beerToBuild;
        pricePicker.delegate = self.navigationController.viewControllers[0];
        [self.navigationController pushViewController:pricePicker animated:YES];

    }

    
    // [self.delegate advanceViewController];
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//}


@end
