//
//  PresetValuesHelper.m
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "PresetValuesHelper.h"

@implementation PresetValuesHelper


+(NSArray *) presetBrandsFactory
{
    NSArray * array;
    array = @[ @"Fosters", @"Stella", @"Carlsberg", @"Carling", @"Budweiser", @"Own Brand" ];
    return array;
}

+(NSArray *) presetNumberOfCansFactory
{
    NSArray * array;
    array = @[ @1, @4, @6, @8, @10, @12, @15, @18, @20 ];
    return array;
}

+(NSArray *) presetVolumesFactory
{
    NSArray * array;
    array = @[ @250, @440, @500, @568];
    return array;

}

+(NSArray *) presetABVFactory
{
    NSArray * array;
    array = [NSArray arrayWithObjects:
             [NSDecimalNumber decimalNumberWithString:@"3.8"],
             [NSDecimalNumber decimalNumberWithString:@"4.0"],
             [NSDecimalNumber decimalNumberWithString:@"4.2"],
             [NSDecimalNumber decimalNumberWithString:@"4.4"],
             [NSDecimalNumber decimalNumberWithString:@"4.8"],
             [NSDecimalNumber decimalNumberWithString:@"5.0"],
             nil];
    return array;

    
}

@end
