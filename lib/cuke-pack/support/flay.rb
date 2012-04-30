# run flay on your cucumber steps after a successful run. prevent bloat and
# promote reusability!

flay_exception = nil
flay_level = 32 if flay_level == nil
  # set me to a minimum sane level. don't go nuts refactoring!
  # code should be cleaner when you're done, not become spaghetti.

After do |s|
  flay_exception ||= s.exception
end

at_exit do
  if flay_level
    system %{flay -m #{flay_level} features/step_definitions/**/*.rb} if !flay_exception
  end
end

