//
//  ViewController.h
//  Testcode
//
//  Created by Thabu on 12/02/18.
//  Copyright © 2018 gopinath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "detailTableViewCell.h"
#import "MBProgressHUD.h"


@interface ViewController : UIViewController<NSURLSessionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    
    // This is a decalre the dictionary and array .
    NSDictionary * resonsedictonary;
    // This is a decalre the Refresh of functionality.
    UIRefreshControl *refreshControl;
    // This is a decalre the  array .
    NSArray * resonsdetails;
    
    
}

// This is a connected the UITablevie.
@property (weak, nonatomic) IBOutlet UITableView *detailtable;


@end

