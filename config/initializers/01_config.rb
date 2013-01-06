config_path = Rails.root.join('config', 'config.yml')

Crosstie::Application.config.app = YAML.load_file(config_path)[Rails.env] if File.exist? config_path

