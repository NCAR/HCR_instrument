#!/usr/bin/env python

if __name__ == "__main__":

    import xmlrpclib
    import time
    
    s = xmlrpclib.ServerProxy('http://localhost:8008')
    
    try:
        print s.getStatus()
    except Exception as x:
        print "error calling getStatus():", x
