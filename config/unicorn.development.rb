worker_processes 2
listen 21080
timeout 30
pid 'tmp/pids/unicorn.development.pid'
stderr_path 'log/unicorn_development_stderr.log'
stdout_path 'log/unicorn_development_stdout.log'

preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # do something...
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
