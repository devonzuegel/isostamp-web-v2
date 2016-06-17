class UploadResultsFilesToS3 < Que::Job
  def run(te_id)
    @execution = TagfinderExecution.find(te_id)

    ActiveRecord::Base.transaction do
      paths_and_names.each do |tmp_filepath, filename|
        create_and_upload_results_file!(tmp_filepath, filename)
      end
      destroy
    end
  end

  private

  def create_and_upload_results_file!(tmp_filepath, filename)
    results_file = ResultsFile.create!({
      tmp_filepath:        tmp_filepath,
      filename:            filename,
      tagfinder_execution: @execution
    })
    puts "Enqueuing results_file ##{results_file.id} [#{filename}]...".yellow
    puts "QueJob.count = #{QueJob.count}".yellow
    UploadResultsFileToS3.enqueue(results_file.id)
  end

  def data_filename
    @execution.data_filename(with_extension: false)
  end

  def results_filenames
    [
      "#{data_filename}_chart.txt",
      "#{data_filename}_filter_log.txt",
      "#{data_filename}_filter_log2.txt",
      "#{data_filename}_filtered.mzxml",
      "#{data_filename}_massspec.csv",
      "#{data_filename}_summary.txt",
    ]
  end

  def paths_and_names
    temp_results_filepaths = results_filenames.map { |filename| "./tmp/#{@execution.hex_base}-#{filename}" }
    temp_results_filepaths.zip(results_filenames)
  end
end