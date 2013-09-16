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

@interface BeerTableController ()

@end

@implementation BeerTableController
@synthesize beers;

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
    
    
    // [self.tableView setContentInset:UIEdgeInsetsMake(20.0f, self.tableView.contentInset.left, self.tableView.contentInset.bottom, self.tableView.contentInset.right)];
    // adjust insets for iOS 7
    // uncomment if we decide to remove nav bar
    
    
    // set up and initialize our example Beer
    
    Beer * initialExampleBeer = [Beer alloc];
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.nameLabel.text = beer.brand;

    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.locale = [NSLocale currentLocale];
    
    cell.priceLabel.text = [formatter stringFromNumber:beer.pricePerVolume];
    
    NSMutableString * descriptionString = [[NSMutableString alloc] init];
    
    // build string of form "4 x 440ml @ 4.0%, £4.00"
    
    [descriptionString appendString:[@(beer.numberOfCans) stringValue]];
    [descriptionString appendString:@" x "];
    [descriptionString appendString:[@(beer.canVolume) stringValue]];
    [descriptionString appendString:@"ml @ "];
    [descriptionString appendString:beer.alcoholByVolume.stringValue];
    [descriptionString appendString:@"%, "];
    [descriptionString appendString:[formatter stringFromNumber:beer.price]];
    
    // im the 8 lines instead of using a fucking stringBuilder class or operators on strings lol
    
    cell.descriptionLabel.text = descriptionString;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
