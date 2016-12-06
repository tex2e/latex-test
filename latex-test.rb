require 'test/unit'

class ReportFormat
  file = ARGV[0]
  raise ArgumentError, 'wrong number of arguments (expected 1)' if file.nil?
  @@text = File.read(file).gsub!(/%.*$/,"")#s.split("\n")
  # p @@text
  def self.get_labels
    @@text.scan(/label[={]([^,\}\]]*)/).flatten.sort.uniq
  end

  def self.get_refs
    @@text.scan(/\\ref{(.*?)}/).flatten.sort.uniq
  end

  def self.get_figs
    @@text.scan(%r{
      \\begin{figure}
      .*?
      \\end{figure}
    }mx)
  end

  def self.get_figs
    @@text.scan(%r{
      \\begin{figure}
      .*?
      \\end{figure}
    }mx)
  end

  def self.get_tables
    @@text.scan(%r{
      \\begin{table}
      .*?
      \\end{table}
    }mx)
  end

  def self.get_sections
    p /\\section{.*}/ === @@text
  end
end

class TestReportFormat < Test::Unit::TestCase
  def test_labels_refs
    assert_equal ReportFormat.get_labels, ReportFormat.get_refs
  end

  def test_figure_contains_label_definition
    ReportFormat.get_figs.each do |fig|
      assert_match /\\label{.*?}/, fig, "\\label is not defined at figure"
    end
  end

  def test_figure_contains_caption_definition
    ReportFormat.get_figs.each do |fig|
      assert_match /\\caption{.*?}/, fig, "\\caption is not defined at figure"
    end
  end

  def test_figure_caption_has_placed_collect_position
    ReportFormat.get_figs.each do |fig|
      assert_match /\\includegraphics.*\\caption{.*?}.*?/m, fig, "in Figure tag, \\caption must be placed after \\includegraphics"
    end
  end

  def test_figure_has_centering
    ReportFormat.get_figs.each do |fig|
      assert_match /center/, fig, "\\figure must be centering"
    end
  end

  def test_table_contains_label_definition
    ReportFormat.get_tables.each do |tab|
      assert_match /\\label{.*?}/, tab, "\\label is not defined at table"
    end
  end

  def test_table_contains_caption_definition
    ReportFormat.get_tables.each do |tab|
      assert_match /\\caption{.*?}/, tab, "\\caption is not defined at table"
    end
  end

  def test_table_caption_has_placed_collect_position
    ReportFormat.get_tables.each do |tab|
      assert_match /\\caption{.*?}.*?\\begin{tabular}/m, tab, "in Table tag, \\caption must be placed behind before \\begin{tabular}"
    end
  end

  def test_table_has_centering
    ReportFormat.get_tables.each do |tab|
      assert_match /center/, tab, "\\table must be centering"
    end
  end

  def test_wrote_with_section
    assert_equal true, ReportFormat.get_sections
  end
end