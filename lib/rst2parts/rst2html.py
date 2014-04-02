#!/usr/bin/env python

try:
    import locale
    locale.setlocale(locale.LC_ALL, '')
except:
    pass

import sys
from transform import transform
from docutils.writers.html4css1 import Writer

def main():
    return transform(writer=Writer(), part='html_body')

if __name__ == '__main__':
    sys.stdout.write(main())
