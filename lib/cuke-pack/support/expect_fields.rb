def expect_fields(object, *fields, &block)
  $stderr.puts "expect_fields deprecated. Use semantic_rails_view_helpers instead."
  @__expect_stack ||= 0
  @__expect_stack += 1

  options = {}

  if fields.last.kind_of?(::Hash)
    options = fields.pop.dup
  end

  search_type = @__expect_stack == 1 ? "#" : "."

  if object.respond_to?(:each)
    within "#{search_type}#{object.first.class.name.underscore.pluralize}" do
      object.each_with_index do |subobject, index|
        expect_fields subobject, fields, options.merge(:index => index), &block
      end
    end
  else
    finder = "#{search_type}#{object.class.name.underscore}"
    if options[:index]
      finder << ":eq(#{options[:index] + 1})"
    end

    within finder do
      fields.flatten.each do |field|
        expect_field field, object.send(field).to_s
      end

      block.call(object) if block
    end
  end

  @__expect_stack -= 1
  @__expect_stack = nil if @__expect_stack == 0
end

def expect_field(field, value)
  find(".#{field}").text.should == value
end
