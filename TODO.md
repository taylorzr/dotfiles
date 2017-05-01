[ ] move this repo to a directory in taylorzr.github.io
    This would be a one stop show for notes, todos, towrites, blog posts,
    and dotfiles

[ ] project function: if no project exists, ask is you want to create a project

[ ] indentation fixes for ruby
    # Align by variable, not condition
    some_var = if
      this # this defaults to indent from the "if"
    else
      that
    end
    # Complex rspec indentation
    expect(something).to have_received(:some_method)
      .with(
        some_argument: :some_value, # This defaults to no indentation
      )

---

[x] shell function for easily creating a new session in a project
directory
