//
//  PresetValuesHelper.h
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum beverageType
{
    myDrinkBeer,
    myDrinkCider,
    myDrinkWine,
    myDrinkSpirits,
} beverageType;

typedef enum beerStages
{
    myBeerBrand,
    myBeerNumberOfCans, // use this for spirit type or wine type? (or even skip for wine)
    myBeerCanVolume,
    myBeerAlcoholByVolume,
    myBeerPrice
} beerStage;


@interface PresetValuesHelper : NSObject


+(NSArray *) presetBrandsFactoryWithBeverageType:(beverageType)beverage;
+(NSArray *) presetNumberOfCansFactoryWithBeverageType:(beverageType)beverage;
+(NSArray *) presetVolumesFactoryWithBeverageType:(beverageType)beverage;
+(NSArray *) presetABVFactoryWithBeverageType:(beverageType)beverage;
+(NSString *) titleFactoryWithBeverageType:(beverageType)beverage andStage:(beerStage)stage;
+(NSString *) logTitleFactoryWithBeverageType:(beverageType)beverage andStage:(beerStage)stage;





@end


