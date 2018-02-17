//
//  ViewController.m
//  Testcode
//
//  Created by Thabu on 12/02/18.
//  Copyright © 2018 gopinath. All rights reserved.
//

#import "ViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // This is a decalre the web services cell.
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // This code using for refreshing the data.
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refresh the data"];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    // adding the refresh controller  to uitablevie
    [self.detailtable addSubview:refreshControl];
    
    
    // Calling  the web services
    [self servicescall];
    
}
// Calling  the Refresh function

-(void)refreshTable {
    [self.detailtable reloadData];
    [refreshControl endRefreshing];
}

//code for getting the reponses from services.

-(void)servicescall
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"]];
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        NSData *objectData = [requestReply dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:NULL];
        
        NSLog(@"the the %@",json);
        
        NSLog(@"the dis%lu", (unsigned long)[json objectForKey:@"rows"]);
        
        resonsdetails = [json objectForKey:@"rows"];
        //title is  set to the navigation bar
        self.navigationItem.title = [NSString stringWithFormat:@"%@",[json objectForKey:@"title"]];
        //reload the table after the getting the resopnese
        [self.detailtable reloadData];
        
        
    }] resume];
    
 }

// This is for UITablevie datasource and delegate

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [resonsdetails count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    static NSString *simpleTableIdentifier = @"cell";
    
    detailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        cell = [[detailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSString * titlestring = [resonsdetails objectAtIndex:indexPath.row][@"title"];
    NSString * descriptionstring =[resonsdetails objectAtIndex:indexPath.row][@"description"];
    NSString * imagestring =[resonsdetails objectAtIndex:indexPath.row][@"imageHref"];
    NSLog(@"the string value%@",imagestring);
    
    // checking the null titles from services
    if ((titlestring == (id)[NSNull null] || titlestring.length == 0 ))
        
    {
        cell.titlelable.text = @"N/A";
    
    }
    else
    {
    cell.titlelable.text = [NSString stringWithFormat:@"%@",titlestring];
        
    }
    
    // checking the null Description from services
    
    if ((descriptionstring == (id)[NSNull null] || descriptionstring.length == 0 ))
    {
         cell.descriptionlable.text = @"N/A";
    }
    else
    {
       cell.descriptionlable.text =[NSString stringWithFormat:@"%@",descriptionstring];
    }
    
    // checking the null image url from services
    
    if ((imagestring == (id)[NSNull null] || imagestring.length == 0 ))
    {
        
        UIImage *image = [UIImage imageNamed: @"empty.png"];
     //   Once you have an Image you can then set UIImageView:
        
        [cell.imagecell setImage:image];
        
            }
    else{
        
        NSLog(@"loading %@",imagestring);
        /// this is  Lazy loading the image in UITableview ,

        NSURL *imgurl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",imagestring]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // see if the cell is still visible ... it's possible the user has scrolled the cell so it's no longer visible, but the cell has been reused for another indexPath
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgurl]];
            
            [cell.imagecell setImage:img];
            
        }];

        
           }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
