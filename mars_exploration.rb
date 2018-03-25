require_relative 'lib/mars_rovers'

inputs = File.expand_path('input.txt', __dir__)

puts
puts 'Welcome to the mars exploration!'
puts
puts '               .                                            .               '
puts '     *   .                  .              .        .   *          .        '
puts '  .         .                     .       .           .      .        .     '
puts '        o                             .                   .                 '
puts '         .              .                  .           .                    '
puts '          0     .                                                           '
puts '                 .          .                 ,                ,    ,       '
puts ' .          \          .                         .                          '
puts '      .      \   ,                                                          '
puts '   .          o     .                 .                   .            .    '
puts '     .         \                 ,             .                .           '
puts '               #\##\#      .                              .        .        '
puts '             #  #O##\###                .                        .          '
puts '   .        #*#  #\##\###                       .                     ,     '
puts '        .   ##*#  #\##\##               .                     .             '
puts '      .      ##*#  #o##\#         .                             ,       .   '
puts '          .     *#  #\#     .                    .             .          , '
puts '                      \          .                         .                '
puts '____^/\___^--____/\____O______________/\/\---/\___________---______________ '
puts '   /\^   ^  ^    ^                  ^^ ^  \ ^          ^       ---          '
puts '         --           -            --  -      -         ---  __       ^     '
puts '   --  __                      ___--  ^  ^                         --  __   '
puts
puts
puts 'Please please replace your input inside input.txt *jumping lines included and press enter'
puts
gets.chomp
puts 'Here is your output :'
input = File.read(inputs)
puts
puts '=========='
puts
puts MarsRovers.new(input).rover_locator
puts
puts '=========='
puts
puts 'Thank you for use the mars rovers! Press enter to exit'
gets.chomp
