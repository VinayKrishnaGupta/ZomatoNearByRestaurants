//
//  ViewController.m
//  ZomatoRestaurantSearchByLocation
//
//  Created by IAUGMENTOR on 04/04/17.
//  Copyright © 2017 Vinay Krishna Gupta. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "RestaurantListTVC.h"

@interface ViewController () {
    NSMutableArray *locationsuggestions ;
    NSDictionary *selectedLocation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self ;
    _tableView.delegate = self;
    self.navigationItem.title = @"Zomanto";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)SearchButton:(UIButton *)sender {
    
    NSString *SearchBarText = _SearchBar.text ;
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:SearchBarText,@"query", nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"https://developers.zomato.com/api/v2.1/locations"] parameters: parameters error:nil];
    [req setValue:@"c750173e8cf7e5fdc2c331cf897ee8c3" forHTTPHeaderField:@"user-key"];
    
    
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error)
        {
            NSLog(@"Reply JSON for detail: %@", responseObject);
            locationsuggestions = [[NSMutableArray alloc]init];
            locationsuggestions = [responseObject valueForKeyPath:@"location_suggestions"];
            [_tableView reloadData];
            
        }
        
        else
        {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return locationsuggestions.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dict = [locationsuggestions objectAtIndex:indexPath.section];
    
    cell.textLabel.text = [dict valueForKey:@"title"];
    cell.detailTextLabel.text = [dict valueForKey:@"city_name"];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedLocation = [locationsuggestions objectAtIndex:indexPath.section];
    [self performSegueWithIdentifier:@"RestaurantList" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    RestaurantListTVC *newVC = segue.destinationViewController;
    newVC.SelectedLocation = selectedLocation;

    
    
}




@end
