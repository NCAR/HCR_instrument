#
# Rules to build hcrdds and export it as a SCons tool
#
import os

tools = ['ddssvc','hcrtypes']
env = Environment(tools = ['default'] + tools)

def hcrdds(env):
    env.AppendUnique(CPPPATH = ['#/hcrdds',])
    env.Require(tools)

Export('hcrdds')

