#!/usr/bin/env python

"""@package SpectracomDaemon
A daemon program which periodically collects status information from a 
Spectracom SecureSync time and frequency server and supports an XML-RPC 
interface to provide access to the status information.
"""

import time
import threading
from SocketServer import ThreadingMixIn
from SimpleXMLRPCServer import SimpleXMLRPCServer
from SimpleXMLRPCServer import SimpleXMLRPCRequestHandler

class ThreadingXMLRPCServer(ThreadingMixIn, SimpleXMLRPCServer):
    ### Version of SimpleXMLRPCServer which can be run in a thread
    
    # Ctrl-C will cleanly kill all spawned threads
    daemon_threads = True
    
    # much faster rebinding
    allow_reuse_address = True
    

XMLRPC_PORT = 8008

def getStatus():
    """Handle XML-RPC 'getStatus' requests, returning current Spectracom status.
    """
    print "call to getStatus() method"
    return

if __name__ == "__main__":

    serverXMLRPC = ThreadingXMLRPCServer(('0.0.0.0', XMLRPC_PORT))
    serverXMLRPC.register_function(getStatus)
    server_thread = threading.Thread(target=serverXMLRPC.serve_forever)
    server_thread.start() 
       
    try:
        while (True):
            print "Foo"
            time.sleep(5)
    except KeyboardInterrupt:
        print
        print "exiting on SIGINT"
        
    serverXMLRPC.shutdown()
