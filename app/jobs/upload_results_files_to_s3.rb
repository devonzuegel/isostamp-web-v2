class UploadResultsFilesToS3 < Que::Job
  def run(hex_base, te_id)
    @hex_base  = hex_base
    @execution = TagfinderExecution.find(te_id)

    puts '============'.red
    ap temp_results_filepaths
    puts '------------'.red
    shell = Shell.new
    temp_results_filepaths.each { |filepath| shell.run("cat #{filepath};") }
    ap JSON.pretty_generate(shell.stdouts.as_json)
    ap JSON.pretty_generate(shell.stderrs.as_json)
    puts '============'.red
  end

  private

  def upload_to_s3(src_filepath, filename)
    file = s3.bucket(ENV['AWS_S3_BUCKET']).object("results/#{@hex_base}/#{filename}")
    file.upload_file(srcfilepath, acl: 'public-read')
    file.public_url # => "https://isostamp-development.s3-us-west-2.amazonaws.com/key"
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

  def temp_results_filepaths
    results_filenames.map { |filename| "#{@hex_base}#{filename}" }
  end

  def s3
    @s3 ||= Aws::S3::Resource.new(
      credentials:  Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']),
      region:       ENV['AWS_BUCKET_REGION']
    )
  end

  def data_filename
    @execution.data_filename(with_extension: false)
  end
end