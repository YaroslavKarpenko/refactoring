module DataActions
  def load(file_path)
    return [] unless File.exist?(file_path)

    YAML.load_file(file_path) || []
  end

  def save(file_path, data)
    File.open(file_path, 'w') { |file| file.write(data.to_yaml) }
  end
end
