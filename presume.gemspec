Gem::Specification.new do |s|
  s.name        = 'presume'
  s.version     = '0.0.3'
  s.date        = '2015-06-21'
  s.summary     = "A simple resume parsing gem with applicant tracking system technology"
  s.description = "Presume is the only open-source Applicant Tracking System technology for Ruby-on-Rails developers. It works for parsing resumes into the CVSTOM.org resume format, Section >> Header >> Bullets. It then takes an intake of skills or positions, and the minimum experience duration for each skill and position"
  s.authors     = ["Leigh Silverstein"]
  s.email       = 'lsilversteinto@gmail.com'
  s.files = Dir['Gemfile', 'Rakefile', 'sample_resume.docx', 'README.md', 'LICENSE', 'lib/**/*', 'spec/*']
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_dependency "engtagger"
  s.add_dependency "docx"
  s.add_dependency "ruby-stemmer"

  s.homepage    = "https://github.com/l2silver/"
  s.license       = 'MIT'
end
