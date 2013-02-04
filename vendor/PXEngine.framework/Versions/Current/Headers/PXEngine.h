//
//  PXEngine.h
//  PXEngine
//
//  Created by Paul Colton on 12/11/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PXEngine/PXStylesheet.h>
#import <PXEngine/UIView+PXStyling.h>
#import <PXEngine/NSDictionary+PXCSSEncoding.h>
#import "PXEngineConfiguration.h"

/**
 * This is the main entry point into the Pixate Engine
 */
@interface PXEngine : NSObject

/**
 * The build date of this version of the Pixate Engine
 */
@property (nonatomic, strong, readonly) NSString *version;

/**
 * The build date of this version of the Pixate Engine
 */
@property (nonatomic, strong, readonly) NSDate *buildDate;

/**
 * The email address used for licensing
 */
@property (nonatomic, strong, readonly) NSString *licenseEmail;

/**
 * The user name used for licensing
 */
@property (nonatomic, strong, readonly) NSString *licenseKey;

/**
 * If set to YES, will only style if styleId or styleClass is set
 */
@property (nonatomic) BOOL checkStyle;

/**
 * This property, when set to YES, automatically refreshes
 * styling when the orientation of your device changes. This is
 * set to NO by default.
 */
@property (nonatomic) BOOL refreshStylesWithOrientationChange;

/**
 *  A property used to configure options in the PXEngine
 */
@property (nonatomic, strong) PXEngineConfiguration *configuration;

/**
 * The shared instance of the PXEngine singleton.
 */
+ (PXEngine *)sharedInstance;

/**
 *  Set the license key and license serial number into the Pixate
 *  Engine. This is required before styling can occur.
 *
 *  @param licenseKey The serial number of your license
 *  @param licenseEmail The user of the license, usually an email address
 */
+ (void) licenseKey:(NSString *)licenseKey forUser:(NSString *)licenseEmail;

/**
 *  Return a collection of all styleables that match the specified selector. Note that the selector runs against views
 *  that are in the current view tree only.
 *
 *  @param styleable The root of the tree to search
 *  @param source The selector to use for matching
 */
+ (NSArray *)selectFromStyleable:(id<PXStyleable>)styleable usingSelector:(NSString *)source;

/**
 *  Return a string representation of all active rule sets matching the specified styleable
 *
 *  @param styleable The styleable to match
 */
+ (NSString *)matchingRuleSetsForStyleable:(id<PXStyleable>)styleable;

/**
 *  Return a string representation of all active declarations that apply to the specified styleable. Note that the list
 *  shows the result of merging all matching rule sets, taking specificity and duplications into account.
 *
 *  @param styleable The styleable to match
 */
+ (NSString *)matchingDeclarationsForStyleable:(id<PXStyleable>)styleable;

@end
