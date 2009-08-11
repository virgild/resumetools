ResumeTools
===========
http://github.com/virgild/resumetools
by Virgil Dimaguila

DESCRIPTION:
------------

ResumeTools is a set of classes and utilities for building resumes and generating
resume documents.


DEPENDENCIES:
-------------

ResumeTools depends on the following Ruby gems:
* extlib
* prawn
* treetop


INSTALLATION:
-------------

ResumeTools can be installed via rubygems:

    $ sudo gem install resumetools


CODE:
-----

The source code is available at:

    http://github.com/virgild/resumetools.git
  
To get the source code using git:

    $ git clone git://github.com/virgild/resumetools.git


USAGE:
------

    # Create a resume
    myresume = ResumeTools::Resume.new
    myresume.full_name = "Albert Einstein"
    myresume.telephone = "(555) 123-4567"
    myresume.address1 = "221 Relativity Circle"
    myresume.address2 = "Princeton, NJ"
    myresume.email = "albert.einstein@science.org"
    
    # Add a section, "Career Goals"
    myresume.create_section do |section|
      section.title = "Career Goals"
      section.para = "Work as a physicist and create a time machine"
    end

EXAMPLES:
---------


LIMITATIONS:
------------


LICENSE:
--------

(The MIT License)

Resume Tools, Copyright (c) 2009 Virgil Dimaguila

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
