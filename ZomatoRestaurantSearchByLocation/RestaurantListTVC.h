//
//  RestaurantListTVC.h
//  ZomatoRestaurantSearchByLocation
//
//  Created by IAUGMENTOR on 04/04/17.
//  Copyright © 2017 Vinay Krishna Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantListTVC : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property(retain,nonatomic)NSDictionary *SelectedLocation ;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
