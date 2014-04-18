# after tests fail, re-run only failed scenarios, but one at a time so as not to oeverwhelm

in_progress = []
any_failed = false

if ENV['INPROGRESS']
  File.unlink(ENV['INPROGRESS']) if File.file?(ENV['INPROGRESS'])
end

After do |s|
  if s.failed? || s.status == :pending
    if ENV['INPROGRESS']
      begin
        source = s
        if source.respond_to?(:scenario_outline)
          source = source.scenario_outline
        end

        if source.respond_to?(:feature)
          feature = source.feature

          in_progress << feature.file_colon_line.gsub(/\:\d+/, ":" + feature.line.to_s)
        end
      rescue => e
        puts e.message
        puts e.backtrace.join("\n")
      end
    end

    if ENV['RUN_INPROGRESS']
      any_failed = true
    end
  end
end

at_exit do
  include Cucumber::Term::ANSIColor

  if ENV['INPROGRESS'] and !in_progress.empty?
    File.open(ENV['INPROGRESS'], 'wb') { |fh| fh.print in_progress.join("\n") }

    puts red("*** Failing scenarios described in #{ENV['INPROGRESS']}. Run using the wip profile until they're fixed. ***")
  end

  if ENV['RUN_INPROGRESS']
    if !any_failed
      lines = File.readlines(ENV['RUN_INPROGRESS'])
      passed = lines.shift

      if lines.empty?
        File.unlink(ENV['RUN_INPROGRESS'])
        File.unlink(ENV['RERUN_FILE'])

        puts green("*** You're done! All failed features have passed. ***")
      else
        File.open(ENV['RUN_INPROGRESS'], 'wb') { |fh| fh.print lines.join('') }

        puts yellow("*** Still working - #{lines.length} feature#{lines.length == 1 ? '' : 's'} to go! ***")
      end
    end
  end
end

