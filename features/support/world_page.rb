Dir[File.join(File.dirname(__FILE__),'../support/*.rb')].each { |file| require file }
Dir[File.join(File.dirname(__FILE__),'../pages/*')].each { |file| require file }

module Pages
  def base
    @base ||= BaseCalculatorPage.new
  end
  
  def calculator
    @page ||= CalculatorPage.new
  end

  def custom
    @custons ||= AppiumCustom.new
  end

  def assert
    @asserts ||= AssertExtension.new
  end
end