require File.dirname(__FILE__) + '/../test_helper'

class WholesaleExtensionTest < Test::Unit::TestCase
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'wholesale'), WholesaleExtension.root
    assert_equal 'Wholesale', WholesaleExtension.extension_name
  end
  
end
