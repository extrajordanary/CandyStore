//
//  CommentLog.m
//  CandyStore
//
//  Created by Jordan on 9/25/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import "CommentLog.h"
#import "Comment.h"

static NSString* const kBaseURL = @"http://localhost:3000/";
static NSString* const kComments = @"comments2";
static NSString* const kFiles = @"files";

@interface CommentLog ()
@end

@implementation CommentLog

- (id)init
{
    self = [super init];
    if (self) {
        self.objects = [NSMutableArray array];
    }
    return self;
}

- (void) addComment:(Comment *)comment
{
    [self.objects addObject:comment];
}

- (void)parseAndAddComments:(NSArray*)comments toArray:(NSMutableArray*)destinationArray //1
{
    for (NSDictionary* item in comments) {
        Comment* comment = [[Comment alloc] initWithDictionary:item]; //2
        
        // rule out duplicate entries
        BOOL duplicate = NO;
        for (int i = 0; i < [destinationArray count]; i++) {
            Comment *existingComment = destinationArray[i];
            if ([comment._id isEqualToString:existingComment._id]) {
                duplicate = YES;
                break;
            }
        }
        if (!duplicate) {
            [destinationArray addObject:comment];
        }
    }
}

- (void)import:(void (^)())block
{
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kComments]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
                                                    if (error == nil) {
                                                        NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
                                                        [self parseAndAddComments:responseArray toArray:self.objects]; //7
                                                        block();
                                                    }
                                                }];
    
    [dataTask resume]; //8
}

- (void) persist:(Comment*)comment withUpdate:(void (^)())block
{
    if (!comment || comment.text == nil || comment.text.length == 0) {
        return; //input safety check
    }
    
    NSString* comments = [kBaseURL stringByAppendingPathComponent:kComments];
    
    BOOL isExistingComment = comment._id != nil;
    NSURL* url = isExistingComment ? [NSURL URLWithString:[comments stringByAppendingPathComponent:comment._id]] :
    [NSURL URLWithString:comments]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = isExistingComment ? @"PUT" : @"POST"; //2
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:[comment toDictionary] options:0 error:NULL]; //3
    request.HTTPBody = data;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            [self parseAndAddComments:responseArray toArray:self.objects];
            block();
        }
    }];
    [dataTask resume];
}

@end
