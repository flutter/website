module Jekyll

  ##
  # Used with permission. Based on code posted at
  # biosphere.cc/software-engineering/jekyll-breadcrumbs-navigation-plugin/.
  #
  # Patch Jekyll's Page class
  class Page

    ##
    # We add a custom method to the page variable, that returns an ordered list of its
    # parent pages ready for iteration.
    def ancestors
      # STDERR.puts "---------"
      a = []
      url = self.url
      # STDERR.puts "Page is #{url.inspect}"
      if url.split(".")[-1] == "html" # ignore .css, .js, ...
        while url != "/index.html"
          pt = url.split("/")
          if pt.length <= 2 then
            url = "/index.html"
          else
            if pt[-1] != "index.html" then
              # go to directory index
              pt[-1] = "index.html"
              url = pt.join("/")
            else
              # one level up
              url = pt[0..-3].join("/") + "/index.html"
            end

            # skip homepage
            if url != "/index.html" then
              potential_page = get_page_from_url(url)

              # skip missing index.html pages
              if defined? potential_page.name then
                a << potential_page
              end
            end
          end
        end

        if a != nil then
          return a.reverse
        else
          return nil
        end
      end
    end

    ##
    # Make ancestors available in liquid
    alias orig_to_liquid to_liquid
    def to_liquid
      h = orig_to_liquid
      h['ancestors'] = self.ancestors
      return h
    end

    private

    ##
    # Gets Page object that has given url. Very efficient O(n) solution.
    def get_page_from_url(url)
      site.pages.each do |page|
        if page.url == url then
          return page
        end
      end
    end
  end
end


module Drops
  class BreadcrumbItem < Liquid::Drop
    extend Forwardable

    def_delegator :@page, :data
    def_delegator :@page, :url

    def initialize(page, payload)
      @payload = payload
      @page = page
    end

    def title
      @page.data["breadcrumb"] || @page.data["short-title"] || @page.data["title"]
    end

    def subset
      @page.data["subset"]
    end
  end
end


Jekyll::Hooks.register :pages, :pre_render do |page, payload|
  drop = Drops::BreadcrumbItem

  if page.url == "/"
    then payload["breadcrumbs"] = [
      drop.new(page, payload)
    ]
  else
    payload["breadcrumbs"] = []
    pth = page.url.split("/")

    0.upto(pth.size - 1) do |int|
      joined_path = pth[0..int].join("/")
      item = page.site.pages.find { |page_| joined_path == "" && page_.url == "/" || page_.url.chomp("/") == joined_path }
      payload["breadcrumbs"] << drop.new(item, payload) if item
    end
  end
end

Jekyll::Hooks.register :documents, :pre_render do |documents, payload|
  drop = Drops::BreadcrumbItem

  if documents.url == "/"
    then payload["breadcrumbs"] = [
      drop.new(documents, payload)
    ]
  else
    payload["breadcrumbs"] = []
    pth = documents.url.split("/")

    0.upto(pth.size - 1) do |int|
      joined_path = pth[0..int].join("/")
      item = documents.site.documents.find { |documents| joined_path == "" && documents.url == "/" || documents.url.chomp("/") == joined_path }
      payload["breadcrumbs"] << drop.new(item, payload) if item
    end
  end
end
