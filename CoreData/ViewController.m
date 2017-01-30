//
//  ViewController.m
//  CoreData
//
//  Created by Amanpreet Singh on 30/01/17.
//  Copyright © 2017 Amanpreet Singh. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(persistentContainer)]) {
        context = [[delegate persistentContainer] viewContext];
    }
    return context;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Core Data Demo";
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)SaveClicked:(id)sender {
    
    
    NSManagedObjectContext *context=[self managedObjectContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    NSLog(@"name entered is %@",_UITextFieldName.text);
    NSLog(@"address entered is %@",_UITextFieldAddress.text);
    NSLog(@"contact no entered is %@",_UITextFieldContactNo.text);


    
    [newDevice setValue:self.UITextFieldName.text forKey:@"name"];
    [newDevice setValue:self.UITextFieldContactNo.text forKey:@"contactNo"];
    [newDevice setValue:self.UITextFieldAddress.text forKey:@"address"];
    self.UITextFieldName.text=@"";
    self.UITextFieldAddress.text=@"";
    self.UITextFieldContactNo.text=@"";


    
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"" message:@"Data saved Successfully" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
    
}

- (IBAction)ViewEmployeeDetailsClicked:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *secondObj=[storyBoard instantiateViewControllerWithIdentifier:@"Second"];
    [self.navigationController pushViewController:secondObj animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
