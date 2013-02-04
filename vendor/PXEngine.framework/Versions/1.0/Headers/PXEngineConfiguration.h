//
//  PXEngineConfiguration.h
//  PXEngine
//
//  Created by Kevin Lindsey on 1/23/13.
//  Copyright (c) 2013 Pixate, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXStyleable.h"

typedef enum {
    PXParseErrorDestination_None,
    PXParseErrorDestination_Console,
#ifdef PX_LOGGING
    PXParseErrorDestination_Logger
#endif
} PXParseErrorDestination;

typedef enum {
    PXUpdateStylesType_Auto,
    PXUpdateStylesType_Manual,
} PXUpdateStylesType;

typedef enum {
    PXCacheStylesType_Auto,
    PXCacheStylesType_None,
} PXCacheStylesType;

@interface PXEngineConfiguration : NSObject <PXStyleable>

@property (nonatomic, copy) NSString *styleId;
@property (nonatomic, copy) NSString *styleClass;

@property (nonatomic) PXParseErrorDestination parseErrorDestination;
@property (nonatomic) PXUpdateStylesType updateStylesType;
@property (nonatomic) PXCacheStylesType cacheStylesType;

/*
 *  Return the property value for the specifified property name
 *
 *  @param name The name of the property
 */
- (id)propertyValueForName:(NSString *)name;

/*
 *  Set the property value for the specified property name
 *
 *  @param value The new value
 *  @param name The property name
 */
- (void)setPropertyValue:(id)value forName:(NSString *)name;

/**
 *  Log the specified message to the target indicated by the loggingType property
 *
 *  @param message The message to emit
 */
- (void)sendParseMessage:(NSString *)message;

@end
