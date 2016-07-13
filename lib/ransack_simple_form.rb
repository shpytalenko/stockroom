def ransack_simple_form_for(*args, &block)
      opts = args.extract_options!
      opts[:builder] = FormBuilder
      # add the default form class
      # (works whether existing class is a String like
      # "foo bar" or an Array like ["foo", "bar"])
      opts[:html] ||= {}
      opts[:html][:class] ||= []
      opts[:html][:class] << ' ' if opts[:html][:class].is_a? String
      opts[:html][:novalidate] ||= true
      search_form_for(*args, opts, &block)
    end
