class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  def source_location(method_name)
    self.method(method_name).source_location rescue "#{method_name} not found"
  end

  def display_source(method_name)
    self.method(method_name).source.display
  end

  def file_entries(character)
    Dir.entries(".").select do |entry|
      entry.start_with?(character)
    end
  end
end
