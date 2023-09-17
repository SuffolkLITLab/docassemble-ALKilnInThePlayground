import os
import sys
from setuptools import setup, find_packages
from fnmatch import fnmatchcase
from distutils.util import convert_path

standard_exclude = ('*.pyc', '*~', '.*', '*.bak', '*.swp*')
standard_exclude_directories = ('.*', 'CVS', '_darcs', './build', './dist', 'EGG-INFO', '*.egg-info')

def find_package_data(where='.', package='', exclude=standard_exclude, exclude_directories=standard_exclude_directories):
    out = {}
    stack = [(convert_path(where), '', package)]
    while stack:
        where, prefix, package = stack.pop(0)
        for name in os.listdir(where):
            fn = os.path.join(where, name)
            if os.path.isdir(fn):
                bad_name = False
                for pattern in exclude_directories:
                    if (fnmatchcase(name, pattern)
                        or fn.lower() == pattern.lower()):
                        bad_name = True
                        break
                if bad_name:
                    continue
                if os.path.isfile(os.path.join(fn, '__init__.py')):
                    if not package:
                        new_package = name
                    else:
                        new_package = package + '.' + name
                        stack.append((fn, '', new_package))
                else:
                    stack.append((fn, prefix + name + '/', package))
            else:
                bad_name = False
                for pattern in exclude:
                    if (fnmatchcase(name, pattern)
                        or fn.lower() == pattern.lower()):
                        bad_name = True
                        break
                if bad_name:
                    continue
                out.setdefault(package, []).append(prefix+name)
    return out

setup(name='docassemble.ALKilnInThePlayground',
      version='1.3.0',
      description=('Run ALKiln automated tests on your server, no GitHub account required. Made in collaboration with the SuffolkLITLab Document Assembly Line project.'),
      long_description='# docassemble.ALKilnInThePlayground\r\n\r\nRun ALKiln automated tests on your server, no GitHub account required. Works for any docassemble Project. Made in collaboration with the SuffolkLITLab Document Assembly Line project, but it is unnecessary to install Assembly Line.\r\n\r\nSee guides for writing tests and more about the project at the [ALKiln documentation](https://suffolklitlab.org/docassemble-AssemblyLine-documentation/docs/automated_integrated_testing).\r\n\r\n## Author\r\n\r\nplocket\r\n\r\n',
      long_description_content_type='text/markdown',
      author='plocket',
      author_email='52798256+plocket@users.noreply.github.com',
      license='The MIT License (MIT)',
      url='https://docassemble.org',
      packages=find_packages(),
      namespace_packages=['docassemble'],
      install_requires=[],
      zip_safe=False,
      package_data=find_package_data(where='docassemble/ALKilnInThePlayground/', package='docassemble.ALKilnInThePlayground'),
     )

