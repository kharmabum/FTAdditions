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

#ifdef DEBUG
#define debug(format, ...) CFShow((__bridge void *)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
#define debug(format, ...)
#endif

#ifndef DEBUG
#undef NSLog
#define NSLog(args, ...)
#endif

#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

#define debugRect(rect) debug(@"%s x:%.4f, y:%.4f, w:%.4f, h%.4f", #rect,rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define debugSize(size) debug(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define debugPoint(point) debug(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

#endif
