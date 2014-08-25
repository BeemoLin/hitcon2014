#!/usr/bin/python
# coding: utf-8

import os
import re
import sys
import cgi
import hashlib
from urllib import unquote
from passlib.utils.pbkdf2 import pbkdf2

def _pbkdf2(text):
    return pbkdf2(text, 'noggnogg', 1337).encode('hex').lower()

def _md5(text):
    return hashlib.md5( text ).hexdigest().lower()

def getenv(name):
    return unquote( os.environ.get(name) ) or ''

def gotoFail():
    print 'goto fail'
    print
    exit()

def m_hash(password):
    nr = 1345345333 
    add = 7
    nr2 = 305419889
    
    for c in (ord(x) for x in password if x not in (' ', '\t')):
        nr^= (((nr & 63)+add)*c)+ (nr << 8) & 0xFFFFFFFF
        print ("%08x" % (nr & 0x7FFFFFFF))
        nr2= (nr2 + ((nr2 << 8) ^ nr)) & 0xFFFFFFFF
        print ("%08x" % (nr2 & 0x7FFFFFFF))
        add= (add + c) & 0xFFFFFFFF
        print "-->"
    return "%08x%08x" % (nr & 0x7FFFFFFF,nr2 & 0x7FFFFFFF)
###

aaa = m_hash('password')
print(aaa)
print "4141414141414141"
