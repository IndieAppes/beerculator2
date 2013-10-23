//
//  PresetValuesHelper.m
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PresetValuesHelper.h"

@implementation PresetValuesHelper


+(NSArray *) presetBrandsFactoryWithBeverageType:(beverageType)beverage
{
    NSArray * array;
    switch (beverage) {
        case myDrinkBeer:
            array = @[ @"Fosters", @"Stella", @"Carlsberg", @"Carling", @"Budweiser", @"Own Brand" ];
            break;
        case myDrinkCider:
            array = @[@"Bulmers", @"Strongbow", @"Gaymers", @"Kopparberg", @"Brothers", @"Magners", @"Own Brand", @"White Cider", @"Scrumpy cider"];
            break;
        case myDrinkSpirits:
            array = @[@"Vodka", @"Whiskey", @"Light Rum", @"Dark Rum", @"Gin", @"Tequila", @"Liqueur"];
            break;
        case myDrinkWine:
            array = @[@"Shiraz", @"Chardonnay", @"Merlot", @"Champagne", @"Rose", @"Pinot Grigio", @"Sauvignon Blanc"];
            break;
        default:
            break;
    }
    return array;
}

+(NSArray *) presetNumberOfCansFactoryWithBeverageType:(beverageType)beverage
{
    NSArray * array;
    switch (beverage) {
        case myDrinkBeer:
        case myDrinkCider:
            array = @[ @1, @3, @4, @6, @8, @10, @12, @15, @18, @20 ];
            break;
        case myDrinkWine:
        case myDrinkSpirits:
        // skip this stage for wine/spirits
        default:
            break;
    }
    return array;
}

+(NSArray *) presetVolumesFactoryWithBeverageType:(beverageType)beverage
{
    NSArray * array;
    switch (beverage) {
        case myDrinkBeer:
            array = @[ @250, @284, @300, @330, @440, @500, @568];
            break;
        
        case myDrinkCider:
            array = @[ @440, @500, @568, @600, @1000, @1500, @2000, @3000];
            break;
        case myDrinkWine:
            array = @[ @125, @175, @250, @700, @3000];
            break;
        case myDrinkSpirits:
            array = @[ @25, @30, @50, @350, @500, @700, @1000];
            break;
        default:
            break;
    }
    return array;

}

+(NSArray *) presetABVFactoryWithBeverageType:(beverageType)beverage
{
    NSArray * array;
    switch (beverage) {
        case myDrinkBeer:
            array = [NSArray arrayWithObjects:
                     [NSDecimalNumber decimalNumberWithString:@"3.8"],
                     [NSDecimalNumber decimalNumberWithString:@"4.0"],
                     [NSDecimalNumber decimalNumberWithString:@"4.2"],
                     [NSDecimalNumber decimalNumberWithString:@"4.4"],
                     [NSDecimalNumber decimalNumberWithString:@"4.8"],
                     [NSDecimalNumber decimalNumberWithString:@"5.0"],
                     nil];
            break;
        case myDrinkCider:
            array = [NSArray arrayWithObjects:
                     [NSDecimalNumber decimalNumberWithString:@"4.0"],
                     [NSDecimalNumber decimalNumberWithString:@"4.5"],
                     [NSDecimalNumber decimalNumberWithString:@"4.8"],
                     [NSDecimalNumber decimalNumberWithString:@"5.0"],
                     [NSDecimalNumber decimalNumberWithString:@"7.5"],
                     nil];
            break;
        
        case myDrinkWine:
            array = [NSArray arrayWithObjects:
                     [NSDecimalNumber decimalNumberWithString:@"10.0"],
                     [NSDecimalNumber decimalNumberWithString:@"11.0"],
                     [NSDecimalNumber decimalNumberWithString:@"11.5"],
                     [NSDecimalNumber decimalNumberWithString:@"12.0"],
                     [NSDecimalNumber decimalNumberWithString:@"12.5"],
                     [NSDecimalNumber decimalNumberWithString:@"13.0"],
                     [NSDecimalNumber decimalNumberWithString:@"13.5"],
                     [NSDecimalNumber decimalNumberWithString:@"20.0"],
                     nil];
            break;
        
        case myDrinkSpirits:
            array = [NSArray arrayWithObjects:
                     [NSDecimalNumber decimalNumberWithString:@"37.5"],
                     [NSDecimalNumber decimalNumberWithString:@"40.0"],
                     [NSDecimalNumber decimalNumberWithString:@"42.5"],
                     [NSDecimalNumber decimalNumberWithString:@"45.0"],
                     [NSDecimalNumber decimalNumberWithString:@"50.0"],
                     nil];
            break;
            

        default:
            break;
    }
    return array;
}

+(NSString *) titleFactoryWithBeverageType:(beverageType)beverage andStage:(beerStage)stage;
{
    NSString* navbarTitle;
    switch (stage) {
            
        // brand/type picker titles
            
        case myBeerBrand:
            switch (beverage) {
                case myDrinkBeer:
                    navbarTitle = @"Beer Name";
                    break;
                    
                case myDrinkCider:
                    navbarTitle = @"Cider Brand/Type";
                    break;
                    
                case myDrinkSpirits:
                    navbarTitle = @"Spirit Type";
                    break;
                
                case myDrinkWine:
                    navbarTitle = @"Wine Type";
                    break;
                default:
                    break;
            }
            break;
        
        // number of cans titles
            
        case myBeerNumberOfCans:
            switch (beverage) {
                case myDrinkBeer:
                case myDrinkCider:
                    navbarTitle = @"Number Of Cans";
                    break;
                case myDrinkWine:
                case myDrinkSpirits:
                // skip this stage
                default:
                    break;
            }
            break;
            
        case myBeerAlcoholByVolume:
            navbarTitle = @"Percentage Alcohol By Volume";
            break;
        
        case myBeerCanVolume:
            switch (beverage) {
                case myDrinkBeer:
                case myDrinkCider:
                    navbarTitle = @"Volume Of Each Can";
                    break;
                case myDrinkWine:
                case myDrinkSpirits:
                    navbarTitle = @"Bottle Volume";
                    break;
                default:
                    break;
            }
            break;
            
        case myBeerPrice:
            navbarTitle = @"Price";
            break;
        default:
            break;
    }
    
    return navbarTitle;
}

+(NSString *) logTitleFactoryWithBeverageType:(beverageType)beverage andStage:(beerStage)stage
{
    NSString* logTitle = [[NSString alloc] init];
    switch (beverage) {
        case myDrinkBeer:
            logTitle = @"Beer";
            break;
        case myDrinkCider:
            logTitle = @"Cider";
            break;
        case myDrinkWine:
            logTitle = @"Wine";
            break;
        case myDrinkSpirits:
            logTitle = @"Spirits";
            break;
        default:
            break;
    }
    
    logTitle = [logTitle stringByAppendingString:@" - "];
    switch (stage) {
        case myBeerBrand:
            logTitle = [logTitle stringByAppendingString:@"Brand"];
            break;
        case myBeerNumberOfCans:
            logTitle = [logTitle stringByAppendingString:@"Number of Cans"];
            break;
        case myBeerAlcoholByVolume:
            logTitle = [logTitle stringByAppendingString:@"ABV"];
            break;
        case myBeerCanVolume:
            logTitle = [logTitle stringByAppendingString:@"Can Volume"];
            break;
        case myBeerPrice:
            logTitle = [logTitle stringByAppendingString:@"Price"];
            break;

        default:
            break;
    }
    
    return logTitle;
}


@end
