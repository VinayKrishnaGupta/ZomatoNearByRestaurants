//
//  ViewController.h
//  ZomatoRestaurantSearchByLocation
//
//  Created by IAUGMENTOR on 04/04/17.
//  Copyright © 2017 Vinay Krishna Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *SearchBar;
- (IBAction)SearchButton:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

