class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    input_html_classes.unshift("datepicker form-control")

    merged_input_options = merge_wrapper_options(input_options,
                                                 wrapper_options)
    out = ActiveSupport::SafeBuffer.new
    out << template.content_tag(:span, set_icon.html_safe,
                                class: "input-group-addon")
    out << @builder.text_field(attribute_name, merged_input_options)
  end

  private

  def input_options
    input_html_options[:type] ||= input_type if html5?
    input_html_options[:placeholder] ||= "yyyy-mm-dd"
    input_html_options
  end

  def set_icon
    case input_html_options[:icon]
    when :fa # font-awesome
      return "<i class='fa fa-calendar'></i>"
    when :bs # bootstrap glyphs
      return "<span class='glyphicon glyphicon-calendar'></span>"
    when :fi # foundation
      return "<i class='fi-calendar'></i>"
    else     # default
      return "<span>Date</span>"
    end
  end
end
