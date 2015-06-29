  def regex_cities
    @regex_cities ||= Regexp.new("([a-z]{2,} ){0,3}[a-z]{2,}\\, " + "\\b(AK|Alaska|AL|Alabama|AR|Arkansas|AZ|Arizona|CA|California|CO|Colorado|CT|Connecticut|DE|Delaware|FL|Florida|GA|Georgia|HI|Hawaii|IA|Iowa|ID|Idaho|IL|Illinois|IN|Indiana|KS|Kansas|KY|Kentucky|LA|Louisiana|MA|Massachusetts|MD|Maryland|ME|Maine|MI|Michigan|MN|Minnesota|MO|Missouri|MS|Mississippi|MT|Montana|NC|North Carolina|ND|North Dakota|NE|Nebraska|NH|New Hampshire|NJ|New Jersey|NM|New Mexico|NV|Nevada|NY|New York|OH|Ohio|OK|Oklahoma|OR|Oregon|PA|Pennsylvania|RI|Rhode Island|SC|South Carolina|SD|South Dakota|TN|Tennessee|TX|Texas|UT|Utah|VA|Virginia|VT|Vermont|WA|Washington|WI|Wisconsin|WV|West Virginia|WY|Wyoming|AB|Alberta|BC|British Columbia|MB|Manitoba|NB|New Brunswick|NL|Newfoundland and Labrador|NS|Nova Scotia|ON|Ontario|PE|Prince Edward Island|QC|Quebec|SK|Saskatchewan)" + "\\b", "i")
  end

  def regex_professions
    @regex_professions ||= Regexp.new('([A-Z][a-z]* ){0,5}(coordinator|assistant|asst|manager|director|technician|analyst|associate|developer|programmer|nurse|consutlant|worker|clerk|receptionist|secretary|teacher|engineer|administrator|researcher|head of|admin|intern|database|leader|server|waitress|waiter|busboy)\b(\.|)( [A-Z][a-z]*){0,5}', 'i')
  end 

  def regex_schools
    @regex_schools ||= Regexp.new("([a-z]{1,} ){0,5}(university|college)\\b(( [a-z]{1,}){0,5}|)", "i")
  end

  def regex_companies
    @regex_companies ||= Regexp.new(/(([A-Z][a-z]* )*and ([A-Z][a-z]* )*|([A-Z][a-z]* )*)(Inc|INC|Corp|CORP|CO|Co|LTD|Ltd)\b(\.|)/)
  end
 
  def regex_address
    @regex_address ||= Regexp.new("\\d (\\w{2,} ){1,2}(Alley|ALY|Annex|ANX|Arcade|ARC|Avenue|AVE|Bayou|YU|Beach|BCH|Bend|BND|Bluff|BLF|Bottom|BTM|Boulevard|BLVD|Branch|BR|Bridge|BRG|Brook|BRK|Burg|BG|Bypass|BYP|Camp|CP|Canyon|CYN|Cape|CPE|Causeway|CSWY|Center|CTR|Circle|CIR|Cliffs|CLFS|Club|CLB|Corner|COR|Corners|CORS|Course|CRSE|Court|CT|Courts|CTS|Cove|CV|Creek|CRK|Crescent|CRES|Crossing|XING|Dale|DL|Dam|DM|Divide|DV|Drive|DR|Estates|EST|Expressway|EXPY|Extension|EXT|Fall|FALL|Falls|FLS|Ferry|FRY|Field|FLD|Fields|FLDS|Flats|FLT|Ford|FOR|Forest|FRST|Forge|FGR|Fork|FORK|Forks|FRKS|Fort|FT|Freeway|FWY|Gardens|GDNS|Gateway|GTWY|Glen|GLN|Green|GN|Grove|GRV|Harbor|HBR|Haven|HVN|Heights|HTS|Highway|HWY|Hill|HL|Hills|HLS|Hollow|HOLW|Inlet|INLT|Island|IS|Islands|ISS|Isle|ISLE|Junction|JCT|Key|CY|Knolls|KNLS|Lake|LK|Lakes|LKS|Landing|LNDG|Lane|LN|Light|LGT|Loaf|LF|Locks|LCKS|Lodge|LDG|Loop|LOOP|Mall|MALL|Manor|MNR|Meadows|MDWS|Mill|ML|Mills|MLS|Mission|MSN|Mount|MT|Mountain|MTN|Neck|NCK|Orchard|ORCH|Oval|OVAL|Park|PARK|Parkway|PKY|Pass|PASS|Path|PATH|Pike|PIKE|Pines|PNES|Place|PL|Plain|PLN|Plains|PLNS|Plaza|PLZ|Point|PT|Port|PRT|Prairie|PR|Radial|RADL|Ranch|RNCH|Rapids|RPDS|Rest|RST|Ridge|RDG|River|RIV|Road|RD|Row|ROW|Run|RUN|Shoal|SHL|Shoals|SHLS|Shore|SHR|Shores|SHRS|Spring|SPG|Springs|SPGS|Spur|SPUR|Square|SQ|Station|STA|Stravenues|STRA|Stream|STRM|Street|ST|Summit|SMT|Terrace|TER|Trace|TRCE|Track|TRAK|Trail|TRL|Trailer|TRLR|Tunnel|TUNL|Turnpike|TPKE|Union|UN|Valley|VLY|Viaduct|VIA|View|VW|Village|VLG|Ville|VL|Vista|VIS|Walk|WALK|Way|WAY|Wells|WLS)(\\b|\\.\\b)", "i")
  end

  def regex_phone
    @regex_phone ||= Regexp.new("\\d\\d\\d(|\\))(| |-)(\\(|)\\d\\d\\d(|\\))(| |-)\\d\\d\\d\\d", "i")    
  end

  def regex_email
    @regex_email ||= Regexp.new("\\b(\\w){1,}@(\\w){1,}\\.(\\w){1,5}\\b", "i")
  end

  def regex_dates
    @regex_dates ||= Regexp.union(regex_dates_1, regex_dates_2)
  end

  def regex_dates_1
    @regex_dates_1 ||= Regexp.new("((January|Jan|March|Mar|May|May|July|Jul|September|Sep|Sept|November|Nov|February|Feb|April|Apr|June|Jun|August|Aug|October|Oct|December|Dec|Winter|Fall|Summer|Spring)( |)(\\d{2}\\b|\\d{4}\\b)( |)(–|-|to)( |)((January|Jan|March|Mar|May|May|July|Jul|September|Sep|Sept|November|Nov|February|Feb|April|Apr|June|Jun|August|Aug|October|Oct|December|Dec|Winter|Fall|Summer|Spring)( |)(\\d{2}\\b|\\d{4}\\b)|present|current|today)|(January|Jan|March|Mar|May|May|July|Jul|September|Sep|Sept|November|Nov|February|Feb|April|Apr|June|Jun|August|Aug|October|Oct|December|Dec|Winter|Fall|Summer|Spring)( |)(\\d{2}\\b|\\d{4}\\b))", "i")
  end

  def regex_dates_2
    @regex_dates_2 ||= Regexp.new("((\\d{2}\\b)(| )(–|-|to)(| )(\\d{2}\\b|present\\b)|(\\d{4}\\b)(| )(–|-|to)(| )(\\d{4}\\b|present\\b))", "i")
  end

  def regex_month
    @regex_month ||= Regexp.new('January|Jan|March|Mar|May|May|July|Jul|September|Sep|Sept|November|Nov|February|Feb|April|Apr|June|Jun|August|Aug|October|Oct|December|Dec', 'i')    
  end

  def regex_season
    @regex_season ||= Regexp.new('Winter|Fall|Summer|Spring', 'i')
  end

  def regex_year
    @regex_year ||= Regexp.new('\b\d\d\d\d\b|\b\d\d\b', 'i')
  end

  def regex_section
    @regex_section ||= Regexp.new("([a-z]* ){0,5}(highlight|professional development|summary|experience|skills|education|qualifications|interests|profile)( [a-z]*){0,5}", "i")
  end

  def regex_new_lines_and_blanks
    @regex_new_lines ||= Regexp.new(/\n\n\n\n|\n\n\n|\n\n|\n|   /)
  end

  def regex_engtagger_verbs
    @regex_engtagger_verbs ||= Regexp.new(/<vb[a-z]{0,1}>/)
  end

  def regex_separate_tabbed_words
    @regex_separate_tabbed_words ||= Regexp.new('(?<=[A-Za-z])(?=\d)|(?<=[a-z])(?=[A-Z])|(?<=\d)(?=[A-Za-z])')
  end

  def regex_remove_extra_spaces
    @regex_remove_extra_spaces ||= Regexp.new('(?<=  ) ')
  end

  def regex_characters_and_digits
    Regexp.new(/[A-Za-z]|\d/)
  end

  def regex_current
    @regex_current ||= Regexp.new('current|present|today', 'i')
  end