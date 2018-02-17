//
//  detailTableViewCell.h
//  Testcode
//
//  Created by Thabu on 12/02/18.
//  Copyright © 2018 gopinath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailTableViewCell : UITableViewCell
//This is for declare the UItablevie Cell UILable
@property (weak, nonatomic) IBOutlet UILabel *descriptionlable;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;
//This is for declare the UItablevie Cell UIImage
@property (weak, nonatomic) IBOutlet UIImageView *imagecell;

@end
