require 'html-proofer'

task :checklinks do
  sh "bundle exec jekyll build"
  options = {
    :log_level => :info,
    :empty_alt_ignore => true,
    :url_ignore => [
      '#',
      'http://httpbin.com'
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

