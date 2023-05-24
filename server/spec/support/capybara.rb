# frozen_string_literal: true

require 'capybara/rspec'
require "rack/handler/puma"


CAPYBARA_WINDOW_SIZE = [1680, 1200].freeze
# port and url to webpack server
WEB_TEST_PORT = '4200'.freeze
WEB_TEST_URL = "http://localhost:#{WEB_TEST_PORT}".freeze

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument('headless') if ENV['HEADLESS'] == '1'
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-gpu')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--lang=fr')
  options.add_argument("--window-size=#{CAPYBARA_WINDOW_SIZE.join(',')}")
  options.add_preference('intl.accept_languages', 'fr,fr_FR')

  client = Selenium::WebDriver::Remote::Http::Default.new
  client.read_timeout = 60

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options,
    http_client: client
  )
end

def capybara_wait_for_ng_server
  10.times.each do |_|
    begin
      Net::HTTP.get(URI(WEB_TEST_URL))
      return
    rescue Errno::ECONNREFUSED
      sleep 1
    end
  end
end


Capybara.register_server :ng_server do |app, port, host|
  # run webpack server using childprocess gem
  process = ChildProcess.build('npx', 'ng', 'serve')
  # process.io.inherit! # uncomment for debugging
  process.environment['WEB_PORT'] = WEB_TEST_PORT
  process.environment['API_URL'] = "#{host}:#{port}"
  process.cwd = Rails.root.join('../client')
  process.leader = true
  process.detach = true
  begin
    Net::HTTP.get(URI(WEB_TEST_URL))
  rescue
    process.start
    at_exit { process.stop unless process.exited? }
    capybara_wait_for_ng_server
  end

  # run the Rails API server
  options = { Host: host, Port: port, Threads: "0:4", Silent: true }
  Rack::Handler::Puma.run(app, options)
end

  # use a javascript driver
Capybara.default_driver = :headless_chrome
Capybara.javascript_driver = :headless_chrome

  # use the custom server
Capybara.server = :ng_server
Capybara.run_server = true
Capybara.app_host = WEB_TEST_URL
Capybara.server_port = 3000
