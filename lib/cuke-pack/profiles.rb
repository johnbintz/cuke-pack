module CukePack
  class Profiles
    def self.write
      std_opts = "-r features --format #{ENV['CUCUMBER_FORMAT'] || 'pretty'} -f Cucumber::StepWriter --out features/step_definitions --strict"

      in_progress_file = 'in_progress.txt'
      rerun_file = 'rerun.txt'

      in_progress = nil
      if File.file?(in_progress_file)
        in_progress = File.readlines(in_progress_file).first

        if in_progress
          in_progress = nil if in_progress.empty?
        end
      end

      if in_progress
        File.open(rerun_file, 'wb') { |fh| fh.print in_progress }

        wip_opts = %{RERUN_FILE=#{rerun_file} RUN_INPROGRESS=#{in_progress_file} #{std_opts} @#{rerun_file}}
      else
        wip_opts = %{#{std_opts} --tags @wip features}
      end

      headless_driver = ENV['DRIVER'] || 'poltergeist'

      headless_opts = %{DRIVER=#{headless_driver} INPROGRESS=#{in_progress_file} #{std_opts}}

      <<-YML
default: #{headless_opts} features
wip: #{wip_opts}
precommit: #{headless_opts} --tags ~@no-precommit --tags ~@wip:0 features
cleanup: #{headless_opts} -f Cucumber::CleanupFormatter --out unused.txt features
YML
    end
  end
end

