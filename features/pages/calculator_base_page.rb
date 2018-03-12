# !/usr/bin/env ruby
require './features/pages/android/calculator_page.rb'
require './features/pages/ios/calculator_page.rb'

class BaseCalculatorPage < CalculatorPage

  def add(one, two)
    send_keys elements_calculator[:first_field], one
    send_keys elements_calculator[:second_field], two
    click elements_calculator[:sum_button]
  end
end