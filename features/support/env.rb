require 'appium_lib'
require 'cucumber'
require 'selenium-webdriver'

$wait = Selenium::WebDriver::Wait.new(:timeout => 60)

def load_appium_configuration(platform)
  Appium.load_appium_txt :file => File.expand_path("#{Dir.pwd}/config/#{platform}/appium.txt", __FILE__), verbose: true
end

def load_module(path)
  Dir[path].each { |file| require file }
end

if ENV['PLATFORM_NAME'].nil?
  raise 'Por favor defina a variavel de ambiente PLATFORM_NAME, como: export PLATFORM_NAME=android'
else
  env = ENV['PLATFORM_NAME'].downcase
end

case env
when 'android'
  caps = load_appium_configuration(env)
  caps[:appium_lib][:export_session] = true
when 'ios'
  caps = load_appium_configuration(env)
  caps[:appium_lib][:export_session] = true
else
  raise("Plataforma não suportada #{ENV['PLATFORM_NAME']}")
end

World(Pages)

Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object