#
# Rules to build SpectracomRpcClient class and export it (and its headers) as a tool
#
tools = Split("""
    archive_xmlrpc_c
    logx
    xmlrpc_client++
    boost_serialization
""")
env = Environment(tools=['default'] + tools)

# The object file and header file live in this directory.
tooldir = env.Dir('.').srcnode().abspath    # this directory
includeDir = tooldir

sources = Split('''
SpectracomRpcClient.cpp
SpectracomStatus.cpp
''')
lib = env.Library('spectracomrpcclient', sources)
Default(lib)
    
def SpectracomRpcClient(env):
    env.AppendUnique(CPPPATH = [includeDir])
    env.Append(LIBS = [lib])
    env.Require(tools)

Export('SpectracomRpcClient')
