Around do |scenario, code|
  code.call

  case scenario.exception
  when ActionController::RoutingError
    if class_name = scenario.exception.message[%r{uninitialized constant (.*Controller)}, 1]
      filename = class_name.underscore

      File.open("app/controllers/#{filename}.rb", 'w') { |fh|
        fh.print <<-RB
class #{class_name} < ApplicationController
end
        RB
      }
    end
  when AbstractController::ActionNotFound
    if matches = scenario.exception.message.match(%r{The action '(.*)' could not be found for (.*)Controller})
      _, action, class_name = matches.to_a

      target = Pathname('app/views').join(class_name.underscore).join("#{action}.html.haml")

      if %w{show edit index}.include?(action)
        target.parent.mkpath
        target.open('w') { |fh|
          case action
          when 'show', 'edit'
            fh.puts "##{class_name.underscore.singular}"
          when 'index'
            fh.puts "##{class_name.underscore}= render @#{class_name.underscore}"
          end
        }
      end
    end
  end
end


