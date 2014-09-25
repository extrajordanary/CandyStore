//
//  Comment.m
//  CandyStore
//
//  Created by Jordan on 9/25/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "Comment.h"

#define safeSet(d,k,v) if (v) d[k] = v;

@implementation Comment

#pragma mark - JSON-ification

- (instancetype) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        _text = dictionary[@"text"];
        _timestamp = dictionary[@"timestamp"];
        __id = dictionary[@"_id"];
    }
    return self;
}

- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    safeSet(jsonable, @"name", self.name);
    safeSet(jsonable, @"text", self.text);
    safeSet(jsonable, @"timestamp", self.timestamp);
    safeSet(jsonable, @"_id", self._id);
    return jsonable;
}

@end
