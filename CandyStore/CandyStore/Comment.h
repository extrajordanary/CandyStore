//
//  Comment.h
//  CandyStore
//
//  Created by Jordan on 9/25/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic, copy) NSString* _id;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* timestamp;

#pragma mark - JSON-ification

- (instancetype) initWithDictionary:(NSDictionary*)dictionary;
- (NSDictionary*) toDictionary;

@end
