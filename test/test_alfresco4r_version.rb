# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'alfresco4r/version'

class TestAlfresco4rVersion < Test::Unit::TestCase

  def test_version_number
    assert_equal(Alfresco4r::VERSION, "0.0.2")
  end
  
end
