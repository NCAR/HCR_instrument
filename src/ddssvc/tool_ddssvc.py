#
# Rules to build ddssvc and export it as a SCons tool
#
import os

tools = ['opendds', 'hcrtypes']
env = Environment(tools = ['default'] + tools)

def ddssvc(env):
    env.AppendLibrary('ddssvc')
    env.AppendUnique(CPPPATH = ['#/ddssvc',])
    env.Require(tools)

Export('ddssvc')

# sources
sources = Split("""
DDSPublisher.cpp
DDSSubscriber.cpp
""")

lib = env.Library('ddssvc', sources)

Default(lib)
