worker_processes 2

pid     'tmp/unicorn.pid'
listen 10842
# listen  'tmp/unicorn.sock'

stderr_path 'log/foobar_unicorn_stderr.log'
stdout_path 'log/foobar_unicorn_stdout.log'

timeout 30

preload_app true # ダウンタイムをなしにする

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end
