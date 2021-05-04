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
  opts.on("-S