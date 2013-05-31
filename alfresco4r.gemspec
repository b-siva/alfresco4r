# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'alfresco4r/version'
require 'alfresco4r/document_download'
require 'alfresco4r/document_upload'


Gem::Specification.new do |gem|
  gem.authors       = ["Sivaprakasam Boopathy"]
  gem.email         = ["bsivaprakasam@gmail.com"]
  gem.description   = %q{This gem provides the capability to ruby to interact with Alfresco CMS. This gem is providing two methods upload document to Alfresco and download/retrieve document from Alfresco.}
  gem.summary       = %q{Interaction with Alfresco from Ruby}
  gem.homepage      = "https://github.com/sivaprakasamboopathy/alfresco4r"

  gem.files         =  Dir.glob("lib/*/*.rb")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "alfresco4r"
  gem.require_paths = ["lib", "lib/alfresco4r"]
  gem.version       = Alfresco4r::VERSION
end
