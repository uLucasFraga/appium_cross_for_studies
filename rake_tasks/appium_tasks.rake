require 'open4'

###
# Tasks
###

desc 'Abrir o servidor do appium'
task :start_appium_server do
  stop_appium_server
  start_appium_server
end

desc 'Parar o servidor do appium'
task :stop_appium_server do
  stop_appium_server
end

###
# Helpers
###

def stop_node_process(pid:)
  Process.kill('TERM', pid)
end

def stop_appium_server
  `pgrep node`.each_line.map(&:to_i).map { |pid| stop_node_process(pid: pid) }
end

def start_appium_server
  log_filename = File.expand_path('./../../', __FILE__) + '/appium_server.log'

  command = "appium --port 4723 --log #{log_filename} --local-timezone 1>&2"
  puts "Iniciando o servidor appium (log: #{log_filename})"
  Dir.chdir('./') {
    pid, stdin, stdout, stderr = Open4::popen4(command)
    sleep 20

    if pid.zero?
      puts 'O servidor do appium não foi iniciado'
      exit(false)
    else
      puts "O servidor do appium está funcionando com PID: #{pid}"
    end
  }
end