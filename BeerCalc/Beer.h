//
//  Beer.h
//  BeerCalc
//
//  Created by Josh Palmer on 15/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject

@property (nonatomic, copy) NSString * brand;
@property (nonatomic, assign) int numberOfCans;
@property (nonatomic, assign) int canVolume;
@property (nonatomic, copy) NSDecimalNumber * alcoholByVolume;
@property (nonatomic, copy) NSDecimalNumber * price;

- (NSDecimalNumber *) pricePerVolume;
- (NSDecimalNumber *) pricePerUnit;
- (NSString *) getSubtitleStringDescrtiption;

@end
