# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require "rubygems"
require 'bundler'
require 'motion-cocoapods'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Matrix'
  task :"build:simulator" => :"schema:build"
  app.pods do
    pod 'ILTranslucentView', :git => 'https://github.com/ivoleko/ILTranslucentView.git'
  end
end
