//
//  CommentLog.h
//  CandyStore
//
//  Created by Jordan on 9/25/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comment;

@interface CommentLog : NSObject

- (void) addComment:(Comment*)comment;

- (void) import;
- (void) persist:(Comment*)comment;

@end
