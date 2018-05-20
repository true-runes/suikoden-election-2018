class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    sleep(10)
    puts '10sec done!'
  end
end
