//
//  CandyDetailsViewController.h
//  CandyStore
//
//  Created by Jordan on 9/19/14.
//  Copyright (c) 2014 Byjor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Candy.h"

@class Candy;

@interface CandyDetailsViewController : UIViewController

@property (nonatomic, strong) Candy *candy;

@end
