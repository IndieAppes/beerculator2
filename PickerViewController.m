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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    stage = myBeerBrand; // set it to the first stage
    
    self.presetValues = [[PresetValuesHelper presetBrandsFactory] copy];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PickerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pickerCell" forIndexPath:indexPath];
    
    cell.label.text = [[self.presetValues objectAtIndex:indexPath] stringValue];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [presetValues count];
}





@end
