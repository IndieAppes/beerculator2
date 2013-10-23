//
//  BeerTableController.m
//  BeerCalc
//
//  Created by Josh Palmer on 14/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "BeerTableController.h"
#import "Beer.h"
#import "BeerCell.h"
#import "PresetValuesHelper.h"
#import "PopoverView.h"

#import "GAI.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@interface BeerTableController ()

@property Beer * initialExampleBeer;
@property beverageType beverage;
@end

@implementation BeerTableController
@synthesize beers;
@synthesize sortPicker;
@synthesize initialExampleBeer;
@synthesize addBeverageButton;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BeerCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"beerCell"];
    
    id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
    [defaultTracker set:kGAIScreenName value:@"Beer Table"];
    
    // Send the screen view.
    [defaultTracker send:[[GAIDictionaryBuilder createAppView] build]];
    BOOL didRunBefore = [[NSUserDefaults standardUserDefaults] boolForKey:@"didRunBefore"];
    
    if (!didRunBefore) {
        // show alert;
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Welcome to Beerculator." message:@"Please enjoy alcohol responsibly. Visit drinkaware.co.uk or your local equivalent for more information." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"didRunBefore"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.beverage = myDrinkBeer;
    
    // set up and initialize our example Beer
    
    initialExampleBeer = [Beer alloc];
    initialExampleBeer.brand = @"Example: Fosters";
    initialExampleBeer.canVolume = 440;
    initialExampleBeer.alcoholByVolume = [NSDecimalNumber decimalNumberWithString:@"4.0"];
    initialExampleBeer.price = [NSDecimalNumber decimalNumberWithString:@"4.0"];
    initialExampleBeer.numberOfCans = 4;

    
    self.beers = [[NSMutableArray alloc]
             initWithObjects:initialExampleBeer, nil];
    
    [self.tableView reloadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // set up the long press on button
    UILongPressGestureRecognizer *gr = [[UILongPressGestureRecognizer alloc] init];
    [gr setMinimumPressDuration:0.2];
    [gr addTarget:self action:@selector(longPressedAddNewBeverageButton:)];
    [self.navigationController.navigationBar  addGestureRecognizer:gr];
}

- (void) viewDidAppear:(BOOL)animated
{
    self.beverage = myDrinkBeer;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];

    return;
}

- (void) longPressedAddNewBeverageButton:(UILongPressGestureRecognizer*)sender;
{
    // first check the nav-view for plus button frame rough location
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        // set a default rectangle in case we don't find the back button for some reason
        
        CGRect rect = CGRectMake(277, 6, 38, 30);
        // default location
        
        // iterate through the subviews looking for something that looks like it might be the right location to be the back button
        
        for (UIView *subview in self.navigationController.navigationBar.subviews)
        {
            if (subview.frame.origin.x > 270)
            {
                rect = subview.frame;
                break;
            }
        }
        
        // ok, let's get the point of the long press
        
        CGPoint longPressPoint = [sender locationInView:self.navigationController.navigationBar];
        
        // if the long press point in the rectangle then do whatever
        
        CGPoint popoverOrigin = CGPointMake(277 + (38/2), 0);
        
        if (CGRectContainsPoint(rect, longPressPoint))
        {
            // do stuff:
            [PopoverView showPopoverAtPoint:popoverOrigin inView:self.view withTitle:@"Beverage:" withStringArray:[NSArray arrayWithObjects:@"Cider", @"Wine", @"Spirit", nil]  delegate:self];
            
        }
    }
    
    return;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PopoverViewDelegate Methods

- (void)popoverView:(PopoverView *)popoverView didSelectItemAtIndex:(NSInteger)index;
{
    self.beverage = index + 1;
    NSLog(@"%d", self.beverage);
    [self performSegueWithIdentifier: @"initiatePickerView" sender: self];
    [popoverView dismiss];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.beers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"beerCell";
    BeerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    Beer * beer = [beers objectAtIndex:indexPath.row];
    
    // format based on drink type
    
    cell.nameLabel.text = beer.brand;

    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = [NSLocale currentLocale];
    if (self.sortPicker.selectedSegmentIndex == 0)
    {
        cell.priceLabel.text = [formatter stringFromNumber:beer.pricePerUnit];
    }
    else
    {
        cell.priceLabel.text = [formatter stringFromNumber:beer.pricePerVolume];
    }
    
    
    // build string of form "4 x 440ml @ 4.0%, £4.00"
    

    
    // im the 8 lines instead of using a fucking stringBuilder class or operators on strings lol
    
    cell.descriptionLabel.text = [beer getSubtitleStringDescrtiption];
    return cell;
}

- (void) addBeerToList:(Beer *)beer
{
    [self.beers addObject:beer];
    if ([self.beers containsObject:initialExampleBeer]) {
        [self.beers removeObject:initialExampleBeer];
    }
    
    // Google analytics
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Beer added"     // Event category (required)
                                                          action:beer.brand  // Event action (required)
                                                           label:beer.getSubtitleStringDescrtiption          // Event label
                                                           value:nil] build]];    // Event value

    
//    NSError *error;
//	if (![[GAITracker tracker] trackEvent:@"button_click"
//                                         action:@"save_the_world"
//                                          label:@"my_label"
//                                          value:-1
//                                      withError:&amp;error]) {
//		// Handle error here
//	}
    
    // delete the example beer to keep it clean
    [self sortListAppropriately];
    
    [self.tableView reloadData];
    return;
}

- (void) sortListAppropriately
{
    if (self.sortPicker.selectedSegmentIndex == 0) {
        // segment 0 is Price Per Unit
        [self.beers sortUsingComparator:^NSComparisonResult(id a, id b) {
            NSDecimalNumber * first = [(Beer*) a pricePerUnit];
            NSDecimalNumber* second = [(Beer*) b pricePerUnit];
            return [first compare:second];
        }];

    }
    else
    {
        [self.beers sortUsingComparator:^NSComparisonResult(id a, id b) {
            NSDecimalNumber * first = [(Beer*) a pricePerVolume];
            NSDecimalNumber* second = [(Beer*) b pricePerVolume];
            return [first compare:second];
        }];

    }
    [self.tableView reloadData];
    return;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.beers removeObjectAtIndex:indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
    return;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PickerViewController * destVC = [segue destinationViewController];
    destVC.beerTableDelegate = self;
    destVC.beverage = self.beverage;
    UIColor* tintColor;
    switch (self.beverage) {
        case myDrinkBeer:
            tintColor = [UIColor orangeColor];
            break;
        case myDrinkCider:
            tintColor = [UIColor greenColor];
            break;
        case myDrinkWine:
            tintColor = [UIColor redColor];
            break;
        case myDrinkSpirits:
//            tintColor = [UIColor ];
            break;
            
        default:
            break;
    }
    self.navigationController.navigationBar.tintColor = tintColor;
    self.navigationController.navigationBar.backgroundColor = tintColor;
    return;
    //PickerPageViewController * destVC = [segue destinationViewController];
    //destVC.BeerDelegate = self;
    // set the beerdelegate
    
    // TODO: maybe add a class check incase we add other segues and break shit

}



@end
