require 'html-proofer'

task :checklinks do
  sh "bundle exec jekyll build"
  options = {
    :log_level => :info,
    :empty_alt_ignore => true,
    :url_ignore => [
      # Skip fragment identifiers, as these are not real links
      '#',
      # Skip httpbin links as they are not allowed from TravisCI
      'http://httpbin.com',
      # Skip links that have been auto-inserted for the 'Edit Source' action (i.e. that match this regexp)
      /github.com\/flutter\/website/
    ],
    :only_4xx => true,
    # Replace canonical link with local links.
    # Details: http://tongueroo.com/articles/getting-html-proofer-to-work-with-canonical-url-for-google-seo/
    :url_swap => {
      'https://flutter.io' => ''
    }
  }
  HTMLProofer.check_directory("./_site", options).run
end

