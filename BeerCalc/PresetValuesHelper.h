//
//  PresetValuesHelper.h
//  BeerCalc
//
//  Created by Josh Palmer on 16/09/2013.
//  Copyright (c) 2013 Josh Palmer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresetValuesHelper : NSObject

+(NSArray *) presetBrandsFactory;
+(NSArray *) presetNumberOfCansFactory;
+(NSArray *) presetVolumesFactory;
+(NSArray *) presetABVFactory;

@end
