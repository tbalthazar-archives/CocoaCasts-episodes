//
//  PlaceDetailsViewController.h
//  TapPlace
//
//  Created by Thomas Balthazar on 30/08/10.
//  Copyright 2010 Suit My Mind SPRL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Place;
@protocol PlaceDetailsViewControllerDelegate;

@interface PlaceDetailsViewController : UIViewController <UIActionSheetDelegate> {
	UITextView *textView;
	UIToolbar *toolbar;
	
	id <PlaceDetailsViewControllerDelegate> delegate;

	@private
	Place *place;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, assign) id <PlaceDetailsViewControllerDelegate> delegate;
@property (nonatomic, retain) Place *place;

@end

@protocol PlaceDetailsViewControllerDelegate <NSObject>

- (void)placeDetailsViewController:(PlaceDetailsViewController *)controller 
					didUpdatePlace:(Place *)place;
- (void)placeDetailsViewController:(PlaceDetailsViewController *)controller 
			   didAskToDeletePlace:(Place *)place;

@end