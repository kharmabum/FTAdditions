//
//  FTDebug.h
//  FTStarterApplication
//
//  Created by IO on 1/21/14.
//  Copyright (c) 2014 Fototropik. All rights reserved.
//

#ifndef FTStarterApplication_FTDebug_h
#define FTStarterApplication_FTDebug_h

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Debug
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#define DEBUG_ON  // Toggle to DEBUG_OFF to hide all debug code

#ifdef DEBUG_ON
#define debug(format, …) CFShow((__bridge void *)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
#define debug(format, ...)
#endif

#define debugRect(rect) debug(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect,rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define debugSize(size) debug(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define debugPoint(point) debug(@"%s x:%.4f, y:%.4f", #pt, pt.x, pt.y)

#endif
