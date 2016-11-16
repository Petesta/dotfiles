require 'logger'
require 'net/http'

module Valid
  extend self

  LOGGER = Logger.new(STDOUT)
  LOGGER.level = Logger::WARN

  def readme
    File.read('README.md')
  rescue Errno::ENOENT
    LOGGER.info("File doesn't exist")
  end

  def urls
    readme.split("\n").select { |line| line.include?('| [') }.map { |line| line[/\((.*?)\)/m, 1] }
  end

  def valid_url?(url)
    response = Net::HTTP.get_response(URI(url))
    response.code == '200'
  rescue Errno::ECONNREFUSED
    LOGGER.info("Couldn't reach url: #{url}")
    false
  end

  def valid_urls?
    urls.any? { |a| !valid_url?(a) }
  end
end
