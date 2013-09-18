//
//  UIBarButtonItem+PXStyling.h
//  Pixate
//
//  Created by Kevin Lindsey on 12/11/12.
//  Copyright (c) 2012 Pixate, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Pixate/PXVirtualControl.h>

/**
 *
 *  UIBarButtonItem supports the following element name:
 *
 *  - bar-button-item
 *
 *  UIBarButtonItem supports the following  children:
 *
 *  - icon
 *
 *  UIBarButtonItem icon supports the following properties:
 *
 *  - PXShapeStyler
 *  - PXFillStyler
 *  - PXBorderStyler
 *  - PXBoxShadowStyler
 *  - -ios-rendering-mode: original | template | automatic (iOS7 only)
 *
 *  UIBarButtonItem supports the following properties:
 *
 *  - PXFillStyler
 *  - PXBorderStyler
 *  - PXTextContentStyler
 */
@interface UIBarButtonItem (PXStyling) <PXVirtualControl>

// make styleParent writeable here
@property (nonatomic, readwrite, weak) id pxStyleParent;

@end
