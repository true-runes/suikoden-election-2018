# frozen_string_literal: true

worker_processes 2
listen 21_080
timeout 30
pid 'tmp/pids/unicorn.development.pid'
stderr_path 'log/unicorn_development_stderr.log'
stdout_path 'log/unicorn_development_stdout.log'

preload_app true

before_fork do |server, _worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # do something...
    end
  end
end

# 再起動失敗対策
# https://qiita.com/zaru/items/ddbb0c029d6c5760dc54
before_exec do |_server|
  ENV['BUNDLE_GEMFILE'] = ENV['BUNDLE_GEMFILE_FOR_DEV']
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
