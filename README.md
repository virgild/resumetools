ResumeTools
===========

http://codaset.com/virgil/resumetools

DESCRIPTION:
------------

ResumeTools is a set of simple classes and utilities for building basic resumes and generating
resume documents.

### Structure of a Resume

A `resume` is a document that has personal info, and a list of `sections`. The personal info
has contact information like telephone number, e-mail address, and home address. Sections
are the main divisions in the resume document (e.g., Objectives, Experience, Education).

#### Header and Personal Info

The resume header has the person's name and contact information. The header has the following
properties:

* `full_name`
* `telephone`
* `email`
* `address1`
* `address2`
* `url`

#### Sections

Sections are the main divisions of a resume. Each section has a `title`, and can have
the following properties:

* List of `items`
* List of `periods`
* A `paragraph`

#### Periods

`Periods` are any information that has a date and a location. Each period has a `title`,
and can have the following properties:

* `organization`
* `location`
* `date started` and `date ended`
* A list of `items`

#### Items

An item is simple text information that is part of a `items` list.


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

    http://codaset.com/virgil/resumetools
  
To get the source code using git:

    $ git clone git://codaset.com/virgil/resumetools.git


USAGE:
------

Building a resume model

    require 'resumetools'

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

Example of a resume text format:

    #N Thomas B. Seeker
    #A 1234 Northern Star Circle
    #A Baltimore, MD 12345
    #T (410) 555-1212
    #E seeker@nettcom.com
    #U http://nettcom.com/tseeker
  
    = Qualifications Summary
    ---
    Nine years of experience in designing, installing, and troubleshooting 
    computing systems; a proven track record in identifying problems and 
    developing innovative solutions.
    ---
    
    = Technical Skills

    - PROGRAMMING: C, C++, Visual BASIC, FORTRAN, Pascal, SQL, OSF/Motif, 
      UNIX Shell Script (sh, ksh, csh), BASIC, Clipper, Algol 68, and 80X86 Assembler.

    - OPERATING SYSTEMS: UNIX (bsd & SVr3/r4), MS Windows, MS DOS, MS Windows NT, 
      Solaris, HP-UX, Ultrix, AIX, VAX/VMS, and Macintosh System 7.

    = Professional Experience
    
    + Systems Engineer
    >O Computer Engineering Corporation
    >L Los Angeles, CA
    >D 1993 to Present
    - Provide systems engineering, software engineering, technical consulting, and 
      marketing services as a member of the Systems Integration Division of a 
      software engineering consulting company.
  
    + Systems Analyst
    >O Business Consultants, Inc.
    >L Washington, DC
    >D 1990 to 1993
    - Provided technical consulting services to the Smithsonian Institute's 
      Information Technology Services Group, Amnesty International, and
      internal research and development initiatives.
    
    = Education

    + Computer Systems Technology Program
    >O Air Force Institute of Technology (AFIT)

    + BS, Mathematics/Computer Science
    >O University of California, Los Angeles (UCLA)
    
    = Specialized Training

    - Database Administration, Performance Tuning, and Benchmarking with 
      Oracle7; Oracle Corporation.
    - Software Requirements Engineering and Management Course; 
      Computer Applications International Corporation.
    - X.400 Messaging and Allied Communications Procedures-123 Profile;
      ComTechnologies, Inc.

See the `examples` directory for a sample resume text and its generated
PDF document.
    

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
