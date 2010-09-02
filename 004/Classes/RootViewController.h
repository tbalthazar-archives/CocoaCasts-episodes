//
//  RootViewController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 13/07/10.
//  Copyright Suit My Mind SPRL 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PlaceNewViewController.h"

@interface RootViewController : UITableViewController <
	NSFetchedResultsControllerDelegate,
	PlaceNewViewControllerDelegate
> {

@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
