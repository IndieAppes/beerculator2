//
//  Beer.m
//  BeerCalc
//
//  Created by Josh Palmer on 15/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import "Beer.h"

@implementation Beer

@synthesize brand;
@synthesize numberOfCans;
@synthesize canVolume;
@synthesize alcoholByVolume;
@synthesize price;

- (NSDecimalNumber *) pricePerVolume
{
    NSNumber * number = [NSNumber numberWithInt:(canVolume * numberOfCans)];
    
    NSDecimalNumber * quotientDecimal = [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    NSDecimalNumber * anotherDumbIntermediateStep = [NSDecimalNumber decimalNumberWithString:@"1000"];
    anotherDumbIntermediateStep = [anotherDumbIntermediateStep decimalNumberByDividingBy:quotientDecimal];
    
    NSDecimalNumber * decimal = [price decimalNumberByMultiplyingBy:alcoholByVolume];
    
    return [decimal decimalNumberByDividingBy:anotherDumbIntermediateStep];
}


@end
