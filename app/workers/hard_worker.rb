class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: :default, retry: 1

  def perform(name, count)
    sleep(10)
    puts "Hello #{name}! You have #{count}!"
  end
end
