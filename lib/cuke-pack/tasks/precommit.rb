namespace :cuke_pack do
  desc "Run cucumber in precommit mode"
  task :precommit do
    system %{cucumber -p precommit}

    if $?.exitstatus != 0
      raise StandardError.new("cucumber failed")
    end
  end
end
