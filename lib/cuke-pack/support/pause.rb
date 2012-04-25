def pause
  if @pause_ok
    $stdout.puts "Paused. Press [ Return ] to continue."
    $stdin.getc
    $stdout.puts "Resuming..."
  end
end

