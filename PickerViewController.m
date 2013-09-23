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

@interface PickerViewController ()

@end

@implementation PickerViewController

@synthesize presetValues;
@synthesize beerToBuild;
@synthesize stage;
@synthesize delegate;

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
    
    switch (stage) {
        case myBeerBrand:
            self.presetValues = [[PresetValuesHelper presetBrandsFactory] copy];
            break;
        
        case myBeerNumberOfCans:
            self.presetValues = [[PresetValuesHelper presetNumberOfCansFactory] copy];
            break;
        
        case myBeerCanVolume:
            self.presetValues = [[PresetValuesHelper presetVolumesFactory] copy];
            break;
        
        case myBeerAlcoholByVolume:
            self.presetValues = [[PresetValuesHelper presetABVFactory] copy];
            break;
        case myBeerPrice:
            // shouldn't get here using this view because there's no presets for this, so fuck off i guess
            NSLog(@"something broke. got to pickerCollView with price selection option. aaaa");
            
        default:
            break;
    }
    self.beerToBuild = [[Beer alloc] init];
    self.beerToBuild = [self.delegate getBeerOnLoad];
    
    // init the beer, grab the premade beer from parent
    
    NSLog(@"Should have an initialized beer");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PickerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pickerCell" forIndexPath:indexPath];
    
    // conditionally format based on what stage we're in
    
    NSString * cellLabel;
    
    id currentVal = [self.presetValues objectAtIndex:indexPath.row];
    
    // since only the Brands have string literals, take stringValue for all other stages
    
    if (stage == myBeerBrand)
    {
        cellLabel = currentVal;
    }
    else
    {
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
    switch (stage) {
        case myBeerBrand:
            [beerToBuild setBrand:[presetValues objectAtIndex:indexPath.row]];
            NSLog(@"Brand set to %@", beerToBuild.brand);
            break;
            
        case myBeerCanVolume:
            beerToBuild.canVolume = [[presetValues objectAtIndex:indexPath.row] intValue];
            
            // canVolume and numberOfCans are ints, cast from obj to int so we dont end up creatin stuff w/pointers
            break;
            
        case myBeerAlcoholByVolume:
            beerToBuild.alcoholByVolume = [presetValues objectAtIndex:indexPath.row];
            break;
            
        case myBeerNumberOfCans:
            beerToBuild.numberOfCans = [[presetValues objectAtIndex:indexPath.row] intValue];

        default:
            break;
    }
    
    NSLog(@"Selection made: %@", [[presetValues objectAtIndex:indexPath.row] description]);
    
    // pass the beer up and along, advance to next view
    
    [self.delegate updateBeer:beerToBuild];
    [self.delegate advanceViewController];
    
}


@end
