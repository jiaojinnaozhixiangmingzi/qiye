SimpleForm.setup do |config|
  config.wrappers(:date_picker, tag: "div", class: "form-group", error_class: "has-error") do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: "control-label"

    b.wrapper tag: "div" do |ba|
      ba.wrapper tag: "div", class: "input-group" do |append|
        append.use :input
      end
      ba.use :error, wrap_with: { tag: "span", class: "help-block" }
      ba.use :hint,  wrap_with: { tag: "p", class: "help-block" }
    end
  end
end
