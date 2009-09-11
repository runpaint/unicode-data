# encoding: utf-8
module UnicodeData

  DATA_DIR = File.join(File.dirname(__FILE__), '../data/')
  FIELDS = [:codepoint, :name, :category, :combining_class, :bidi_class, 
            :decomposition, :digit_value, :non_decimal_digit_value, 
            :numeric_value, :bidi_mirrored, :unicode1_name, :iso_comment,
            :simple_uppercase_map, :simple_lowercase_map, :simple_titlecase_map,
           ]
  NUMERIC_FIELDS = [:digit_value, :non_decimal_digit_value, :numeric_value]
  INDEX_FILE = DATA_DIR + 'UnicodeData.index'
  DATA_FILE =  DATA_DIR + 'UnicodeData.txt'

  def self.data
    @@data ||= File.open DATA_FILE
  end

  def self.offsets
    @@offsets ||= Marshal.load File.binread(INDEX_FILE)
  end

  class Codepoint < Struct.new(*FIELDS)
    def initialize(*args)
      super
      # FIXME: What type to convert to?
      NUMERIC_FIELDS.each { |f| send("#{f}=", send(f).to_r) }
      self.codepoint = self.codepoint.to_i(16)
    end

    def self.from_line(line)
      new *(line.chomp.split ';')
    end
  end

  def self.line(n)
    data.rewind
    offset = offsets[n] or raise ArgumentError
    data.seek offset
    data.readline.chomp
  end

  def self.codepoint(n)
    Codepoint.from_line line(n)
  end

  def self.valid_index?
    !!offsets rescue false
  end

  def self.build_index
    data.rewind
    offsets = {}
    dir = File.dirname INDEX_FILE
    Dir.mkdir(dir) unless Dir.exists?(dir)
    data.lines.map do |line|
      offsets[Codepoint.from_line(line).codepoint] = data.pos - line.size
    end
    File.open(INDEX_FILE, 'wb') { |f| Marshal.dump(offsets, f) }
  end
end
