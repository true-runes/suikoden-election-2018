# TODO: あとで消す
class EverCron
  def self.hello_world
    command = %Q(echo hello_world >> /tmp/foobarworld.txt)
    result = `#{command}`
  end
end
