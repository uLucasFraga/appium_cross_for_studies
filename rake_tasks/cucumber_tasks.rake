require 'cucumber'
require 'cucumber/rake/task'

###
# Tasks
###

desc 'Executar os testes de aceitação com a plataforma selecionada (ios|android) Ex.: run_acc[android,@calculator]'
task :run_acceptance, :platform, :tags do |_, args|
  platform_check(args)

  tags = ''
  tags = "--tags #{args[:tags]}" unless args[:tags].nil?

  platform = args[:platform]

  Cucumber::Rake::Task.new(:run) do |t|
    puts "--tags @acceptance #{tags} #{set_reporting(platform, true)}"
    t.cucumber_opts = "--tags @acceptance #{tags} #{set_reporting(platform, true)}"
  end

  Rake::Task[:run].invoke
end

desc 'Retornar testes falhados'
task :rerun_failed_tests, :platform do |_, args|
  platform = args[:platform]

  Cucumber::Rake::Task.new(:rerun) do |t|
    puts "#{set_reporting(platform, false)} @#{platform}_rerun.txt"
    t.cucumber_opts = "#{set_reporting(platform, false)} @#{platform}_rerun.txt"
  end

  Rake::Task[:rerun].invoke
end

desc 'Executar teste de aceitação e retornar os testes falhados'
task :acceptance_with_retry, :platform, :tags do |_, args|
  first_successful = run_rake_task('run_acceptance', args[:platform], args[:tags])
  rerun_successful = true

  unless first_successful
    rerun_successful = run_rake_task('rerun_failed_tests', args[:platform], args[:tags])
  end

  puts 'Cucumber testes falhados' unless first_successful || rerun_successful
end

###
# Helpers
###

def run_rake_task(name, platform, tags)
  begin
    Rake::Task[name].invoke(platform, tags)
  rescue StandardError => e
    puts e.to_s
    return false
  end
  true
end

def set_reporting(platform, rerun)
  reporting = "--format pretty --format html --out reports_#{platform}.html "

  reporting + "--format rerun --out #{platform}_rerun.txt" if rerun
end

def platform_check(args)
  raise 'Por favor defina a plataforma (android|ios)' if args.nil? || args[:platform].nil?

  case args[:platform].downcase
  when 'android'
    ENV['PLATFORM_NAME'] = args[:platform]
  when 'ios'
    ENV['PLATFORM_NAME'] = args[:platform]
  else
    raise("Testes não suportados para esta plataforma #{args[:platform]}")
  end
end
