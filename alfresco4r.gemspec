# -*- encoding: utf-8 -*-
require File.expand_path('../lib/alfresco4r', __FILE__)
require File.expand_path('../lib/alfresco4r/version', __FILE__)
#require File.expand_path('../lib/alfresco4r/document_download', __FILE__)
#require File.expand_path('../lib/alfresco4r/document_upload', __FILE__)


Gem::Specification.new do |gem|
  gem.authors       = ["Sivaprakasam Boopathy"]
  gem.email         = ["bsivaprakasam@gmail.com"]
  gem.description   = %q{This gem provides the capability to ruby to interact with Alfresco CMS. This gem is providing two methods upload document to Alfresco and download/retrieve document from Alfresco.}
  gem.summary       = %q{Interaction with Alfresco from Ruby}
  gem.homepage      = "https://github.com/sivaprakasamboopathy/alfresco4r"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "alfresco4r"
  gem.require_paths = ["lib"]
  gem.version       = Alfresco4r::VERSION
end
