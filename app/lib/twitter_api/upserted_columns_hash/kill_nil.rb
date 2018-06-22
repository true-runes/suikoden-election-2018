module TwitterApi::UpsertedColumnsHash::KillNil
  def kill_nil(checked_object, default_value: 'DEFAULT_VALUE')
    checked_object.nil? ? default_value : checked_object
  end
end
