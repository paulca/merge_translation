require 'ya2yaml'
class MergeTranslation
  
  attr_accessor :from_file, :to_file, :from, :to
  
  def initialize(options = {})
    self.from = options[:from]
    self.to = options[:to]
    self.from_file = "#{options[:path]}/#{options[:from]}.yml"
    self.to_file = "#{options[:path]}/#{options[:to]}.yml"
  end
  
  def from_translation
    YAML.load_file(from_file)[from.to_s]
  end
  
  def to_translation
    begin
      current_data = YAML.load_file(to_file)
      from_translation.deep_merge(current_data[to.to_s])
    rescue Errno::ENOENT
      return from_translation
    end
  end
  
  def to_restored
    {to.to_s => to_translation}
  end
  
  def to_yaml
    to_restored.ya2yaml
  end
  
  def write!
    data = to_yaml
    File.open(to_file, 'wb') do |file|
      file.write(data)
    end
  end
end