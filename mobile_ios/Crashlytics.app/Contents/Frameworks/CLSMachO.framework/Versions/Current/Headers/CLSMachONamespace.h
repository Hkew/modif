//
//  CLSMachONamespace.h
//  CLSMachO
//
//  Created by Matt Massicotte on 10/13/12.
//  Copyright (c) 2012 Crashlytics. All rights reserved.
//

#pragma once

// CLSMachONamespacePrefix will be appended to every symbol
#ifndef CLSMachONamespacePrefix
#define CLSMachONamespacePrefix CLS
#endif

// This is a bit if a wacky system for making sure that macros get expanded
// when they are arguments to other macros
#define CLSMachONamespaceConcat(p1, p2) _CLSMachONamespaceConcat(p1, p2)
#define _CLSMachONamespaceConcat(p1, p2) p1 ## p2

// Append the namespace prefix to the identifier.
#define CLSMachONamespace(symbol) CLSMachONamespaceConcat(CLSMachONamespacePrefix, symbol)
