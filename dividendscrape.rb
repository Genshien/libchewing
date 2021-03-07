#!/usr/bin/env ruby
require 'net/http'
require 'optparse'
require 'pry'
require 'nokogiri'
require 'thread/pool'

@options = {}
args = OptionParser.new do |opts|
  opts.banner = "Dividend