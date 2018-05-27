worker_processes 2

pid 'tmp/unicorn.pid'
listen 10842

stderr_path 'log/unicorn_stderr.log'
stdout_path 'log/unicorn_stdout.log'

# timeout 30
timeout 120 # for updating User

preload_app true # ダウンタイムをなしにする

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
