#!/usr/bin/env ruby
require 'net/http'
require 'optparse'
require 'pry'
require 'nokogiri'
require 'thread/pool'

@options = {}
args = OptionParser.new do |opts|
  opts.banner = "Dividendscrape.rb VERSION: 1.0.0 - UPDATED: 10/19/2015\r\n\r\n"
  opts.banner += "Usage: dividendscrape [options]\r\n\r\n"
  opts.banner += "\texample: ./dividendscrape -s \"PG\"\r\n\r\n"
  opts.on("-s", "--stock [Stock Symbol]", "The ticker symbold for a single stock") { |stock| @options[:stock] = stock }
  opts.on("-S", "--stock-list [Stock File]", "File containing a list of stock symbols") { |stocks| @options[:stocks] = File.open(stocks, "r").read }
  opts.on("-v", "--verbose", "Enables verbose output\r\n\r\n") { |v| @options[:verbose] = true }
end
args.parse!(ARGV)

def get_dividend_info(symbol)
	begin
		stock_uri = URI.parse(get_url(symbol))
		stock_response_page = Net::HTTP.get_response(stock_uri)
		parseable = Nokogiri::HTML(stock_response_page.body)
		if results = parse_results(parseable, symbol)
			output = ""
			results.each { |k, v| output << v.chomp + "\t" }
			puts output
		end
	rescue URI::InvalidURIError => uri_error
		puts "Could not find Dividend information for: #{symbol}" if @options[:verbose]
		return
	end
end

def get_url(symbol)
	search_uri = URI.parse("http://www.divid