# Presume

A resume parser coupled with fundamental Applicant Tracking System Technology

### Description

Presume is the first open-source Applicant Tracking System technology for Ruby-on-Rails developers. It works by parsing the resume into the CVSTOM.org resume format Section >> Header >> Bullets, and then taking an input of skills and their expected duration to check for in that resume. 

### Features

Parse resumes
Checks resumes for specific skills, positions, and their duration

### Resume Parser:

    require 'presume'

    # Sample input
    resume_text = "Leigh Silverstein\n123 Ave.\n\nWork Experience\nProject Coordinator"

    # Parse resume with string input
    presume = Presume.new(resume_text)

    # Retrieve Sections
    Presume.sections

    #=> {0 => SectionObject1, 1 => SectionObject2}

    # SectionObject Functions
    
    SectionObject.text

    #=> "Work Experience"

    SectionObject.children

    #=> [ HeaderObject1, HeaderObject2 ]

    # HeaderObject Functions

    SectionObject.text

    #=> "Project Coordinator, Projects4Ever Inc., Toronto, Ontario, Jan 2011-Jul 2012

    SectionObject.duration

    #=> 1.5 (In Years)

    SectionObject.start_time_text

    #=> Jan 2011

    SectionObject.end_time_text

    #=> Jul 2012

    HeaderObject.children

    #=> [ BulletObject1, BulletObject2 ]

    # BulletObject inherits all functions from the HeaderObject except children


### ATS:

    # After parsing a resume

    # Checking for certain position or education ("name", expected_minimum_duration_in_years)
    intake_hash = {"Project Coordinator|Project Assistant" => 1, "Bachelors Finance|BF|B.F." => 4}

    # Check for positions
    presume.positions?(intake_hash)
    
    #=> {"Project Coordinator|Project Assistant" => [ MatchedHeaderObject1 ], "Bachelors Finance|BF|B.F." => [ MatchedHeaderObject2 ]}

    # Checking for certain skills ("name", expected_minimum_duration_in_years)
    intake_hash = {"database management" => 1, "clear communication" => 0}

    # Check for positions
    presume.skills?(intake_hash)

    #=> {"database management" => [ MatchedBulletObject1 ], "clear communication" => [ MatchedBulletObject2 ]}

    #Note that matched headers and bullets are the same classes as the headers and bullets discussed in the resume parsing section
    
### Requirements

* EngTagger
* Ruby-Stemmer
* Docx (for testing)

### Install

    (sudo) gem install presume

### Author

of this Ruby library 

* Leigh Silverstein (lsilversteinto [at] gmail.com) 

### License

This library is distributed under the GPL.  Please see the LICENSE file.
