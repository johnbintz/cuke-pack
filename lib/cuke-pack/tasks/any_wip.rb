namespace :cuke_pack do
  desc "Raise an exception if any tasks are marked @wip"
  task :any_wip do
    require 'gherkin/parser/parser'
    require 'gherkin/formatter/json_formatter'
    require 'gherkin/formatter/tag_count_formatter'

    io = StringIO.new
    counts = {}
    json_formatter = Gherkin::Formatter::JSONFormatter.new(io)
    formatter = Gherkin::Formatter::TagCountFormatter.new(json_formatter, counts)
    parser = Gherkin::Parser::Parser.new(formatter)

    Dir['features/**/*.feature'].each do |file|
      parser.parse(File.read(file), file, 0)
    end

    if counts['@wip']
      raise StandardError.new("@wip occurred in the following files:\n#{counts['@wip'].join("\n")}")
    end
  end
end

