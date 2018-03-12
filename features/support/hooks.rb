Before do
  $driver.start_driver
end

After do |scenario|
  scenario_name = scenario.name.gsub(/\s+/, '_').tr('/', '_')
  scenario_name = scenario_name.delete(',', '')
  scenario_name = scenario_name.delete('(', '')
  scenario_name = scenario_name.delete(')', '')
  scenario_name = scenario_name.delete('#', '')

  if scenario.passed?
    unless File.directory?('results/screenshots/test_passed')
      FileUtils.mkdir_p('results/screenshots/test_passed')
    end
    screenshot_name = "#{scenario_name.downcase!}.png"
    screenshot_file = File.join('results/screenshots/test_passed',
                                screenshot_name)
    $driver.screenshot(screenshot_file)
    embed(screenshot_file, 'image/png')
  elsif scenario.failed?
    unless File.directory?('results/screenshots/test_failed')
      FileUtils.mkdir_p('results/screenshots/test_failed')
    end
    screenshot_name = "#{scenario_name.downcase!}.png"
    screenshot_file = File.join('results/screenshots/test_failed',
                                screenshot_name)
    $driver.screenshot(screenshot_file)
    embed(screenshot_file, 'image/png')
  end
end

AfterConfiguration do
  FileUtils.rm_r('results/screenshots/test_failed/') if File.directory?(
    'results/screenshots/test_failed/'
  )
  FileUtils.rm_r('results/screenshots/test_passed/') if File.directory?(
    'results/screenshots/test_passed/'
  )
end
