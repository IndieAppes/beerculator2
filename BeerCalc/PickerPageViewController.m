//
//  PickerPageViewController.m
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PickerPageViewController.h"
#import "PickerViewController.h'"

@interface PickerPageViewController ()

@end

@implementation PickerPageViewController

@synthesize beerToBuild;
@synthesize stage;
@synthesize viewControllers;

# pragma mark - UIPageViewControllerDataSource

// if we're passing around objects maybe this is the way to do it? destroy and recreate the view????

// returns VC before given VC
- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.viewControllers indexOfObject:viewController];
    if(currentIndex == 0)
        return nil;
    
    id nextVC = [self.viewControllers objectAtIndex:currentIndex - 1];
    return nextVC;
}


//returns VC after given VC
- (UIViewController *) pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.viewControllers indexOfObject:viewController];
    if(currentIndex == self.viewControllers.count - 1)
        return nil;
    
    id nextVC = [self.viewControllers objectAtIndex:currentIndex + 1];
    return nextVC;
}

- (NSInteger) presentationIndexForPageViewController: (UIPageViewController *)pageViewController
{
    return 0;
}

- (NSInteger) presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return viewControllers.count;
}

# pragma mark - UIPageViewControllerDelegate Methods

- pa

#pragma mark - View Lifecycle stuff

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.viewControllers = [[NSArray alloc] init];
        
        viewControllers = [[NSArray arrayWithObjects:
                            [[PickerViewController alloc] init], nil]]
        
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-

@end
