#!/usr/bin/env ruby
require 'net/http'
require 'optparse'
require 'pry'
require 'nokogiri'
require 'thread/pool'

@options = {}
args = OptionParser.new do |opts|
  opts.banner = "Dividendscrape.rb VERSION: 1.0.0 - UPDATED: 1