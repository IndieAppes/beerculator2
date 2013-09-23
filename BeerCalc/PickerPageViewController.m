//
//  PickerPageViewController.m
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PickerPageViewController.h"
#import "PickerViewController.h"
#import "PresetValuesHelper.h"
@interface PickerPageViewController ()

@end

@implementation PickerPageViewController

@synthesize beerToBuild;
@synthesize stage;
@synthesize myViewControllers;
@synthesize BeerDelegate;

# pragma mark - UIPageViewControllerDataSource

// if we're passing around objects maybe this is the way to do it? destroy and recreate the view????
// TODO: set the beer property of each view when changing

// returns VC before given VC
- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.myViewControllers indexOfObject:viewController];
    if(currentIndex == 0)
        return nil;
    
    id nextVC = [self.myViewControllers objectAtIndex:currentIndex - 1];
    return nextVC;
}


//returns VC after given VC
- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.myViewControllers indexOfObject:viewController];
    if(currentIndex == self.myViewControllers.count - 1)
        return nil;
    
    id nextVC = [self.myViewControllers objectAtIndex:currentIndex + 1];
    return nextVC;
}

- (NSInteger) presentationIndexForPageViewController: (UIPageViewController *)pageViewController
{
    return 0;
}

- (NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return myViewControllers.count;
}

# pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    
    return UIPageViewControllerSpineLocationMin;
}

#pragma mark - View Lifecycle stuff

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
    
    self.beerToBuild = [[Beer alloc] init];
    [self updateBeer:self.beerToBuild];
    
    // get the beer initiated before we fuck with subviews
    
    // do delegates
    
    self.delegate = self;
    self.dataSource = self;
    
    // intitate our array of viewcontrollers
    
    self.myViewControllers = [[NSArray alloc] init];
    
    // populate the array with the correct stages
    
    NSMutableArray * setupArray = [[NSMutableArray alloc] init];
    for (int i = myBeerBrand; i < myBeerPrice ; i++)
    {
        PickerViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PickerViewController"];
        vc.stage = i;
        vc.delegate = self;
        [setupArray addObject:vc];
    }
    
    // TODO: add our prices VC later on
    
    // set the viewControllers as an array of 1 (it wants them as an array but uses the other methods to actually get them. yes this is odd)
    
    self.myViewControllers = [setupArray copy];
    NSArray * initialArray = [[NSArray alloc] initWithObjects:myViewControllers[0], nil];
    
    [self setViewControllers:initialArray direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // TODO: check animations
    

    // remove tap gesture recognizzers, only swipe advances
    
    self.view.gestureRecognizers = self.gestureRecognizers;
    UIGestureRecognizer* tapRecognizer = nil;
    
    for (UIGestureRecognizer* recognizer in self.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UITapGestureRecognizer class]])
        {
            tapRecognizer = recognizer;
        }
    }
    
    if (tapRecognizer)
    {
        [self.view removeGestureRecognizer:tapRecognizer];
//        [self gestureRecognizers:remove:(tapRecognizer)];
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateBeer:(Beer *)beer
{
    self.beerToBuild = beer;
    NSLog(@"Brand: %@", beer.brand);
    NSLog(@"Cans: %@", [NSString stringWithFormat:@"%d",beer.numberOfCans]);
    NSLog(@"ABV: %@", beer.alcoholByVolume);
    NSLog(@"CanVol %@", [NSString stringWithFormat:@"%d",beer.canVolume]);
    // NSLog(@"%@", [beerToBuild description]);
}

-(Beer *) getBeerOnLoad
{
    return self.beerToBuild;
    // this method just lets the subviews grab the updated beer to make sure its always in sync with the top level
}

-(void) advanceViewController
{
    UIViewController * nextVC = [self pageViewController:self viewControllerAfterViewController:self.viewControllers[0]];
    // check to ensure that this doesn't break if u tap it fast. check the didfinishanimating method and set _currentViewController as an instance variable from there
    // otherwise if user taps VC1 quick then VC2 before VC2 has finished animating, could jump to VC2 again. or something.
    if (nextVC != nil) {
        [self setViewControllers:[NSArray arrayWithObject:nextVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    else {
        // go back to the list view an add the beer
        
        // TODO: uncomment this when price implemented
        beerToBuild.price = [NSDecimalNumber decimalNumberWithString:@"4.00"];
        
        [self.BeerDelegate addBeerToList:beerToBuild];
        
        // updatebeer should always have been called before advance so should be current
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    return;
}


@end
