//
//  SecondViewController.h
//  CoreData
//
//  Created by Amanpreet Singh on 30/01/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic) IBOutlet UITableView *tabelView;

@property(weak,nonatomic) IBOutlet UILabel *name;
@property(weak,nonatomic) IBOutlet UITextField *updatedContactNo;
@property(weak,nonatomic) IBOutlet UIView *updateView;





@end
