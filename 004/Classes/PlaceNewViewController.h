//
//  PlaceNewViewController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 24/07/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlaceNewViewControllerDelegate;
@class Place;


@interface PlaceNewViewController : UIViewController {
	Place *place;
	id <PlaceNewViewControllerDelegate> delegate;
	
	@private
	UITextView *textView;	
}

@property (nonatomic, retain) Place *place;
@property (nonatomic, assign) id <PlaceNewViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end

@protocol PlaceNewViewControllerDelegate <NSObject>

- (void)placeNewViewController:(PlaceNewViewController *)controller didSavePlace:(Place *)place;
- (void)placeNewViewController:(PlaceNewViewController *)controller didCancelPlace:(Place *)place;

@end

