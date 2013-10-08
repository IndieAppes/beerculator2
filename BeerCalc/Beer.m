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

-(id)init {
    self = [super init];
    if (self) {
        // do stuff
        brand = [[NSString alloc] init];
    }
    return self;
}

- (NSDecimalNumber *) pricePerUnit
{
    NSNumber * number = [NSNumber numberWithInt:(canVolume * numberOfCans)];
    
    NSDecimalNumber * quotientDecimal = [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    
    NSDecimalNumber * anotherDumbIntermediateStep = [NSDecimalNumber decimalNumberWithString:@"1000"];
    anotherDumbIntermediateStep = [anotherDumbIntermediateStep decimalNumberByDividingBy:quotientDecimal];
        
    NSDecimalNumber * decimal = [price decimalNumberByDividingBy:alcoholByVolume];
    
    return [decimal decimalNumberByMultiplyingBy:anotherDumbIntermediateStep];
}

- (NSDecimalNumber* ) pricePerVolume
{
    NSNumber * totalVolume = [NSNumber numberWithFloat:(canVolume * numberOfCans)/1000.0];
    NSDecimalNumber * totalDecimalVolume = [NSDecimalNumber decimalNumberWithDecimal:[(totalVolume) decimalValue]];
    
    NSDecimalNumber * pricePerMl = price;
    pricePerMl = [pricePerMl decimalNumberByDividingBy:totalDecimalVolume];
    // TODO: implement this
    return pricePerMl;
}

@end
