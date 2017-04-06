//
//  RestaurantListTVC.m
//  ZomatoRestaurantSearchByLocation
//
//  Created by IAUGMENTOR on 04/04/17.
//  Copyright © 2017 Vinay Krishna Gupta. All rights reserved.
//

#import "RestaurantListTVC.h"
#import "AFNetworking.h"
#import "WebViewC.h"
@interface RestaurantListTVC () {
    NSMutableArray *NearByRestaurantList;
    NSString *RestaurantURL;
    
    
}

@end

@implementation RestaurantListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self ;
    _tableView.dataSource = self;
    self.navigationItem.title = @"Restaurants" ;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    NearByRestaurantList = [[NSMutableArray alloc] init];
    NSString *LATITUDE = [NSString stringWithFormat:@"%@",[_SelectedLocation valueForKey:@"latitude"]];
    NSString *LONGITUDE = [NSString stringWithFormat:@"%@",[_SelectedLocation valueForKey:@"longitude"]];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:LATITUDE, @"lat", LONGITUDE, @"lon",  nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"https://developers.zomato.com/api/v2.1/geocode"] parameters: parameters error:nil];
    [req setValue:@"c750173e8cf7e5fdc2c331cf897ee8c3" forHTTPHeaderField:@"user-key"];
    
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            NSLog(@"Reply JSON for detail: %@", responseObject);
            for (id item in [responseObject valueForKeyPath:@"nearby_restaurants.restaurant"]) {
                [NearByRestaurantList addObject:item];
            }
            
            
            [_tableView reloadData];
            
        }
        
        else
        {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];

    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NearByRestaurantList.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dict = [NearByRestaurantList objectAtIndex:indexPath.section];
    cell.textLabel.text = [dict valueForKey:@"name"];
    cell.detailTextLabel.text = [dict valueForKey:@"cuisines"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imagedata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"thumb"]]]];
         UIImage *Moduleimage = [[UIImage alloc]initWithData:imagedata];
    
    dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
            cell.backgroundView = [[UIImageView alloc] initWithImage:Moduleimage];
        });
        
    });
    
    

            
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [NearByRestaurantList objectAtIndex:indexPath.section];
    RestaurantURL = [[NSString alloc]init];
    RestaurantURL = [dict valueForKey:@"url"];
    [self performSegueWithIdentifier:@"RestaurantDetails" sender:self];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewC *RestaurantList = segue.destinationViewController;
    RestaurantList.URLString = RestaurantURL;
    
}




@end
