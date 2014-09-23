//
//  CandyStore.h
//  CandyStore
//
//  Created by Jordan on 9/22/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Candy : NSManagedObject

@property (nonatomic, retain) NSNumber * locationLat;
@property (nonatomic, retain) NSNumber * locationLon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * picturePath;

@end
